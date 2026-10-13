# Changelog

All notable changes documented here. Format loosely follows [Keep a Changelog](https://keepachangelog.com/), SemVer for versions.

## 1.0.0 — 2026-10-10

Initial release.

- Bottom-right "Activate Linux" overlay for Omarchy/Hyprland
- Automatic hiding when windows occupy the active workspace (`Hyprland.toplevels`)
- Pure Wayland layer shell — `PanelWindow` with `WlrLayershell` overlay, `ExclusionMode.Ignore` for click-through
- Event-driven declarative QML bindings — no polling loops
- Passive update notifier with version caching