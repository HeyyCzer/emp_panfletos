local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
func = Tunnel.getInterface("emp_panfletos")
vRP = Proxy.getInterface("vRP")

-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local blips = false
local servico = false
local selecionado = 0
local entregaBlip = cfg.entregaBlip

local necessaryVehicle = cfg.necessaryVehicle
-----------------------------------------------------------------------------------------------------------------------------------------
-- RESIDENCIAS
-----------------------------------------------------------------------------------------------------------------------------------------
local locs = {
	[1] = {
		["x"] = 342.93502807617,
		["y"] = -209.5604095459,
		["z"] = 54.221755981445,
	},
	[2] = {
		["x"] = 952.74609375,
		["y"] = -252.41429138184,
		["z"] = 67.96467590332,
	},
	[3] = {
		["x"] = 880.26702880859,
		["y"] = -205.37637329102,
		["z"] = 71.976448059082,
	},
	[4] = {
		["x"] = 1051.4558105469,
		["y"] = -470.49069213867,
		["z"] = 64.098930358887,
	},
	[5] = {
		["x"] = 1009.7663574219,
		["y"] = -572.59881591797,
		["z"] = 60.589786529541,
	},
	[6] = {
		["x"] = 979.43438720703,
		["y"] = -716.03466796875,
		["z"] = 58.220676422119,
	},
	[7] = {
		["x"] = 68.893127441406,
		["y"] = -1569.6202392578,
		["z"] = 29.597789764404,
	},
	[8] = {
		["x"] = -50.536350250244,
		["y"] = -1784.0560302734,
		["z"] = 28.300699234009,
	},
	[9] = {
		["x"] = 21.200784683228,
		["y"] = -1844.6070556641,
		["z"] = 24.601736068726,
	},
	[10] = {
		["x"] = -5.2220392227173,
		["y"] = -1872.0783691406,
		["z"] = 24.151037216187,
	},
	[11] = {
		["x"] = 100.97302246094,
		["y"] = -1912.3249511719,
		["z"] = 21.407426834106,
	},
	[12] = {
		["x"] = 85.659675598145,
		["y"] = -1959.6264648438,
		["z"] = 21.121654510498,
	},
	[13] = {
		["x"] = 143.59237670898,
		["y"] = -1838.4366455078,
		["z"] = 26.586664199829,
	},
	[14] = {
		["x"] = 1295.2325439453,
		["y"] = -1739.5799560547,
		["z"] = 54.271724700928,
	},
	[15] = {
		["x"] = 1354.9903564453,
		["y"] = -1690.5159912109,
		["z"] = 60.491329193115,
	},
	[16] = {
		["x"] = 1203.4967041016,
		["y"] = -1671.7235107422,
		["z"] = 42.357959747314,
	},
	[17] = {
		["x"] = 1327.6071777344,
		["y"] = -1553.0466308594,
		["z"] = 54.051540374756,
	},
	[18] = {
		["x"] = 1379.4808349609,
		["y"] = -1514.9940185547,
		["z"] = 58.435695648193,
	},
	[19] = {
		["x"] = 1211.3637695312,
		["y"] = -1389.4134521484,
		["z"] = 35.376884460449,
	},
	[20] = {
		["x"] = 1143.3562011719,
		["y"] = -986.75073242188,
		["z"] = 45.899555206299,
	},
	[21] = {
		["x"] = 1229.0401611328,
		["y"] = -725.34393310547,
		["z"] = 60.797943115234,
	},
	[22] = {
		["x"] = 1341.9197998047,
		["y"] = -597.48150634766,
		["z"] = 74.700782775879,
	},
	[23] = {
		["x"] = -1636.3186035156,
		["y"] = 180.8272857666,
		["z"] = 61.757316589355,
	},
	[24] = {
		["x"] = -1051.8807373047,
		["y"] = 432.20989990234,
		["z"] = 77.063751220703,
	},
	[25] = {
		["x"] = -982.41040039062,
		["y"] = 427.34390258789,
		["z"] = 80.575393676758,
	},
	[26] = {
		["x"] = -1030.7009277344,
		["y"] = 354.93389892578,
		["z"] = 71.361358642578,
	},
	[27] = {
		["x"] = -499.67709350586,
		["y"] = -342.81771850586,
		["z"] = 34.501865386963,
	},
	[28] = {
		["x"] = -263.24478149414,
		["y"] = -903.52722167969,
		["z"] = 32.310791015625,
	},
	[29] = {
		["x"] = -517.5849609375,
		["y"] = -809.15264892578,
		["z"] = 30.71360206604,
	},
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRABALHAR
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local sleepThread = 5
		if not servico then
			local ped = PlayerPedId()
			local x, y, z = table.unpack(GetEntityCoords(ped))
			local distance = GetDistanceBetweenCoords(entregaBlip.x, entregaBlip.y, entregaBlip.z, x, y, z, true)

			if distance <= 6.0 then
				DrawMarker(23, entregaBlip.x, entregaBlip.y, entregaBlip.z - 0.97, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 0.5, 240, 200, 80, 20, 0, 0, 0, 0)
				if distance <= 1.2 then
					DrawTxtabcdefg("PRESSIONE ~b~E~w~ PARA INICIAR ENTREGAS", 4, 0.5, 0.93, 0.50, 255, 255, 255, 180)
					if IsControlJustPressed(0, 38) then
						servico = true
						-- selecionado = math.random(#locs)
						selecionado = 1
						CriandoBlip(locs, selecionado)
						TriggerEvent("Notify", "sucesso", "Você entrou em serviço. Siga a rota demarcada em seu GPS para entregar os panfletos.")
					end
				end
			elseif distance > 12 then
				sleepThread = 3000
			end
		else
			sleepThread = 3000
		end
		Citizen.Wait(sleepThread)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ENTREGAS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local sleepThread = 5
		if servico then
			local ped = PlayerPedId()
			local x, y, z = table.unpack(GetEntityCoords(ped))
			local distance = GetDistanceBetweenCoords(locs[selecionado].x, locs[selecionado].y, locs[selecionado].z, x, y, z, true)

			if distance <= 30.0 then
				DrawMarker(21, locs[selecionado].x, locs[selecionado].y, locs[selecionado].z + 0.30, 0, 0, 0, 0, 180.0, 130.0, 2.0, 2.0, 1.0, 240, 200, 80, 20, 1, 0, 0, 1)
				if distance <= 2.5 then
					DrawTxtabcdefg("PRESSIONE  ~b~E~w~  PARA ENTREGAR ENCOMENDAS", 4, 0.5, 0.93, 0.50, 255, 255, 255, 180)
					if IsControlJustPressed(0, 38) then
						if not IsPedInAnyVehicle(ped, false) and IsVehicleModel(GetVehiclePedIsIn(ped, true), GetHashKey(necessaryVehicle)) then
							if func.checkPayment() then
								RemoveBlip(blips)

								-- local backentrega = selecionado
								selecionado = selecionado + 1
								if not locs[selecionado] then selecionado = 1 end

								-- while true do
								-- 	if backentrega == selecionado then
								-- 		-- selecionado = math.random(#locs)
								-- 		selecionado = math.random(#locs)
								-- 	else
								-- 		break
								-- 	end
								-- 	Citizen.Wait(5)
								-- end

								CriandoBlip(locs, selecionado)

								vRP.playAnim(cfg.animation.andar, {
									{
										cfg.animation.dict,
										cfg.animation.name,
									},
								}, cfg.animation.loop)
								Citizen.Wait(GetAnimDuration(cfg.animation.dict, cfg.animation.name) * 1000)
								ClearPedTasks(ped)
							end
						end
					end
				end
			elseif distance > 40 then
				sleepThread = 2000
			end
		else
			sleepThread = 3000
		end
		Citizen.Wait(sleepThread)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CANCELAR
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local sleepThread = 5
		if servico then
			if IsControlJustPressed(0, 168) then
				servico = false
				RemoveBlip(blips)
				TriggerEvent("Notify", "aviso", "Você saiu de serviço.")
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
function CriandoBlip(locs, selecionado)
	print(selecionado)
	blips = AddBlipForCoord(locs[selecionado].x, locs[selecionado].y, locs[selecionado].z)
	SetBlipSprite(blips, 1)
	SetBlipColour(blips, 5)
	SetBlipScale(blips, 0.4)
	SetBlipAsShortRange(blips, false)
	SetBlipRoute(blips, true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Entrega de Panfletos")
	EndTextCommandSetBlipName(blips)
end

