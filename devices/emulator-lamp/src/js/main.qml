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

    id: device0

    //-----------------------------------------------------------------------------
    function deviceName() {
        return "Lamp"
    }

    //-----------------------------------------------------------------------------
    function type() {
        return "lamp"
    }

    //-----------------------------------------------------------------------------
    function image() {
        return "qrc:/device/1/src/icons/%1/bulb.png"
    }

    //-----------------------------------------------------------------------------
    function stateImage(model) {
        if (typeof model.deviceController.currentState !== 'undefined') {
            if (model.deviceController.currentState) {
                return "qrc:/device/1/src/icons/%1/on.png"
            } else {
                return "qrc:/device/1/src/icons/%1/off.png"
            }
        }

        return "qrc:/device/1/src/icons/%1/unknown.png"
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
    onCommand(lamp, json) {
        if (protocol.onCommand(lamp, json)) {
            commandProcessed(lamp)
        }
    }

    //-----------------------------------------------------------------------------
}
