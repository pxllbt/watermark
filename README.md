# px.watermark

A bottom-right "Activate Linux" watermark overlay for Omarchy Quickshell.

## Install

1. Clone this repository into `~/.config/omarchy/plugins/px.watermark/`.
2. Register the plugin in `~/.config/omarchy/shell.json` under `plugins` by adding `"id": "px.watermark"`.
3. Restart Omarchy shell with `omarchy restart shell`.

## Usage

The watermark appears on the bottom-right of every Hyprland workspace. It hides automatically when a window is focused on the current workspace.

## Building from source

This plugin is a single QML file using Quickshell's built-in `PanelWindow` and `WlrLayershell` API. No Eww or additional dependencies are required.

## License

MIT
