#!/usr/bin/env bash
# pix.watermark update check — emits one-line JSON, and optionally notifies.
#
# Always exits 0. A failed check must never stop the overlay from loading, so
# every failure ends up in the "error" field instead of the exit status.
#
#   check-update.sh            report only
#   check-update.sh --notify   report, and pop a desktop notification if the
#                              installed version is behind the published one
set -uo pipefail

REPO="pxllbt/watermark"
BRANCH="main"
RAW_URL="https://raw.githubusercontent.com/${REPO}/${BRANCH}/manifest.json"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PLUGIN_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"

STATE_DIR="${XDG_STATE_HOME:-$HOME/.local/state}/omarchy"
NOTIFIED_FILE="$STATE_DIR/watermark-update-notified"

emit() {
  jq -nc \
    --argjson update_available "$1" \
    --arg current_version "$2" \
    --arg new_version "$3" \
    --arg current_commit "$4" \
    --arg new_commit "$5" \
    --argjson commits_behind "$6" \
    --arg error "$7" \
    '{
      update_available: $update_available,
      current_version: $current_version,
      new_version: $new_version,
      current_commit: $current_commit,
      new_commit: $new_commit,
      commits_behind: $commits_behind,
      error: $error
    }'
}

current_version="0.0.0"
current_commit=""
if [[ -f "$PLUGIN_DIR/manifest.json" ]]; then
  current_version=$(jq -r '.version // "0.0.0"' "$PLUGIN_DIR/manifest.json" 2>/dev/null || echo "0.0.0")
fi
if git -C "$PLUGIN_DIR" rev-parse --git-dir >/dev/null 2>&1; then
  current_commit=$(git -C "$PLUGIN_DIR" rev-parse --short HEAD 2>/dev/null || echo "")
fi

update_available=false
new_version=""
new_commit=""
commits_behind=0
error=""

# The published manifest is a few hundred bytes. Cap the read so a wrong URL
# cannot stream an unbounded response into a shell variable.
MAX_REMOTE_SIZE=65536
remote_json=""
remote_json=$(curl -fsSL --max-time 10 "$RAW_URL" 2>/dev/null | head -c "$((MAX_REMOTE_SIZE + 1))") || error="network"
if [[ -n "$remote_json" && ${#remote_json} -gt "$MAX_REMOTE_SIZE" ]]; then
  error="response too large"
  remote_json=""
fi
if [[ -n "$remote_json" ]]; then
  new_version=$(jq -r '.version // empty' <<<"$remote_json" 2>/dev/null || echo "")
  # Only accept a semver-shaped string; anything else is treated as no answer.
  if [[ -n "$new_version" && ! "$new_version" =~ ^[0-9]+\.[0-9]+\.[0-9]+(-[a-zA-Z0-9]+)?$ ]]; then
    error="invalid version format"
    new_version=""
  fi
fi

if git -C "$PLUGIN_DIR" rev-parse --git-dir >/dev/null 2>&1; then
  if timeout 30 git -C "$PLUGIN_DIR" fetch --quiet origin "$BRANCH" 2>/dev/null; then
    new_commit=$(git -C "$PLUGIN_DIR" rev-parse --short FETCH_HEAD 2>/dev/null || echo "")
    commits_behind=$(git -C "$PLUGIN_DIR" rev-list --count HEAD..FETCH_HEAD 2>/dev/null || echo 0)
    if [[ "$commits_behind" -gt 0 ]]; then
      update_available=true
    fi
  fi
fi

if [[ "$update_available" == "false" && -n "$new_version" && -n "$current_version" ]]; then
  if [[ "$new_version" != "$current_version" ]]; then
    oldest=$(printf '%s\n%s\n' "$current_version" "$new_version" | sort -V | head -n1)
    if [[ "$oldest" == "$current_version" ]]; then
      update_available=true
    fi
  fi
fi

if [[ "${1:-}" == "--notify" && "$update_available" == "true" ]]; then
  # Notify once per published version, not once per shell start. The overlay
  # loads every time the shell does, so without this it would re-announce the
  # same update forever.
  already=""
  [[ -f "$NOTIFIED_FILE" ]] && already=$(cat "$NOTIFIED_FILE" 2>/dev/null || echo "")
  stamp="${new_version:-$new_commit}"
  if [[ -n "$stamp" && "$stamp" != "$already" ]] && command -v omarchy-notification-send >/dev/null 2>&1; then
    if omarchy-notification-send "Watermark update available" \
      "omarchy plugin update pix.watermark" >/dev/null 2>&1; then
      mkdir -p "$STATE_DIR" 2>/dev/null &&
        printf '%s' "$stamp" >"$NOTIFIED_FILE" 2>/dev/null
    fi
  fi
fi

emit "$update_available" "$current_version" "$new_version" "$current_commit" "$new_commit" "$commits_behind" "$error"