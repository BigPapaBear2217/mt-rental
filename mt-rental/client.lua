local QBCore = exports['qb-core']:GetCoreObject()

-- Menu da garagem 
RegisterNetEvent('mt-rental:client:MenuRental', function()
    exports['qb-menu']:openMenu({
        {
            id = 1,
            header = "Rent a Vehicle",
            txt = ""
        },
        {
            id = 2,
            header = "Sultan",
            txt = "",
            params = {
                event = "mt-rental:client:RetirarVeiculo",
                args = {
                    vehicle = 'sultan',
                    
                }
            }
        },
        {
            id = 3,
            header = "Kuruma",
            txt = "",
            params = {
                event = "mt-rental:client:RetirarVeiculo",
                args = {
                    vehicle = 'kuruma',
                    
                }
            }
        },
        {
            id = 4,
            header = "Akuma",
            txt = "",
            params = {
                event = "mt-rental:client:RetirarVeiculo",
                args = {
                    vehicle = 'akuma',
                    
                }
            }
        },
        {
            id = 5,
            header = "< Close Menu",
            txt = "",
            params = {
                event = "qb-menu:closeMenu",
            }
        },
    })
end)

-- guardar veiculo
RegisterNetEvent('mt-rental:client:DevolverVeiculo')
AddEventHandler('mt-rental:client:DevolverVeiculo', function()

    QBCore.Functions.Notify('Vehicle Stored!')
    local car = GetVehiclePedIsIn(PlayerPedId(),true)
    DeleteVehicle(car)
    DeleteEntity(car)
end)

-- spawn veiculo
RegisterNetEvent('mt-rental:client:RetirarVeiculo')
AddEventHandler('mt-rental:client:RetirarVeiculo', function(rental)
    local vehicle = rental.vehicle
    local coords = vector4(-895.07, -2335.53, 6.71, 67.72)
    TriggerServerEvent('mt-rental:server:RetirarDinheiro')
    QBCore.Functions.Notify('Vehicle Taked!')
    QBCore.Functions.SpawnVehicle(vehicle, function(veh)
        SetVehicleNumberPlateText(veh, "RENTAL"..tostring(math.random(1000, 9999)))
        exports['LegacyFuel']:SetFuel(veh, 100.0)
        TaskWarpPedIntoVehicle(GetPlayerPed(-1), veh, -1)
        TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(veh))
        SetVehicleEngineOn(veh, true, true)
    end, coords, true)     
end)

-- Target para alugar veiculo
CreateThread(function()
    exports['qb-target']:AddBoxZone("rentcar", vector3(-904.43, -2339.05, 6.71), 2, 1.5,  {
      name = "rentcar",
      heading = 0,
      debugPoly = false,
    }, {
      options = {
        {
          type = "client",
          event = "mt-rental:client:MenuRental",
          icon = 'fas fa-clipboard',
          label = 'Rent a vehicle',
        },
        {
            type = "client",
            event = "mt-rental:client:DevolverVeiculo",
            icon = 'fas fa-clipboard',
            label = 'Store Vehicle',
        }
      },
      distance = 2.5,
    })
  end)
