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

import "qrc:/qml/theme"
import "qrc:/qml/components"

Page {
    property var controller
    property bool isEnabled

    id: emulatorsPage
    visible: false

    background: Rectangle {
        color: "transparent"
    }

    header: Header {
        title: qsTr("Emulators")
        backAction: function() { showServicesList() }
        showBackButton: true
        plusAction: function() { controller.js.create() }
        showPlusButton: true
    }

    Form {
        stretched: true

        EmulatorsList {
            id: emulatorsList
            model: ListModel {}
            Connections {
                target: emulatorsList
                function onRemoveEmulator(emulatorId) {
                    controller.js.remove(emulatorId)
                }
            }
        }

        ColumnLayout {
            id: formContainer

            spacing: 15

            Layout.bottomMargin: 30
            Layout.alignment: Qt.AlignHCenter

            FormPrimaryButton {
                visible: true
                text: qsTr("Update emulators list")
                Layout.alignment: Qt.AlignBottom | Qt.AlignHCenter
                onClicked: {
                    controller.js.updateList()
                }
            }
        }
    }
    onVisibleChanged: {
        if (visible) {
            emulatorsPage.isEnabled = controller.js.integrationState()
        }

        if (isEnabled) {
            emulatorsList.model = controller.js.items
        }
    }
}
