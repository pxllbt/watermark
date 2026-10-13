# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

---

## [1.0.0] - 2026-10-10

### Added
- **Activate Linux Overlay**: Persistent bottom-right "Activate Linux" watermark for the Omarchy shell and Hyprland.
- **Smart Window Occlusion**: Automatically hides the overlay whenever an active client window occupies the focused workspace via `Hyprland.toplevels`.
- **Pure Wayland Layer Shell**: Native `PanelWindow` integration using `WlrLayershell` overlay layer (`ExclusionMode.Ignore`) — zero mouse interference and zero clicks blocked.
- **0.0% Idle Overhead**: Event-driven declarative QML bindings with no polling loops or background CPU drain.
- **Passive Update Notifier**: Lightweight update checker with version cache.
