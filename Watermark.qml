import QtQuick
import Quickshell
import Quickshell.Hyprland
import Quickshell.Io
import Quickshell.Wayland
import qs.Commons

PanelWindow {
    id: root

    readonly property string layerNamespace: "px-watermark"

    // Last result from scripts/check-update.sh, for anyone who wants to read it
    // from the shell or a debug overlay.
    property string lastUpdateStatus: ""

    readonly property string updateCheckerPath: {
        var u = Qt.resolvedUrl("scripts/check-update.sh").toString();
        return decodeURIComponent(u.replace(/^file:\/\//, ""));
    }

    readonly property bool workspaceBusy: {
        const workspace = Hyprland.focusedWorkspace;
        if (!workspace)
            return false;

        const toplevels = Hyprland.toplevels.values;
        for (let i = 0; i < toplevels.length; i++) {
            const toplevel = toplevels[i];
            if (toplevel && toplevel.workspace && toplevel.workspace.id === workspace.id)
                return true;
        }

        return false;
    }

    implicitWidth: 280
    implicitHeight: 60
    color: "transparent"
    exclusionMode: ExclusionMode.Ignore
    WlrLayershell.namespace: root.layerNamespace
    WlrLayershell.layer: WlrLayer.Overlay
    WlrLayershell.anchors.right: true
    WlrLayershell.anchors.bottom: true
    WlrLayershell.margins.right: 30
    WlrLayershell.margins.bottom: 30
    visible: !root.workspaceBusy

    Text {
        anchors.centerIn: parent
        text: "Activate Linux\nGo to Settings to activate Linux"
        font.pixelSize: Style.font.subtitle
        color: Qt.rgba(1, 1, 1, 0.5)
    }

    // Update check. This overlay has no panel to show a version in, so the
    // check runs once when the shell loads and notifies if the plugin is
    // behind. check-update.sh remembers which version it last announced, so
    // this stays quiet until there is something new.
    Process {
        id: updateCheck
        command: [root.updateCheckerPath, "--notify"]
        stdout: StdioCollector {
            waitForEnd: true
            onStreamFinished: root.lastUpdateStatus = String(text || "").trim()
        }
    }

    Component.onCompleted: updateCheck.running = true
}
