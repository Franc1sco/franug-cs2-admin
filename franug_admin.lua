adminPassword = "franugmolaxd"

local connectedPlayers = {}
local activeAdmins = {}

local bannedPlayers = { -- You can add players to the banlist using their SteamID3
    "[U:1:372278500]",
}

function tableContains(table, value)
    for _, v in pairs(table) do
        if v == value then
            return true
        end
    end
    return false
end

function GetPlayerName(userid)
    local playerData = connectedPlayers[userid]
    if playerData then
        return playerData.name
    else
        return "unknown"
    end
end

function ExistPlayer(userid)
    local playerData = connectedPlayers[userid]
    if playerData then
        return true
    else
        return false
    end
end

function addAdmin(activeAdmins, admin)
    for _, existingAdmin in ipairs(activeAdmins) do
        if existingAdmin == admin then
            print("admin already logged in")
            return
        end
    end

    table.insert(activeAdmins, admin)
end

Convars:RegisterCommand( "adminlogin" , function (_, pw)
    local password = tostring (pw) or  30
    
    if password == adminPassword then
        local admin = Convars:GetCommandClient()
        addAdmin(activeAdmins, admin)
        print("admin logged in")
    end
end, nil , FCVAR_PROTECTED)

Convars:RegisterCommand( "sm_kick" , function (_, args)
    local user = Convars:GetCommandClient()

    if tableContains(activeAdmins, user) then
        --if ExistPlayer(userid) then
            local msg = tostring(args)
            SendToServerConsole("kickid " .. msg .. " kicked by server admin")
            ScriptPrintMessageChatAll(" \x05ADMIN: userid " ..msg .. " kicked from the server")
        --end
    end
end, nil , FCVAR_PROTECTED)

Convars:RegisterCommand( "sm_rcon" , function (_, args)
    local user = Convars:GetCommandClient()
    --print(msg)

    if tableContains(activeAdmins, user) then
        local msg = tostring(args)
        SendToServerConsole(msg)
    end
end, nil , FCVAR_PROTECTED)

Convars:RegisterCommand( "sm_say" , function (_, args)
    local user = Convars:GetCommandClient()
    --print(msg)
    --user.GetEntityIndex()

    if tableContains(activeAdmins, user) then
        local msg = tostring(args)
        --print("hecho con "..msg)
        ScriptPrintMessageChatAll(" \x05ADMIN: "..msg)
        ScriptPrintMessageCenterAll("ADMIN: "..msg)
    end
end, nil , FCVAR_PROTECTED)

Convars:RegisterCommand( "sm_map" , function (_, args)
    local user = Convars:GetCommandClient()
    --print(msg)
    --user.GetEntityIndex()

    if tableContains(activeAdmins, user) then
        local msg = tostring(args)
        --print("hecho con "..msg)
        ScriptPrintMessageChatAll(" \x05ADMIN: changing map to "..msg)
        ScriptPrintMessageCenterAll("ADMIN: changing map to "..msg)
        SendToServerConsole("map "..msg)
    end
end, nil , FCVAR_PROTECTED)

--function OnPlayerConnect(event)
	--local playerData = {
		--name = event.name,
		--userid = event.userid,
		--networkid = event.networkid,
		--address = event.address
	--}
	--connectedPlayers[event.userid] = playerData
--end

--function OnPlayerDisconnect(event)
	--connectedPlayers[event.userid] = nil
--end

--if tListenerIds then
    --for k, v in ipairs(tListenerIds) do
        --StopListeningToGameEvent(v)
    --end
--end

--tListenerIds = {
    --ListenToGameEvent("player_connect", OnPlayerConnect, nil),
    --ListenToGameEvent("player_disconnect", OnPlayerDisconnect, nil)
--}