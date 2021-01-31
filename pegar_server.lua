local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNÇÕES
-----------------------------------------------------------------------------------------------------------------------------------------
function func.givePanfletos()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.getInventoryWeight(user_id) + vRP.getItemWeight(cfg.requestedItem.item) * 3 <= vRP.getInventoryMaxWeight(user_id) then
			vRP.giveInventoryItem(user_id, cfg.requestedItem.item, 3)
			return true
		end
	end
end
