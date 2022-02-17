local QBCore = exports['qb-core']:GetCoreObject()

--- Retirar dinheiro do player
RegisterServerEvent('mt-rental:server:RetirarDinheiro')
AddEventHandler('mt-rental:server:RetirarDinheiro', function()
	local _source = source
	local Player = QBCore.Functions.GetPlayer(_source)
    Player.Functions.RemoveMoney("bank", 10,_source, "rent-deposit")
    TriggerClientEvent("QBCore:Notify", _source, "You paid 10$")
end)