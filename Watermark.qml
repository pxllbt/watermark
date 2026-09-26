import QtQuick
import Quickshell
import Quickshell.Hyprland
import Quickshell.Wayland
import qs.Commons

PanelWindow {
    id: root

    readonly property string layerNamespace: "px-watermark"
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
}
