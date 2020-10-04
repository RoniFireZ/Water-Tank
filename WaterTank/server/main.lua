ESX = nil

TriggerEvent("esx:getSharedObject", function(library) 
	ESX = library 
end)

ESX.RegisterServerCallback("watertank:validatePurchase", function(source, callback)
	local player = ESX.GetPlayerFromId(source)

	if player then
		if player.getMoney() >= Config.WaterPrice then
			player.removeMoney(Config.WaterPrice)

			callback(true)
		else
			callback(false)
		end
	else
		callback(false)
	end
end)