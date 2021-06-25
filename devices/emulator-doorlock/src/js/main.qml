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

import "./protocol.js" as DeviceProtocol

Item {
    property var controlPageIdx: -1
    property var protocol: DeviceProtocol

    signal commandProcessed(var obj)

    id: device2

    //-----------------------------------------------------------------------------
    function deviceName() {
        return "Door Lock"
    }

    //-----------------------------------------------------------------------------
    function type() {
        return "lock"
    }

    //-----------------------------------------------------------------------------
    function image() {
        return "qrc:/device/2/src/icons/%1/lock.png"
    }

    //-----------------------------------------------------------------------------
    function stateImage(model) {
        return "qrc:/device/2/src/icons/%1/lock.png"
    }

    //-----------------------------------------------------------------------------
    function
    controlTiny(model) {
        return "qrc:/qml/components/devices/GeneralDeviceControls.qml"
    }

    //-----------------------------------------------------------------------------
    function
    controlTypeTiny(model) {
        return "qrc:/qml/components/devices/GeneralCategoryControls.qml"
    }

    //-----------------------------------------------------------------------------
    function
    onCommand(lock, json) {
        if (protocol.onCommand(lock, json)) {
            commandProcessed(lock)
        }
    }

    //-----------------------------------------------------------------------------
}
