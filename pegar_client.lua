local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local processo = false
local pegarBlip = cfg.pegarBlip
-----------------------------------------------------------------------------------------------------------------------------------------
-- PROCESSO
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local sleepThread = 5
		if not processo then
			local ped = PlayerPedId()
			local x, y, z = table.unpack(GetEntityCoords(ped))
			local distance = GetDistanceBetweenCoords(pegarBlip.x, pegarBlip.y, pegarBlip.z, x, y, z, true)

			if distance < 10 then
				DrawMarker(23, pegarBlip.x, pegarBlip.y, pegarBlip.z - 0.97, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 0.5, 240, 200, 80, 20, 0, 0, 0, 0)
				if distance <= 1.2 and not processo then
					DrawTxtabcdefg("PRESSIONE  ~b~E~w~  PARA PEGAR PANFLETOS", 4, 0.5, 0.93, 0.50, 255, 255, 255, 180)
					if IsControlJustPressed(0, 38) then
						if func.givePanfletos() then
							processo = true
							TriggerEvent('cancelando', true)
							TriggerEvent("progress", 2000, "Pegando Panfletos")
							SetTimeout(2000, function()
								processo = false
								TriggerEvent('cancelando', false)
							end)
						end
					end
				end
			else
				sleepThread = 1000
			end
		else
			sleepThread = 3000
		end
		Citizen.Wait(sleepThread)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNÇÕES
-----------------------------------------------------------------------------------------------------------------------------------------
function DrawTxtabcdefg(text, font, x, y, scale, r, g, b, a)
	SetTextFont(font)
	SetTextScale(scale, scale)
	SetTextColour(r, g, b, a)
	SetTextOutline()
	SetTextCentre(1)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x, y)
end

