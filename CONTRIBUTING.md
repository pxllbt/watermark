# Contributing to Watermark

Thank you for your interest in improving Watermark! Contributions, ideas, and pull requests are warmly welcomed.

---

## 🛠️ Development Setup

### Prerequisites
- **Linux on Wayland** with **Hyprland**
- **Quickshell** `0.3.0+`
- **Omarchy** `4.x+`
- **jq** and **bash** (for smoke tests and update checking)

### Running from Source
Clone or link the repository into your Omarchy plugins directory:

```bash
omarchy plugin add https://github.com/pxllbt/watermark.git --enable
omarchy plugin enable pix.watermark
```

---

## ⚡ Core Principles

1. **Zero Idle Overhead**:
   Watermark must maintain **0.0% CPU overhead at idle**.
   - Workspace state and window occupancy are monitored exclusively via declarative Hyprland IPC bindings (`Hyprland.toplevels` and `Hyprland.focusedWorkspace`).
   - Never introduce polling timers or continuous frame render loops.
2. **Transparent Layer Integration**:
   - The overlay must ignore mouse interactions (`ExclusionMode.Ignore`) so it never blocks desktop clicks or window drags.
   - Respect window hierarchy: the watermark automatically hides whenever windows occupy the active workspace.

---

## 🧪 Running Tests

Before submitting a pull request, run the automated smoke test suite:

```bash
bash tests/smoke.sh
```

Manifest validation and script health checks must report green before merging.

---

## 📝 Pull Request Guidelines

1. **Clear Commit Messages**: Use concise, imperative commit messages (e.g. `Harden workspace occupancy check on multi-monitor setups`).
2. **Performance Validation**: Ensure the overlay maintains 0.0% CPU at idle.
3. **Keep PRs Focused**: Avoid bundling unrelated refactorings into a single PR.
