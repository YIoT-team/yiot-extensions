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
import Qt.labs.settings 1.0

Item {
    property var controlPageIdx: -1

    signal activated(string pluginId, string msg)
    signal deactivated(string pluginId)
    readonly property string pluginId: "io.yiot-dev.rpi-vpn"
    property var supportedDevices

    //-----------------------------------------------------------------------------
    function onLoad() {
        var file = new XMLHttpRequest;
        file.open("GET", "qrc:/plugin/0/info.json");
        file.onreadystatechange = function() {
            if (file.readyState === XMLHttpRequest.DONE) {
                var jsonString = file.responseText;
                var jsonData = JSON.parse(jsonString);

                if (jsonData.supportedDevices) {
                    supportedDevices = jsonData.supportedDevices;
                } else {
                    console.error("Error getting supported devices from JSON!");
                }
            }
        };
        file.send();

        console.log("RPi VPN Plugin loaded")
    }

    //-----------------------------------------------------------------------------
    function activate() {
        activated(pluginId, "")
    }

    //-----------------------------------------------------------------------------
    function deactivate() {
        deactivated(pluginId)
    }

    //-----------------------------------------------------------------------------
    function image() {
        return "qrc:/plugin/0/src/icons/%1/vpn-router.png"
    }

    //-----------------------------------------------------------------------------
    function isSupportedDevice(deviceType) {
        if(supportedDevices) {
            return supportedDevices.includes(deviceType);
        } else {
            console.log("Property 'supportedDevices' undefined");
            return false;
        }
    }

    //-----------------------------------------------------------------------------
}
