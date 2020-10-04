ESX = nil

cachedData = {}

Citizen.CreateThread(function()
	while not ESX do
		--Fetching esx library, due to new to esx using this.

		TriggerEvent("esx:getSharedObject", function(library) 
			ESX = library 
		end)

		Citizen.Wait(0)
	end
end)

RegisterNetEvent("esx:playerLoaded")
AddEventHandler("esx:playerLoaded", function(playerData)
	ESX.PlayerData = playerData
end)

RegisterNetEvent("esx:setJob")
AddEventHandler("esx:setJob", function(newJob)
	ESX.PlayerData["job"] = newJob
end)

Citizen.CreateThread(function()
	while true do
		local sleepThread = 500

		local ped = PlayerPedId()
		local pedCoords = GetEntityCoords(ped)

		local closestTank = GetClosestObjectOfType(pedCoords, 5.0, Config.TankModel, false)

		if DoesEntityExist(closestTank) then
			sleepThread = 5

			local markerCoords = GetOffsetFromEntityInWorldCoords(closestTank, 0.0, -0.2, 1.0)
			local distanceCheck = #(pedCoords - markerCoords)

			if distanceCheck <= 1.0 then
				local drinkable, displayText = not cachedData["drinking"], cachedData["drinking"] and "Drinking..." or "~INPUT_DETONATE~ Drink water $" .. Config.WaterPrice

				ESX.ShowHelpNotification(displayText)

				if drinkable then
					if IsControlJustPressed(0, 47) then
						PurchaseDrink()
					end
				end
			end
		end

		Citizen.Wait(sleepThread)
	end
end)