ESX = nil

local maleSkin = GetHashKey('mp_m_freemode_01')
local femaleSkin = GetHashKey('mp_f_freemode_01')
local currentvest = nil
local hasVest = false

RegisterNetEvent('kevlar:check')
AddEventHandler('kevlar:check', function()
    if hasVest then
        return true
    else
        return false
    end
end)

RegisterNetEvent('vest')
AddEventHandler('vest', function(version)
    heavy = "heavy"
    armour = GetPedArmour(PlayerPedId())
    if armour > 0 then
        exports['mythic_notify']:DoHudText('error', 'Hai già un giubbotto antiproiettile')
        TriggerServerEvent("kevlar:additem")
    else
        if heavy then 
            typeheavy()
        end
    end
end)


Citizen.CreateThread(function()
        while true do
            Citizen.Wait(1000)
            local armour = GetPedArmour(PlayerPedId())
            if armour == 0 then
                SetPedComponentVariation(PlayerPedId(), 9, 0, 0, 0)
            end
        end
end)

function typeheavy()
    male = GetEntityModel(PlayerPedId()) == maleSkin
    female = GetEntityModel(PlayerPedId()) == femaleSkin
    if male then
        exports.rprogress:Start(' Indossando il Giubbotto Antiproiettile ', 3000)
        TriggerEvent("animation")
        --Wait(3000)
        SetPedComponentVariation(GetPlayerPed(-1), 9, 2, 1, 0)
        AddArmourToPed(GetPlayerPed(-1), 100)
        exports['mythic_notify']:DoHudText('success', 'Hai indossato un giubbotto antiproiettile')
        hasVest = true
    elseif female then
        exports.rprogress:Start(' Indossando il Giubbotto Antiproiettile ', 3000)
        TriggerEvent("animation")
        --Wait(3000)
        SetPedComponentVariation(GetPlayerPed(-1), 9, 4, 0, 0)
        AddArmourToPed(GetPlayerPed(-1), 100)
        exports['mythic_notify']:DoHudText('success', 'Hai indossato un giubbotto antiproiettile')
        hasVest = true
    end
end

RegisterNetEvent( 'animation' )
AddEventHandler( 'animation', function()
    local ped = GetPlayerPed(-1)
    if not IsEntityPlayingAnim(ped, "anim@narcotics@trash", "drop_front", 3) then
        RequestAnimDict("anim@narcotics@trash")
        while not HasAnimDictLoaded("anim@narcotics@trash") do
            Citizen.Wait(100)
        end
        TaskPlayAnim(ped, "anim@narcotics@trash", "drop_front", 0.9, -8, 1900, 49, 3.0, 0, 0, 0)
        Wait(2000)
        while IsEntityPlayingAnim(ped, "anim@narcotics@trash", "drop_front", 3) do
            Wait(1)
            if (IsControlPressed(0, 32) or IsControlPressed(0, 33) or IsControlPressed(0, 34) or IsControlPressed(0, 35)) then
                ClearPedTasksImmediately(ped)
                break
            end
        end
    end
end)

function ShowNotification( text )
    SetNotificationTextEntry( "STRING" )
    AddTextComponentString( text )
    DrawNotification( false, false )
  end
  

  function msg(text)
    TriggerEvent("chatMessage", "EasyVest", {255, 4, 1}, text)
end
    









