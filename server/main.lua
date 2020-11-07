ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterUsableItem('kevlar', function (source)
    local xPlayer = ESX.GetPlayerFromId(source)
    local player = source 
    if (player > 0) then
        TriggerClientEvent("vest", source, 'heavy')
        xPlayer.removeInventoryItem('kevlar', 1)
        CancelEvent()
    end

end)


RegisterCommand("vest", function(source, args, raw)
    local player = source 
    if (player > 0) then
        local version = args[1]
        TriggerClientEvent("vest", source,version)
        CancelEvent()
    end
end, false)

RegisterServerEvent('kevlar:additem')
AddEventHandler('kevlar:additem', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.addInventoryItem('kevlar', 1)
end)