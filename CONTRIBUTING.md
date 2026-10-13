# Contributing to Watermark

Thanks for stopping by. Even though this is a tiny plugin, contributions are welcome.

## Setup

You'll need:
- Linux on Wayland with Hyprland
- Quickshell 0.3.0+
- Omarchy 4.x+
- `jq` and `bash` for smoke tests and update checking

```bash
omarchy plugin add https://github.com/pxllbt/watermark.git --enable
omarchy plugin enable pix.watermark
```

## What to keep in mind

1. **Zero idle overhead.** The overlay uses declarative Hyprland IPC bindings (`Hyprland.toplevels`, `Hyprland.focusedWorkspace`). No polling, no frame render loops.
2. **Click-through.** The overlay must ignore mouse input (`ExclusionMode.Ignore`) so it never blocks desktop interaction.
3. **Smart hiding.** Hide automatically when windows occupy the active workspace.

## Tests

```bash
bash tests/smoke.sh
```

Manifest validation and script health checks should pass.

## PRs

- Clear, imperative commit messages
- Don't break the click-through behavior
- Keep it simple — this is a two-line text overlay, not a framework