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

//-----------------------------------------------------------------------------
function
setRootPassword(pc, pass) {
    console.log("Set Root password")

    let json = {}

    json.command = "script"
    json.script = "create-user.sh"
    json.params = ["root", pass]

    pc.invokeCommand(JSON.stringify(json))
}

//-----------------------------------------------------------------------------
function
setNetworkParams(pc, iface, isStatic, ip, gateway, dns, mask) {
    console.log("Set network parameters:")
    console.log("    interface: ", iface)

    let json = {}

    json.command = "script"
    json.script = "set-network-params.sh"
    json.params = [iface, isStatic, ip, gateway, dns, mask]

    console.log("    interface : ", iface)
    if (isStatic === "true") {
        console.log("    type      : static")
        console.log("    ip        :", ip)
        console.log("    gateway   :", gateway)
        console.log("    dns       :", dns)
        console.log("    mask      :", mask)
    } else {
        console.log("    type      : dhcp")
    }

    pc.invokeCommand(JSON.stringify(json))
}

//-----------------------------------------------------------------------------
function
setupAccessPoint(pc, ssid, mode, password) {
    console.log("Setup access point:")
    console.log("    ssid: ", ssid)
    console.log("    mode: ", mode)

    let json = {}

    json.command = "script"
    json.script = "setup-access-point.sh"
    json.params = [ssid, mode, password]

    pc.invokeCommand(JSON.stringify(json))
}

//-----------------------------------------------------------------------------
function
setupVPNRouter(pc, apName, apPass, vpnProvider, user, password) {
    console.log("Setup VPN router:")
    console.log("    AP name : ", apName)
    console.log("    provider: ", vpnProvider)
    console.log("    user    : ", user)

    let json = {}

    json.command = "script"
    json.script = "setup-vpn-router.sh"
    json.params = [apName, apPass, vpnProvider, user, password]

    pc.invokeCommand(JSON.stringify(json))
}

//-----------------------------------------------------------------------------
function
enableSSH(pc, enable) {
    console.log("Enable SSH:")

    let json = {}

    json.command = "script"
    json.script = "enable-ssh.sh"
    json.params = [enable]

    pc.invokeCommand(JSON.stringify(json))
}

//-----------------------------------------------------------------------------
function
processingText() {
    return ""
}

//-----------------------------------------------------------------------------
function
onCommand(pc, json) {
    var jsonData
    try {
        jsonData = JSON.parse(json);

        if (jsonData.command !== "info") {
            return false
        }

        if (jsonData.type !== 5) {
            return false
        }

        pc.lanIp = jsonData.br_lan
        pc.lan24Ip = jsonData.br_lan24
        pc.version = jsonData.version
    } catch (e) {
        return false
    }

    return true
}

//-----------------------------------------------------------------------------
