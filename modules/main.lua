
-- ESX CONNECT -- 
ESX = exports["es_extended"]:getSharedObject()

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  ESX.PlayerLoaded = true
end)

RegisterNetEvent('esx:onPlayerLogout')
AddEventHandler('esx:onPlayerLogout', function()
  ESX.PlayerLoaded = false
end)

Playercoords = GetEntityCoords(PlayerPedId())

CreateThread(function ()
  while true do
    Wait(1000)
    Playercoords = GetEntityCoords(PlayerPedId())
  end
end)