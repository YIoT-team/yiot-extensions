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
import "qrc:/qml/theme"
import "qrc:/qml/components"
import "qrc:/qml/components/validators"

Page {
    property var controller
    property alias deviceName: header.title

    id: p

    background: Rectangle {
        color: "transparent"
    }

    header: Header {
        id: header
        title: qsTr("Door Lock")
        backAction: function() { showDevices() }
    }

    Form {
        id: form
        stretched: true

        ColumnLayout {
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.topMargin: 40
            Layout.bottomMargin: 20

            spacing: 10

            Label {
                id: infoText
                Layout.alignment: Qt.AlignHCenter
                Layout.fillHeight: true
                Layout.fillWidth: true

                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.family: Theme.mainFont
                font.pointSize: 24
                color: Theme.brandColor
            }

            Image {
                property string img: "unknown"
                id: stateImage

                Layout.fillHeight: true
                Layout.fillWidth: true

                fillMode: Image.PreserveAspectFit
                source: "qrc:/device/2/src/icons/%1/%2.png".arg(Theme.state).arg(img)

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        p.state = !controller.currentState ? "locked" : "unlocked"
                        controller.js.protocol.setState(controller, !controller.currentState)
                    }
                }
            }

            FormPrimaryButton {
                id: actionButton
                Layout.bottomMargin: 10
                text: qsTr("Close")
                onClicked: {
                    showDevices()
                }
            }
        }
    }

    state: "undefined"
    states: [
        State {
            name: "unknown"
            PropertyChanges { target: infoText; text: qsTr("Unknown state") }
            PropertyChanges { target: stateImage; img: "unknown" }
        },
        State {
            name: "unlocked"
            PropertyChanges { target: infoText; text: qsTr("Unlocked") }
            PropertyChanges { target: stateImage; img: "unlocked" }
        },
        State {
            name: "locked"
            PropertyChanges { target: infoText; text: qsTr("Locked") }
            PropertyChanges { target: stateImage; img: "locked" }
        }
    ]

    Connections {
        target: (controller && controller.js) ? controller.js : null
        ignoreUnknownSignals: true
        function onCommandProcessed(obj) {
            if (obj === controller) {
                updateState()
            }
        }
    }

    onControllerChanged: {
        updateState()
    }

    function updateState() {
        p.state = controller.currentState ? "locked" : "unlocked"
    }
}
