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

import QtQuick 2.5
import QtQuick.Layouts 1.5
import QtQuick.Controls 2.12

import "qrc:/qml/theme"
import "qrc:/qml/components"

Rectangle {
    id: base
    width: parent.width
    height: 60
    color: "transparent"

    signal removeEmulator(int emulatorID)

    RowLayout {
        id: listDelegate
        anchors.fill: parent
        clip: true
        spacing: 20

        Text {
            id: nameText
            Layout.leftMargin: 30
            text: emulator_name
            color: ma.containsMouse ? Theme.linkTextColor : Theme.primaryTextColor
            verticalAlignment: Text.AlignVCenter
            font.pointSize: 14

            Layout.alignment: Qt.AlignLeft
            Layout.fillHeight: true
            Layout.fillWidth: true

            MouseArea {
                id: ma
                enabled: emulator_log_url !== ""
                anchors.fill: parent
                hoverEnabled: true
                onClicked: {
                    Qt.openUrlExternally(emulator_log_url)
                }
            }
        }

        FormSecondaryButton {
            Layout.rightMargin: 30
            text: qsTr("Delete")
            onClicked: {
                base.removeEmulator(emulator_id)
                console.log(">>> Delete emulator: ", emulator_name)
            }
        }
    }
}