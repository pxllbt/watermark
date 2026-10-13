<div align="center">

# Watermark

**A subtle, non-intrusive "Activate Linux" desktop watermark for Omarchy & Hyprland on Wayland.**

[![CI](https://img.shields.io/github/actions/workflow/status/pxllbt/watermark/ci.yml?branch=main&style=flat-square&label=CI)](https://github.com/pxllbt/watermark/actions)
[![Omarchy](https://img.shields.io/badge/Omarchy-4.x-1e66f5?style=flat-square)](https://omarchy.org)
[![Quickshell](https://img.shields.io/badge/Quickshell-0.3%2B-1e66f5?style=flat-square)](https://quickshell.outfoxxed.me)
[![Hyprland](https://img.shields.io/badge/Hyprland-Wayland-00c853?style=flat-square)](https://hyprland.org)
[![Idle CPU](https://img.shields.io/badge/Idle%20CPU-0.0%25-brightgreen?style=flat-square)](#-performance--zero-overhead)
[![License](https://img.shields.io/badge/License-MIT-blue?style=flat-square)](LICENSE)

<br/>

<img src="preview.png" alt="Watermark Preview" width="100%" />

<br/>

*Subtle Aesthetic · Intelligent Occlusion · 0.0% Idle Overhead*

[Overview](#-overview) • [Features](#-features) • [Installation](#-installation) • [Performance](#-performance--zero-overhead) • [Development](#-development--testing) • [Contributing](#-contributing)

</div>

---

## 🌟 Overview

**Watermark** (`pix.watermark`) adds the classic, tongue-in-cheek "Activate Linux" watermark to the bottom-right corner of your desktop, tailored natively for the [Omarchy](https://omarchy.org) shell and [Hyprland](https://hyprland.org).

Built directly on [Quickshell](https://quickshell.outfoxxed.me)'s `PanelWindow` and the `wlr-layer-shell` protocol, Watermark stays completely out of your way: it is 100% click-through, consumes **0.0% CPU at idle**, and automatically tucks itself away the instant any window occupies your active workspace.

Inspired by [eww_activate-linux](https://github.com/Nycta-b424b3c7/eww_activate-linux), but engineered with zero external daemons or heavy widget toolkits.

---

## ✨ Features

- **Smart Workspace Occlusion**: Watches `Hyprland.toplevels` to automatically hide itself whenever an application or window is active on the current workspace, leaving your work unobstructed.
- **100% Click-Through**: Built with `ExclusionMode.Ignore` on the Wayland overlay layer — clicks, selections, and window dragging pass straight through with zero interference.
- **Pure QML & Quickshell**: No Eww daemon, no Electron bloat, and no external runtime requirements.
- **Clean Aesthetic**: Rendered with smooth 50% opacity neutral white typography matching your system font scale.
- **Passive Update Checking**: Lightweight, background-dormant update checking that only alerts when newer releases are published.

---

## 📦 Installation

Install directly using the Omarchy plugin manager:

```bash
omarchy plugin add https://github.com/pxllbt/watermark.git --enable
omarchy plugin enable pix.watermark
omarchy restart shell
```

### Updating

Update to the latest release at any time:

```bash
omarchy plugin update pix.watermark
```

---

## ⚡ Performance & Zero Overhead

Watermark is built with strict performance standards:
- **0.0% CPU at Idle**: All workspace visibility rules use declarative event-driven bindings on Hyprland IPC. No polling loops, no render timers, and no unbounded background animations.
- **Zero Memory Leaks**: Renders a single lightweight overlay surface that stays resident without accumulating memory.

---

## 🧪 Development & Testing

Validate the plugin manifest and verify script integrity:

```bash
# Validate Omarchy plugin manifest
omarchy plugin validate .

# Run automated smoke test suite
bash tests/smoke.sh
```

---

## 📂 Project Structure

| File | Description |
| :--- | :--- |
| `manifest.json` | Plugin manifest (schema v1, overlay kind) |
| `Watermark.qml` | Quickshell PanelWindow layer-shell overlay component |
| `preview.png` | Desktop showcase screenshot |
| `scripts/check-update.sh` | Non-blocking version and update check helper |
| `tests/smoke.sh` | Automated test suite verifying schema and script contracts |

---

## 🤝 Contributing

Contributions, issues, and feature suggestions are welcome! Please review our [Contributing Guidelines](CONTRIBUTING.md) and [Security Policy](SECURITY.md) before opening a pull request.

---

## 📄 License

Licensed under the [MIT License](LICENSE). Built with ❤️ by [pxllbt](https://github.com/pxllbt).
