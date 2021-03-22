-- ZeroDream 3D Mini Map

local MapLoaded = false
local MapActive = false
local GpsActive = false
local SelfBlips = false
local MapPlayer = {}
local MarksList = {}

function Init()
	Wait(500)
	for k, v in pairs(Config.marks) do
		AddMark(v.name, v.text, v.x, v.y, v.z, v.font, v.fontSize, v.width, v.height, v.color, v.background)
	end
	
	if Config.showPlayers then
		InitLst(GetActivePlayers())
	end
	
	SetKeys(Config.hotKeySettings.html)
end

function AddMark(name, text, x, y, z, font, fontSize, width, height, color, background)
	debugPrint("Added new mark:", name, text, x, y, z, font, fontSize, width, height, color, background)
	SendNUIMessage({
		action = "addMark",
		data = {
			name       = name,
			text       = text,
			x          = x,
			y          = y,
			z          = z,
			font       = font,
			fontSize   = fontSize,
			width      = width,
			height     = height,
			color      = color,
			background = background
		}
	})
end

function DelMark(name)
	SendNUIMessage({
		action = "delMark",
		data   = name
	})
end

function SetMark(name, x, y, z)
	SendNUIMessage({
		action = "setMark",
		data   = {
			name = name,
			x    = x,
			y    = y,
			z    = z
		}
	})
end

function ShowMap()
	SendNUIMessage({
		action = "showMap"
	})
	SetNuiFocus(true, true)
end

function HideMap()
	SendNUIMessage({
		action = "hideMap"
	})
	SetNuiFocus(false, false)
end

function SetKeys(key)
	SendNUIMessage({
		action = "setKeys",
		data   = key
	})
end

function JoinMap(playerId, convertId)
	if convertId then
		playerId = GetPlayerServerId(playerId)
	end
	if playerId == nil then
		return false
	end
	MapPlayer[playerId] = true
end

function debugPrint(text)
	if Config.debug then
		print(text)
	end
end

function ExitMap(playerId, convertId)
	debugPrint("Player " .. playerId .. " leave the game, remove")
	if convertId then
		playerId = GetPlayerServerId(playerId)
	end
	MapPlayer[playerId] = nil
	MarksList[playerId] = nil
	DelMark("player_mark_" .. tostring(playerId))
end

function InitLst(playerList)
	debugPrint("Init list")
	for _, playerId in pairs(playerList) do
		if playerId ~= PlayerId() then
			JoinMap(playerId, true)
		end
	end
end

function notification(msg)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(msg)
	DrawNotification(false, false)
end

RegisterNetEvent('3DMap:AddMark')
RegisterNetEvent('3DMap:DelMark')
RegisterNetEvent('3DMap:SetMark')
RegisterNetEvent('3DMap:ShowMap')
RegisterNetEvent('3DMap:HideMap')
RegisterNetEvent('3DMap:JoinMap')
RegisterNetEvent('3DMap:ExitMap')
RegisterNetEvent('3DMap:InitLst')
AddEventHandler('3DMap:AddMark', AddMark)
AddEventHandler('3DMap:DelMark', DelMark)
AddEventHandler('3DMap:SetMark', SetMark)
AddEventHandler('3DMap:ShowMap', ShowMap)
AddEventHandler('3DMap:HideMap', HideMap)
AddEventHandler('3DMap:JoinMap', JoinMap)
AddEventHandler('3DMap:ExitMap', ExitMap)
AddEventHandler('3DMap:InitLst', InitLst)

RegisterNUICallback('callback', function(data, cb)
	if data.action == 'loaded' then
		MapLoaded = true
	elseif data.action == 'setLocation' then
		if IsWaypointActive() then
			SetWaypointOff()
			DelMark("gps_route_mark")
			GpsActive = false
		else
			SetNewWaypoint(data.data.x, data.data.y)
			AddMark("gps_route_mark", Config.playerWaypoint.text, data.data.x, data.data.y, data.data.z + 50, Config.playerWaypoint.font, Config.playerWaypoint.fontSize)
			GpsActive = true
		end
	elseif data.action == 'closeMap' then
		HideMap()
		MapActive = false
	end
    cb('ok')
end)

RegisterCommand('+3dmap', function()
	if MapLoaded then
		MapActive = not MapActive
		if MapActive then
			ShowMap()
		else
			HideMap()
		end
	end
end, false)

RegisterKeyMapping('+3dmap', '3D Mini Map', 'keyboard', Config.hotKeySettings.fivem)

Citizen.CreateThread(function()
	
	TriggerServerEvent("3DMap:LoadMap")
	
	HideMap()
	
	-- Wait for the map load
	while MapLoaded == false or MapActive == false do
		Wait(0)
	end
	
	-- Init function
	Init()
	
	debugPrint("Done init")
	debugPrint("showPlayer", Config.showPlayer, MapActive)
	debugPrint("showPlayers", Config.showPlayers, MapActive)
	
	-- Tick
	while true do
		
		Citizen.Wait(Config.updateInterval)
		
		-- Check GPS
		if not IsWaypointActive() and GpsActive then
			SetWaypointOff()
			DelMark("gps_route_mark")
			GpsActive = false
		elseif IsWaypointActive() and not GpsActive then
			if GetFirstBlipInfoId(8) ~= 0 then
				local waypointBlip = GetFirstBlipInfoId(8) 
				local coord = Citizen.InvokeNative(0xFA7C7F0AADF25D09, waypointBlip, Citizen.ResultAsVector())
				AddMark("gps_route_mark", Config.playerWaypoint.text, coord.x, coord.y, coord.z + 50, Config.playerWaypoint.font, Config.playerWaypoint.fontSize)
				GpsActive = true
			end
		end
		
		-- Show Player Location
		if Config.showPlayer and MapActive then
			local playerPos = GetEntityCoords(GetPlayerPed(-1))
			if not SelfBlips then
				AddMark("self_position_mark", Config.playerPosition.text, playerPos.x, playerPos.y, playerPos.z + 50.0, Config.playerPosition.font, Config.playerPosition.fontSize)
				SelfBlips = true
			else
				SetMark("self_position_mark", playerPos.x, playerPos.y, playerPos.z + 50.0)
			end
		end
		
		-- Show Players Location
		if Config.showPlayers and MapActive then
			for id, status in pairs(MapPlayer) do
				if status == true then
					if MarksList[id] ~= nil then
						local playerId  = GetPlayerFromServerId(id)
						local playerPed = GetPlayerPed(playerId)
						local playerPos = GetEntityCoords(playerPed)
						SetMark("player_mark_" .. tostring(id), playerPos.x, playerPos.y, playerPos.z + 50.0)
					elseif id ~= GetPlayerServerId(PlayerId()) then
						local playerId   = GetPlayerFromServerId(id)
						local playerName = GetPlayerName(playerId)
						local playerPos  = GetEntityCoords(GetPlayerPed(playerId))
						MarksList[id]    = true
						AddMark("player_mark_" .. tostring(id), playerName, playerPos.x, playerPos.y, playerPos.z + 50, Config.multPlayerMark.font, Config.multPlayerMark.fontSize)
					end
				end
			end
		end
	end
end)
