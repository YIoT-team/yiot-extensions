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
import "./helpers.js" as Helpers

Item {
    property var controlPageIdx: -1
    property var protocol: DeviceProtocol
    property var helpers: Helpers

    signal commandProcessed(var obj)

    id: device0

    //-----------------------------------------------------------------------------
    function deviceName() {
        return "EOC650"
    }

    //-----------------------------------------------------------------------------
    function type() {
        return "router"
    }

    //-----------------------------------------------------------------------------
    function image() {
        return "qrc:/device/5/src/icons/%1/engenius.png"
    }

    //-----------------------------------------------------------------------------
    function stateImage(model) {
        return "qrc:/qml/resources/icons/%1/wifi-dimmed.png"
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
    onCommand(router, json) {
        if (protocol.onCommand(router, json)) {
            commandProcessed(router)
        }
    }

    //-----------------------------------------------------------------------------

}
