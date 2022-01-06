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

    signal activated(string integrationId, string msg)
    signal deactivated(string integrationId)
    readonly property string integrationId: "io.yiot-dev.emulators"

    Settings {
        id: settings
        property bool isEnabled
    }

    property ListModel items: ListModel {}

    property string user: "test"
    readonly property string baseHost: "159.89.15.12"
    readonly property string webSockURL: "ws://" + baseHost + ":8080/ws&"
    readonly property string portalURL: "http://" + baseHost
    readonly property string baseURL: portalURL + ":8081"

    readonly property string getListEndpoint: "/device/list"
    readonly property string getCreateEndpoint: "/device/create"
    readonly property string getDeleteEndpoint: "/device/destroy"

    //-----------------------------------------------------------------------------
    function onLoad() {
        console.log("Emulators Integration loaded")
        if (integrationState()) {
            activated(integrationId, "Activated")
        }
    }

    //-----------------------------------------------------------------------------
    function activate() {
        settings.setValue("isEnabled", true)
    }

    //-----------------------------------------------------------------------------
    function deactivate() {
        settings.setValue("isEnabled", false)
        deactivated(integrationId)
    }

    //-----------------------------------------------------------------------------
    function integrationState() {
        return settings.isEnabled
    }

    //-----------------------------------------------------------------------------
    function updateList() {
        var listRequest = new XMLHttpRequest();
        listRequest.onreadystatechange = function() {
            if (listRequest.readyState == 4) {
                if (listRequest.status == 200) {
                    items.clear()
                    console.log(listRequest.responseText);
                    var jsonData = JSON.parse(listRequest.responseText);
                    if (jsonData.data) {
                        for (var i = 0; i < jsonData.data.length; i++) {
                            var emulator = jsonData.data[i];
                            items.append({
                                             "emulator_id": emulator.id,
                                             "emulator_name": emulator.name,
                                             "emulator_user": emulator.user,
                                             "emulator_port": emulator.port,
                                             "emulator_status": emulator.status,
                                             "emulator_log_url": portalURL + ":" + emulator.port.toString(10),
                                             "emulator_ws_url": webSockURL + user
                                         })
                        }
                    } else {
                        console.error("Error getting supported devices from JSON!");
                    }
                    items.countChanged()
                } else {
                    console.log("List getting error: " + listRequest.status)
                }
           }
        }

        var url = baseURL + getListEndpoint
        listRequest.open("POST", url, true)
        listRequest.setRequestHeader("Content-type", "application/json")
        listRequest.setRequestHeader("Access-Control-Allow-Origin", "*")
        var params = {
            "user": user
        }
        var data = JSON.stringify(params)
        listRequest.send(data);
    }

    //-----------------------------------------------------------------------------
    function create() {
        var createRequest = new XMLHttpRequest();
        createRequest.onreadystatechange = function() {
            if (createRequest.readyState == 4) {
                if (createRequest.status == 200) {
                    updateList()
                } else {
                    console.log("Creation error: " + createRequest.status)
                }
           }
        }

        var url = baseURL + getCreateEndpoint
        createRequest.open("POST", url, true)
        createRequest.setRequestHeader("Content-type", "application/json")
        createRequest.setRequestHeader("Access-Control-Allow-Origin", "*")
        var params = {
            "user": user
        }
        var data = JSON.stringify(params)
        createRequest.send(data);
    }

    //-----------------------------------------------------------------------------
    function remove(emulatorId) {
        var removeRequest = new XMLHttpRequest();
        removeRequest.onreadystatechange = function() {
            if (removeRequest.readyState == 4) {
                if (removeRequest.status != 200) {
                    console.log("Emulator remove error: " + listRequest.status)
                }
                updateList()
           }
        }

        var url = baseURL + getDeleteEndpoint
        removeRequest.open("POST", url, true)
        removeRequest.setRequestHeader("Content-type", "application/json")
        removeRequest.setRequestHeader("Access-Control-Allow-Origin", "*")
        var params = {
            "id": emulatorId,
            "user": user
        }
        var data = JSON.stringify(params)
        removeRequest.send(data);
    }

    //-----------------------------------------------------------------------------


    Component.onCompleted: {
        updateList()
    }
}
