local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
func = {}
Tunnel.bindInterface("emp_panfletos", func)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
function func.checkPayment()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local randQuant = math.random(cfg.requestedItem.minQuant, cfg.requestedItem.maxQuant)
		local randMoney = math.random(cfg.minMoney, cfg.maxMoney)

		if vRP.tryGetInventoryItem(user_id, cfg.requestedItem.item, randQuant) then
			vRP.giveMoney(user_id, randMoney)

			TriggerClientEvent("Notify", source, "sucesso", "Você recebeu <b>$" .. randMoney .. " dólares</b>.")

			return true
		else
			TriggerClientEvent("Notify", source, "aviso", "Você precisa de <b>" .. randQuant .. "x " .. vRP.itemNameList(cfg.requestedItem.item) .. "</b>.")
		end
	end
end
