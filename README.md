# Activate Linux Watermark

![Omarchy](https://img.shields.io/badge/Omarchy-4.x-1e66f5?style=flat-square)
![QML](https://img.shields.io/badge/QML-Quickshell-1e66f5?style=flat-square)
![License](https://img.shields.io/badge/License-MIT-1e66f5?style=flat-square)

A persistent, bottom-right "Activate Linux" watermark overlay for the
Omarchy shell, built with Quickshell's `PanelWindow` and `WlrLayershell`.
Inspired by [eww_activate-linux](https://github.com/Nycta-b424b3c7/eww_activate-linux).

[![Watermark preview](https://github.com/pxllbt/watermark/raw/main/assets/previews/preview.png)](https://github.com/pxllbt/watermark/blob/main/assets/previews/preview.png)

## Features

- Always visible on every Hyprland workspace
- Hides automatically when a window is focused on the active workspace
- Bottom-right placement with configurable margins
- No Eww or additional dependencies — pure Quickshell/QML
- 50% transparent white text, subtitle font size
- Per-workspace hiding via `Hyprland.toplevels` model

## Requirements

- Omarchy 4.x (Quickshell 0.3+)
- Hyprland with `wlr-layer-shell` support

## Install

```
omarchy plugin add https://github.com/pxllbt/watermark.git --enable
omarchy plugin enable pix.watermark
omarchy restart shell
```

## Update

```
omarchy plugin update pix.watermark
```

## Development

```
omarchy plugin validate .
```

## Files

| Path | Purpose |
|------|---------|
| `manifest.json` | Plugin manifest (schema v1, overlay) |
| `Watermark.qml` | PanelWindow overlay with WlrLayershell |
| `README.md` | This file |
| `LICENSE` | MIT license |

## License

MIT — see [LICENSE](LICENSE).
