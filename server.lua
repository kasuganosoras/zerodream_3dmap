RegisterServerEvent('3DMap:LoadMap')

AddEventHandler("3DMap:LoadMap", function ()
	TriggerClientEvent("3DMap:JoinMap", -1, source, false)
end)

AddEventHandler('playerDropped', function (reason)
	TriggerClientEvent("3DMap:ExitMap", -1, source, false)
end)
