//  ────────────────────────────────────────────────────────────
//                     ╔╗  ╔╗ ╔══╗      ╔════╗
//                     ║╚╗╔╝║ ╚╣╠╝      ║╔╗╔╗║
//                     ╚╗╚╝╔╝  ║║  ╔══╗ ╚╝║║╚╝
//                      ╚╗╔╝   ║║  ║╔╗║   ║║
//                       ║║   ╔╣╠╗ ║╚╝║   ║║
//                       ╚╝   ╚══╝ ╚══╝   ╚╝
//    ╔╗╔═╗                    ╔╗                     ╔╗
//    ║║║╔╝                   ╔╝╚╗                    ║║
//    ║╚╝╝  ╔══╗ ╔══╗ ╔══╗  ╔╗╚╗╔╝  ╔══╗ ╔╗ ╔╗╔╗ ╔══╗ ║║  ╔══╗
//    ║╔╗║  ║║═╣ ║║═╣ ║╔╗║  ╠╣ ║║   ║ ═╣ ╠╣ ║╚╝║ ║╔╗║ ║║  ║║═╣
//    ║║║╚╗ ║║═╣ ║║═╣ ║╚╝║  ║║ ║╚╗  ╠═ ║ ║║ ║║║║ ║╚╝║ ║╚╗ ║║═╣
//    ╚╝╚═╝ ╚══╝ ╚══╝ ║╔═╝  ╚╝ ╚═╝  ╚══╝ ╚╝ ╚╩╩╝ ║╔═╝ ╚═╝ ╚══╝
//                    ║║                         ║║
//                    ╚╝                         ╚╝
//
//    Lead Maintainer: Roman Kutashenko <kutashenko@gmail.com>
//  ────────────────────────────────────────────────────────────

import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12

import "./commands"
import "./helpers"
import "qrc:/qml/theme"
import "qrc:/qml/components"
import "qrc:/qml/components/validators"

Page {
    property var controller: ({ lanIp: "", lan24Ip: "", version: "" })
    property alias deviceName: header.title

    id: engeniusPage

    background: Rectangle {
        color: "transparent"
    }

    header: Header {
        id: header
        title: qsTr("EOC650")
        backAction: function() { showDevices() }
    }

    ColumnLayout {
        anchors.fill: parent

        DeviceInfo {
            id: grid
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignHCenter
            Layout.topMargin: 20
            Layout.bottomMargin: 20

            lanIp: controller.lanIp
            lan24Ip: controller.lan24Ip
            version: controller.version
        }

        SwipeView {
            readonly property int listIdx: 0
            readonly property int renameDeviceIdx: 1
            readonly property int setRootPassIdx: 2
            readonly property int staticipIdx: 3
            readonly property int sshIdx: 4

            property int backPageIdx: listIdx

            id: settingsSwipeView
            Layout.fillWidth: true
            Layout.fillHeight: true
            interactive: false
            currentIndex: listIdx

            ControlsList {
                id: settingsListPage
            }

            RenameDevice {
                id: renameDevicePage
            }

            SetRootPassword {
                id: setRootPasswdPage
            }

            StaticIP {
                id: staticipPage
            }

            SSHEnabler {
                id: sshPage
            }
        }
    }

    Connections {
        id: connections
        ignoreUnknownSignals: true

        function onNameChanged() {
            deviceName = controller.name
        }
    }

    onVisibleChanged: {
        if (visible) {
            showRPiSettings()
        }
    }

    onControllerChanged: {
        connections.target = controller
        settingsListPage.controller = controller
    }

    function swipeSettingsShow(idx) {
        settingsSwipeView.currentIndex = idx
        header.visible = idx == 0
        grid.visible = header.visible

        for (var i = 0; i < settingsSwipeView.count; ++i) {
            var item = settingsSwipeView.itemAt(i)
            item.visible = i == settingsSwipeView.currentIndex
        }
    }

    function showRPiSettings() {
        swipeSettingsShow(settingsSwipeView.listIdx)
    }

    function showSetRootPasswdPage() {
        swipeSettingsShow(settingsSwipeView.setRootPassIdx)
    }

    function showRenameDevicePage(controller) {
        renameDevicePage.controller = controller
        swipeSettingsShow(settingsSwipeView.renameDeviceIdx)
    }

    function showStaticipPage() {
        swipeSettingsShow(settingsSwipeView.staticipIdx)
    }

    function showSSHPage() {
        swipeSettingsShow(settingsSwipeView.sshIdx)
    }

    function backInRPiSettings() {
        swipeSettingsShow(settingsSwipeView.backPageIdx)
    }

    function errorPopupClick() {
    }

}
