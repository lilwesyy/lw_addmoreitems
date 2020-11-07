

# esx_addmoreitems

**Description**:

This resource allow you to add custom kevlars to your ped and remove it when the player takes damage.

**Preview Video:** [LINK]([esx_addmoreitems - YouTube](https://www.youtube.com/watch?v=Q7-Yksn6WEc))

**How To Install:**

1. Exec the SQL file to add the kevlar as item into your DB

2. Place it in your server directory and start it

```lua
start esx_addmoreitems
```

---

**Dependencies:**

[es_extended 1.2]([Release v1-final · esx-framework/es_extended · GitHub](https://github.com/esx-framework/es_extended/releases/tag/v1-final))

[rprogress](https://github.com/Mobius1/rprogress)

[mythic__notify]([GitHub - FlawwsX/mythic_notify: This is the most latest version of mythic notifications, before being taken down.](https://github.com/FlawwsX/mythic_notify))

---

**How To Add Custom Kevlars:**

Add your custom item in the database

```sql
USE `es_extended`;

INSERT INTO `items` (`name`, `label`, `weight`) VALUES
	('name', 'name', 1)
;
```

Got to *client/main.lua* and replace typename with yours and change some options

```lua
function typename()
    male = GetEntityModel(PlayerPedId()) == maleSkin
    female = GetEntityModel(PlayerPedId()) == femaleSkin
    if male then
        exports.rprogress:Start(' Indossando il Giubbotto Antiproiettile ', 3000)
        TriggerEvent("animation")
        SetPedComponentVariation(GetPlayerPed(-1), 9, 2, 1, 0)
        AddArmourToPed(GetPlayerPed(-1), 100)
        exports['mythic_notify']:DoHudText('success', 'Hai indossato un giubbotto antiproiettile')
        hasVest = true
    elseif female then
        exports.rprogress:Start(' Indossando il Giubbotto Antiproiettile ', 3000)
        TriggerEvent("animation")
        SetPedComponentVariation(GetPlayerPed(-1), 9, 4, 0, 0)
        AddArmourToPed(GetPlayerPed(-1), 100)
        exports['mythic_notify']:DoHudText('success', 'Hai indossato un giubbotto antiproiettile')
        hasVest = true
    end
end


```



Go to *server/main.lua* and replace "name" with your item name

```lua
ESX.RegisterUsableItem('name', function (source)
    local xPlayer = ESX.GetPlayerFromId(source)
    local player = source 
    if (player > 0) then
        TriggerClientEvent("vest", source, 'heavy')
        xPlayer.removeInventoryItem('name', 1)
        CancelEvent()
    end

end)
```

This is for checking if you already have a vest or wear it

```lua
RegisterNetEvent('name')
AddEventHandler('name', function(version)
    name = "name"
    armour = GetPedArmour(PlayerPedId())
    if armour > 0 then
        exports['mythic_notify']:DoHudText('error', 'Hai già un giubbotto antiproiettile')
        TriggerServerEvent("name:additem")
    else
        if heavy then 
            typename()
        end
    end
end)
```

Now this is for adding the item again if you already have the custom item on you

```lua
RegisterServerEvent('name:additem')
AddEventHandler('name:additem', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.addInventoryItem('name', 1)
end)
```
