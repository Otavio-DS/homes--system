local houseOpen = ""

CreateThread(function()	
	SetNuiFocus(false,false)
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- CHESTCLOSE
-----------------------------------------------------------------------------------------------------------------------------------------

RegisterNUICallback("chestClose",function(data)
	vSERVER.chestClose()
	SetNuiFocus(false,false)
	SendNUIMessage({ action = "hideMenu" })
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- TAKEITEM
-----------------------------------------------------------------------------------------------------------------------------------------

RegisterNUICallback("takeItem",function(data)
	vSERVER.takeItem(tostring(houseOpen),data.item,data.slot,data.amount)
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- STOREITEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("storeItem",function(data)
	print('Tentou store item')
	vSERVER.storeItem(tostring(houseOpen),data.item,data.slot,data.amount)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- POPULATESLOT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("populateSlot",function(data,cb)
	TriggerServerEvent("DS:populateSlot",data.item,data.slot,data.target,data.amount)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATESLOT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("updateSlot",function(data,cb)
	TriggerServerEvent("DS:updateSlot",data.item,data.slot,data.target,data.amount)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATESLOT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("sumSlot",function(data,cb)
	TriggerServerEvent("DS:sumSlot",data.item,data.slot,data.amount)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DS:UPDATE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("DS:Update")
AddEventHandler("DS:Update",function(action)
	print(action,'Action')
	SendNUIMessage({ action = action })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTVAULT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("requestVault",function(data,cb)
	local inventario,inventario2,peso,maxpeso,peso2,maxpeso2,infos = vSERVER.openChest(tostring(houseOpen))
	if inventario then
		cb({ inventario = inventario, inventario2 = inventario2, peso = peso, maxpeso = maxpeso, peso2 = peso2, maxpeso2 = maxpeso2, infos = infos })
	end
end)
RegisterNetEvent("DS:UpdateBlipsHomesEvent")
AddEventHandler("DS:UpdateBlipsHomesEvent",function(source)
	TriggerEvent('DS:UpdateBlipsHomes')
end) 
RegisterNetEvent("DS:UpdateBlipsHomes")
AddEventHandler("DS:UpdateBlipsHomes",function(action)
	TriggerEvent('Notify',evento_aviso,'Carregando blips das casas e dos apartamentos...',5000)

	SetTimeout(5000, function()
		updateBlipHomes()
		TriggerEvent('Notify',evento_sucesso,'Blips das casas <b>Carregado</b>',5000)
	end)

	SetTimeout(5500, function()
		BlipApartamentos()
		TriggerEvent('Notify',evento_sucesso,'Blips dos apartamentos <b>Carregado</b>',5000)
	end)
end)

blipandoCasas = {}
CreateThread(function()
	updateBlipHomes()
end)
 
function updateBlipHomes()
	blipandoCasas = vSERVER.updateListHomeBlip()
end 
-----------------------------------------------------------------------------------------------------------------------------------------
-- Blip Entrar
-----------------------------------------------------------------------------------------------------------------------------------------

local homein = false
CreateThread(function()
	while true do
		local idle = 1000
		local ped = PlayerPedId()
		local playerCoords = GetEntityCoords(ped)
		if blipandoCasas then
			for k,v in pairs(blipandoCasas) do
				if v.x and v.y and v.z then
					local distance = #(playerCoords - vector3(tonumber(v["x"]),tonumber(v["y"]),tonumber(v["z"])))
					if distance < config.visivel then
						idle = 1
						DrawText3D(tonumber(v["x"]),tonumber(v["y"]),tonumber(v["z"]),textoenter,k)
						config.DrawMarkerPorta(tonumber(v["x"]),tonumber(v["y"]),tonumber(v["z"]))
						if distance < config.distanceuse then
							if IsControlJustPressed(0, 38) then 
								TriggerEvent('DS:join',k)
							end
						end
					end
				end 	
			end
		end
		Wait(idle)
	end
end)

function srkhomeexit(interior,home)
	CreateThread(function()
		local blipH = vSERVER.AttBlipHomes(interior)
		while homein do
			local idle = 1000
			local ped = PlayerPedId()
			local playerCoords = GetEntityCoords(ped)
			local distance = #(playerCoords - vector3(blipH.x,blipH.y,blipH.z))
			if distance < config.visivel then
				idle = 1
				DrawText3D(blipH.x,blipH.y,blipH.z, textosair)
				config.DrawMarkerPorta(blipH.x,blipH.y,blipH.z)
				if distance < config.distanceuse then
					if IsControlJustPressed(0, 38) and distance <= 1.0 then 
						TriggerEvent('DS:exit',home)
					end
				end
			end	
			Wait(idle)
		end
	end)
end

function srkhomechest(interior,home)
	CreateThread(function()
		local xV,yV,zV,bau,xR,yR,zR = vSERVER.HouseChest(interior,home)
		while homein do
			local idle = 1000
			local ped = PlayerPedId()
			local playerCoords = GetEntityCoords(ped)
			local distance = #(playerCoords - vector3(xV,yV,zV))
			if distance < config.visivel then 
				idle = 1
				DrawText3D(xV,yV,zV,textobau)
				config.DrawMarkerBau(xV,yV,zV)
				if distance < config.distanceuse then
					if IsControlJustPressed(0, 38) then 
						if config.chestcustomclient then 
							chestcustomopenclient(home)
						elseif config.chestcustomserver then
							vSERVER.openChestcustom(home)
						else
						TriggerEvent('DS:chest',home)
						end
					end
				end
			end
			local distance2 = #(playerCoords - vector3(xR,yR,zR))
			if distance2 < config.visivel then
				idle = 1
				DrawText3D(xR,yR,zR,textoroupas)
				config.DrawMarkerRoupas(xR,yR,zR)
				print(distance)
				if distance < 4.0 then
					if IsControlJustPressed(0, 38) then 
						if config.roupascustom then 
							roupascustomopen(home) 
						else
							TriggerEvent('DS:roupas',home)
						end
					end
				end
			end		
			Wait(idle)
		end
	end)
end

roupaHome = ''
AddEventHandler('DS:roupas',function(home)
	roupaHome = home
	owner = vSERVER.OwnerOrVisit(home)
	if owner == 'dono' or owner == 'morador' then
		exports["dynamic"]:SubMenu("Guarda Roupa","Escolher roupas.","Roupinhas")
		exports["dynamic"]:AddButton("Minhas roupas","Visualizar roupas salvas","MyClothes",home,"Roupinhas",false)
		exports["dynamic"]:AddButton("Salvar Roupa","Salvar Outfit que está vestido.","SaveOutfit",home,"Roupinhas",false)
	else
		TriggerEvent('Notify', evento_negado, 'Você não pode olhar este guarda roupas.', 5000)
	end
end)

AddEventHandler('MyClothes',function(home)
	TriggerEvent('dynamic:closeSystem2')
	local MyClothes = vSERVER.ArmarioPlayer(home)
	if #json.encode(MyClothes) <= 0 then
		TriggerEvent('Notify',evento_aviso,'Você não tem Outfit salvo no momento!')
		return 
	end
	for k,v in pairs(MyClothes) do
		exports["dynamic"]:SubMenu("Outfit: "..k,"Escolher roupa.","Roupinhas:"..k)
		exports["dynamic"]:AddButton("Aplicar Modelo: "..k,"Escolhe esse outfit","ApplyOutfit",k,"Roupinhas:"..k,false)
		exports["dynamic"]:AddButton("Remover Modelo: "..k,"Remove Outfit","RemoveOutfit",k,"Roupinhas:"..k,false)
	end
end)

AddEventHandler('SaveOutfit',function(home) 
	TriggerEvent('dynamic:closeSystem2')
	local MyClothes = vSERVER.ArmarioPlayer(roupaHome,'save')
end)

AddEventHandler('RemoveOutfit',function(k)
	TriggerEvent('dynamic:closeSystem2')
	local MyClothes = vSERVER.ArmarioPlayer(roupaHome,'rem',k)
end)

AddEventHandler("ApplyOutfit",function(k)
	TriggerEvent('dynamic:closeSystem2')
	local MyClothes = vSERVER.ArmarioPlayer(roupaHome,'apply',k)
end)

owner = ''
 
RegisterNetEvent('DS:joinInvade')
AddEventHandler("DS:joinInvade",function(home,user_id)
	if vSERVER.checkPolice() then 
		exports["dynamic"]:SubMenu("Casa "..home,"Gerenciar a casa.","CasaOptions")
		exports["dynamic"]:AddButton("Entrar","Entrar na casa","HomesOptionsPolice",home,"CasaOptions",false)
		exports["dynamic"]:SubMenu("Moradores","Gerenciar moradores.","moradores")
		exports["dynamic"]:AddButton("Listar","Ver todos moradores","Moradores1",home,"moradores",false)
	end
end)

function src.checkPlayerPed()
	local Coords = GetEntityCoords(PlayerPedId())
	return Coords
end

function src.invadeHomes(home)
	if vSERVER.checkPolice() then 
		exports["dynamic"]:SubMenu("Casa "..home,"Gerenciar a casa.","CasaOptions")
		exports["dynamic"]:AddButton("Entrar","Entrar na casa","HomesOptionsPolice",home,"CasaOptions",false)
		exports["dynamic"]:SubMenu("Moradores","Gerenciar moradores.","moradores")
		exports["dynamic"]:AddButton("Listar","Ver todos moradores","Moradores1",home,"moradores",false)
	end 
end
RegisterNetEvent('DS:join')
AddEventHandler("DS:join",function(home)
	owner = vSERVER.OwnerOrVisit(home)
	exports["dynamic"]:SubMenu("Entrar "..home,"Entrar na Residência.","HomeEnter")
	exports["dynamic"]:AddButton("Entrar","Entrar na casa","HomesOptions",home,"HomeEnter",false)

	
	
	if owner == 'dono' or owner == 'morador' then 
		if AlterarInterior then 
			if owner == 'dono' then 
				exports["dynamic"]:SubMenu("Casa "..home,"Gerenciar a casa.","CasaOptions")
				exports["dynamic"]:AddButton("Contas","Visualizar e pagar contas.","HomeTransfer",home,"CasaOptions",false)
				exports["dynamic"]:AddButton("Garagem","Trocar de lugar","ChangeGarage",home,"CasaOptions",false)
				exports["dynamic"]:AddButton("Interior","Opções de interior","ChangeInterior",home,"CasaOptions",false)
				exports["dynamic"]:AddButton("Bau","Aumentar o tamanho do bau","UpgradeChest",home,"CasaOptions",false)
				exports["dynamic"]:AddButton("Vender","Vender Residência","VenderCasas",home,"CasaOptions",false)
			end 
			exports["dynamic"]:SubMenu("Moradores","Gerenciar moradores.","moradores")
			exports["dynamic"]:AddButton("Listar","Ver todos moradores","Moradores1",home,"moradores",false)
			exports["dynamic"]:AddButton("Adicionar","Adicionar morador","AddMorador",home,"moradores",false) 
		else
			if owner == 'dono' then 
				exports["dynamic"]:AddButton("Contas","Visualizar e pagar contas.","HomeTransfer",home,"CasaOptions",false)
				exports["dynamic"]:AddButton("Garagem","Trocar de lugar","ChangeGarage",home,"CasaOptions",false)
				exports["dynamic"]:AddButton("Bau","Aumentar o tamanho do bau","UpgradeChest",home,"CasaOptions",false)
			end 
			exports["dynamic"]:SubMenu("Moradores","Gerenciar moradores.","moradores")
			exports["dynamic"]:AddButton("Listar","Ver todos moradores","Moradores1",home,"moradores",false)
			exports["dynamic"]:AddButton("Adicionar","Adicionar morador","AddMorador",home,"moradores",false) 
		end
	end 
end)

inthome = ''
AddEventHandler('ChangeInterior',function(home)
	TriggerEvent('dynamic:closeSystem2')
	inthome = home 
	local interior1 = vSERVER.GettAllInterior()
	for k,v in pairs(interior1)	do
		exports["dynamic"]:SubMenu("Interior <b>"..k,v.info,"int"..k)
		exports["dynamic"]:AddButton("Aplicar "..k,'Preço: '..v.price,"ApplyIntChange",k,"int"..k,false)
	end 
end)

AddEventHandler("UpgradeChest",function(home)
	TriggerEvent('dynamic:closeSystem2')
	inthome = home
	exports["dynamic"]:SubMenu("Bau","Tamanhos disponiveis.","chestOption")
	for k,v in pairs(config.chest) do 
		exports["dynamic"]:AddButton('Tipo: <b>'..k,"Tamnho: "..v.size,'ChestUpdate',k,"chestOption",false)
	end 
end)

AddEventHandler('ChestUpdate',function(k)
	TriggerEvent('dynamic:closeSystem2')
		vSERVER.houseChangesPay('MoreBau',k,inthome)
end)

AddEventHandler('ApplyIntChange',function(k)
	TriggerEvent('dynamic:closeSystem2')
	if vSERVER.ChangeInterior(inthome,k) then 
		TriggerEvent('Notify',evento_sucesso,config.sucessointerior)
	else
		TriggerEvent('Notify',evento_negado,config.negadointerior)
	end 
end)

AddEventHandler('HomeTransfer',function(home)
	TriggerEvent('dynamic:closeSystem2')
	exports["dynamic"]:SubMenu("Taxa da <b>"..home,"Opções da taxa da casa.","Tax")
	exports["dynamic"]:AddButton("Visualizar","Consulta a taxa pendente","TaxConsult",home,"Tax",false)
	exports["dynamic"]:AddButton("Pagar","Pagar as taxas da casas","TaxPay",home,"Tax",false)


	exports["dynamic"]:AddButton("Voltar","Volta para as opções da casa","HomeBegin",home,"Tax",false)
end)

AddEventHandler('TaxPay',function(home)
	TriggerEvent('dynamic:closeSystem2')
	TriggerServerEvent('HomesOptions2',home,'tax')
end)

AddEventHandler('TaxConsult',function(homeName)
	TriggerEvent('dynamic:closeSystem2')
	TriggerServerEvent('HomesOptions2',homeName,'taxConsult')
end)

AddEventHandler('AddMorador',function(home)
	TriggerEvent('dynamic:closeSystem2')
	-- TriggerEvent('Notify','negado','Você não tem permissão para isso!')
	if owner == 'dono' then 
		TriggerServerEvent('HomesOptions2',home,'add')
	end 
end)
AddEventHandler('HomeBegin',function(home)
	TriggerEvent('dynamic:closeSystem2')
	TriggerEvent('DS:join',home)
end)

morador = {}
AddEventHandler('Moradores1',function(home)
	TriggerEvent('dynamic:closeSystem2')

	local userHomes = vSERVER.ListarMoradores(home)
	if userHomes == 'nada' then 
		TriggerEvent("Notify",evento_negado,"Nada para se ver aqui...",20000)
		return 
	end 

	for k,v in pairs(userHomes) do
		if v.user_id ~= user_id then
			morador = { user_id = v.user_id }
			exports["dynamic"]:SubMenu(v.name..', '..v.firstname,"Passaporte: "..v.user_id,'Acao'..v.user_id)
			if owner == 'dono' then 
				exports["dynamic"]:AddButton("Garagem","Dar chave para: "..v.name..', '..v.firstname,"GarageKey",home,"Acao"..v.user_id,false)
				exports["dynamic"]:AddButton("Transferir","Transferir casa para: "..v.name..', '..v.firstname,"HousePosse",home,"Acao"..v.user_id,false)
				exports["dynamic"]:AddButton("Remover","Remover as chaves do morador","RemoverChaves",home,'Acao'..v.user_id,false)
				exports["dynamic"]:AddButton("Voltar","Volta para as opções da casa","HomeBegin",home,'Acao'..v.user_id,false)
			end 
		end
		Wait(10)
	end
	
end)

AddEventHandler("HousePosse",function(home)
	TriggerEvent('dynamic:closeSystem2')
	TriggerServerEvent('HomesOptions2',home,'transfer',morador.user_id)
	morador = {}
end)

AddEventHandler('GarageKey',function(home)
	TriggerEvent('dynamic:closeSystem2')
	TriggerServerEvent('HomesOptions2',home,'garage',morador.user_id)
	morador = {}
end)

AddEventHandler('RemoverChaves',function(home)
	TriggerEvent('dynamic:closeSystem2')	
	TriggerServerEvent('HomesOptions2',home,'rem',morador.user_id)
	morador = {}
end)

RegisterNetEvent('HomesOptions')
AddEventHandler('HomesOptions',function(home)
	TriggerEvent('dynamic:closeSystem2')
	local ped = PlayerPedId()
	local x,y,z = table.unpack(GetEntityCoords(ped))
	local xH,yH,zH,hH,interior = vSERVER.InteriorTypeSet(home)
	if vSERVER.checkPermissions(home) then
		
		srkhomechest(interior,home)

		LocalPlayer.state.homeselistore = true

		srkhomeexit(interior,home)
		homein = true
		DoScreenFadeOut(1000)
		TriggerEvent("vrp_sound:source","enterexithouse",0.7)
		vSERVER.RouteBuck()
		if config.houseDecor then 
			TriggerEvent('HomeDecorationApply',home,true,owner)
		end 

		SetTimeout(1400,function()
			SetEntityCoords(ped,xH,yH,zH,1,0,0,1)
			SetEntityHeading(ped, hH)

			Wait(750)
			DoScreenFadeIn(1000)
			houseOpen = tostring(home)
			LimboserChecker(xH,yH,zH,hH)
		end)
	end
end)
RegisterNetEvent('HomesOptionsPolice')
AddEventHandler('HomesOptionsPolice',function(home)
	TriggerEvent('dynamic:closeSystem2')
	local ped = PlayerPedId()
	local x,y,z = table.unpack(GetEntityCoords(ped))
	local xH,yH,zH,hH,interior = vSERVER.InteriorTypeSet(home)
	if vSERVER.checkPolice(home) then
		
		srkhomechest(interior,home)

		LocalPlayer.state.homeselistore = true

		srkhomeexit(interior,home)
		homein = true
		DoScreenFadeOut(1000)
		TriggerEvent("vrp_sound:source","enterexithouse",0.7)
		vSERVER.RouteBuck()
		if config.houseDecor then 
			TriggerEvent('HomeDecorationApply',home,true,owner)
		end 

		SetTimeout(1400,function()
			SetEntityCoords(ped,xH,yH,zH,1,0,0,1)
			SetEntityHeading(ped, hH)

			Wait(750)
			DoScreenFadeIn(1000)
			houseOpen = tostring(home)
			LimboserChecker(xH,yH,zH,hH)
		end)
	end
end)

function LimboserChecker(xH,yH,zH,hH)
	CreateThread(function()
		local ped = PlayerPedId()
		while true do 
	
			--local x,y,z = table.unpack(GetEntityCoords(ped))
			--local cds = GetDistanceBetweenCoords(x,y,z,xH,yH,zH,true)

			if IsPedFalling(ped) then 
				TriggerEvent('Notify',evento_aviso,'Você está limbando, aguarde, já iremos te por de volta!',1900)
				SetEntityCoords(ped,xH,yH,zH,1,0,0,1)
				SetEntityHeading(ped, hH)
				Wait(2000)
			else 
				break 
			end 
			Wait(4)
		end 
	end)
end 

RegisterNetEvent("DS:exit")
AddEventHandler("DS:exit",function(home)
	if owner == 'dono' and config.houseDecor then 
		exports["dynamic"]:SubMenu('Decorar a '..home, 'Mobiliar a casa','decorando')
		exports["dynamic"]:AddButton("Iniciar decoração","Começará a mobiliar","HomeDecoration",home,'decorando',false)
		exports["dynamic"]:AddButton("Sair da casa","Sair da casa","HouseExit",home,'decorando',false)
	else 
		TriggerEvent('HouseExit',home)
	end 
end)

AddEventHandler('HouseExit',function(home)
	TriggerEvent('dynamic:closeSystem2')
	local ped = PlayerPedId()
	local x,y,z = table.unpack(GetEntityCoords(ped))

	local xH,yH,zH = vSERVER.HouseDoor(home)

	if LocalPlayer.state.homeselistore then
		LocalPlayer.state.homeselistore = nil
	end
	homein = false
	DoScreenFadeOut(1000)
	TriggerEvent("vrp_sound:source","enterexithouse",0.5)
	vSERVER.RouteBuck()
	if config.houseDecor then 
		TriggerEvent('HomeDecorationApply',home,false,owner)
	end 
	SetTimeout(1300,function()
		SetEntityCoords(ped,tonumber(xH),tonumber(yH),tonumber(zH),1,0,0,1)
		Wait(750)
		DoScreenFadeIn(1000)
		houseOpen = ""
	end)		
end)

RegisterNetEvent("DS:chest")
AddEventHandler("DS:chest",function(home)
	-- if vSERVER.checkIntPermissions(home) then
		-- if vSERVER.antidumphomes(home) then
			if config.chestcustomclient then 
				chestcustomopenclient(home)
			elseif config.chestcustomserver then
				vSERVER.openChestcustom(home)
			else
				TriggerEvent("vrp_sound:source","mochila",0.5)
				SetNuiFocus(true,true)
				SendNUIMessage({ action = "showMenu" })
				houseOpen = tostring(home)
			end
		-- else
		-- 	TriggerEvent("Notify",evento_negado,"Existe outra pessoa utilizando o bau.")
		-- end
	-- end
end)

modGaragem = false
AddEventHandler('ChangeGarage',function(home)
	TriggerEvent('dynamic:closeSystem2')
	local pagamento = vSERVER.houseChangesPay('ChangeGarage')
	if not pagamento then 
		if AlterarGaragem then
		return
		TriggerEvent('Notify', evento_negado, config.negadogaragem)
		else
		return
		-- TriggerEvent('Notify', evento_negado, config.npodemudargarage)
	end 
end

	local ped = PlayerPedId()
    local position = GetEntityCoords(ped)
	local acesso = 0
	local notify = 0
	local BlipGaragem = {}
	local vehSpawn = {}

	modGaragem = not modGaragem 
	CreateThread(function()
		while modGaragem do 
			local time = 4
			local position = GetEntityCoords(ped) 
			if acesso == 0 then 
				drawTxt("~r~E~w~  PARA CONFIRMAR ~g~BLIP",4,0.5,0.93,0.50,255,255,255,180)
				if notify == 0 then 
					TriggerEvent('Notify',evento_aviso,config.buygarage,5000)
					notify = 1
				end 
				if IsControlJustPressed(0,38) then 
					notify = 0
					TriggerEvent('progress',3000,'Salvando')
					Wait(3000)
					acesso = 1
					BlipGaragem = position
					TriggerEvent('Notify',evento_sucesso,config.savegarage)
				end
			elseif acesso == 1 then 
				local heading = GetEntityHeading(ped)
				drawTxt("~r~E~w~  PARA CONFIRMAR ~g~SPAWN DO VEICULO",4,0.5,0.93,0.50,255,255,255,250)
				drawTxt("~r~Ângulo~w~ em que será spawnado: ~r~"..string.format("%.2f",heading)..' ~w~ºGraus',4,0.5,0.88,0.50,255,255,255,250)
				if notify == 0 then 
					TriggerEvent('Notify',evento_aviso,config.carspawn,5000)
					notify = 1
				end 

				if IsControlJustPressed(0,38) then
					TriggerEvent('progress',3000,'Salvando')
					Wait(3000) 
					modGaragem = false
					vehSpawn = position
					TriggerEvent('Notify',evento_sucesso,config.blipsalvo)
					vSERVER.updateGarage(home,BlipGaragem,vehSpawn,heading)
					BlipGaragem = {}
					vehSpawn = {}
				end
			end 
			Wait(time)
		end 
	end)
end)
----------------- Criar casas
--------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------
-- 				APARTAMENTOS
--------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------
Choices = {} -- Gerenciando todas as infos aqui, pra no final passar tudo de uma vez só, Passado para o Config

RegisterNetEvent("InvokeHomeAndAp")
AddEventHandler("InvokeHomeAndAp",function(tipo)
	local sourceP = GetPlayerServerId(PlayerId()) 
	Choices[sourceP]['typer'] = tipo

	TriggerEvent('dynamic:closeSystem2')
-----------------------------------------------------------------------------
-- 			BAUS
-----------------------------------------------------------------------------
	exports["dynamic"]:SubMenu('<b>BAU</b>','Tamanho do baú!','chestHouse')
	for k,v in pairs(config.chest) do 
		exports["dynamic"]:AddButton('Modelo: '..k,v.info,'applyChest',v.size,'chestHouse',false)
	end 
----------------------------------------------------------------------
	local interiores1 = vSERVER.GettAllInterior()
	exports["dynamic"]:SubMenu("<b>Interiores</b>",'Escolha o interior que deseja aplicar!','Interiores')
	if tipo == 'casinha' then 
		for k,v in pairs(interiores1)	do
			exports["dynamic"]:AddButton("<b>"..k.."</b>",'Escolher este modelo!',"CreateHouse",k,'Interiores',false)
		end
		exports["dynamic"]:SubMenu('<b>Nome da casa</b>','Como vai se chamar a casa?','newHouse')
		exports["dynamic"]:AddButton('Escolher nome: ','Informe como a casa irá se chamar','newHouse',5,'newHouse',false)
	elseif tipo == 'apartamento' then 
		for k,v in pairs(config.Apartamento)	do
			exports["dynamic"]:AddButton("<b>"..k.."</b>",'Escolher este modelo!',"CreateHouse",k,'Interiores',false)
		end 
		exports["dynamic"]:SubMenu('<b>Nº de APs</b>','Quantos apartamentos no prédio?','qtdAps')
		for i = config.QTDaps['min'], config.QTDaps['max'] do 
			exports["dynamic"]:AddButton(i..' apartamentos','Aplicar '..i..' apartamentos','qtdAps',i,'qtdAps',false)
		end 
	end 
 
	exports["dynamic"]:SubMenu('<b>Finalizar</b>','Finalizar Criação de casas','finalizarCreate')
	exports["dynamic"]:AddButton('<b>Confirmar</b>','Finalizar e criar moradia','FinishChoices',Choices[sourceP],'finalizarCreate',false)
end)

function src.updateHomes(status)
	homesList = status
end

RegisterNetEvent("newHouse")
AddEventHandler("newHouse",function(tipo)
	local sourceP = GetPlayerServerId(PlayerId())
	local nome = vSERVER.prompt('Informe o nome da casa: (SEM espaços, acento e caracteres especiais!)','')
	if nome == '' then TriggerEvent('Notify',evento_aviso,'Informe o nome da casa!') return end 
	Choices[sourceP]['nameH'] = tostring(nome) 
	TriggerEvent('Notify',evento_sucesso,'O nome: <b>'..nome..'</b>, foi escolhido com sucesso!')
end)

RegisterNetEvent("applyChest")
AddEventHandler("applyChest",function(size)
	local sourceP = GetPlayerServerId(PlayerId())
	Choices[sourceP]['bau'] = size
	TriggerEvent('Notify',evento_sucesso,'O tamanho do bau: <b>'..size..'</b>, foi escolhido com sucesso!')
end)

RegisterNetEvent("CreateHouse")
AddEventHandler("CreateHouse",function(tipo)
	local sourceP = GetPlayerServerId(PlayerId())
	Choices[sourceP]['interior'] = tipo
	TriggerEvent('Notify',evento_sucesso,'O interior: <b>'..tipo..'</b>, foi escolhido com sucesso!')
end)

RegisterNetEvent("qtdAps")
AddEventHandler("qtdAps",function(quantidade)
	local sourceP = GetPlayerServerId(PlayerId())
	Choices[sourceP]['qtd'] = quantidade
	TriggerEvent('Notify',evento_sucesso,'Escolheu <b>Nº: '..quantidade..'</b> apartamentos neste prédio!')

end)

RegisterNetEvent("FinishChoices")
AddEventHandler("FinishChoices",function(data)
	TriggerEvent('dynamic:closeSystem2')
	local sourceP = GetPlayerServerId(PlayerId())
	local cds = GetEntityCoords(PlayerPedId())
	Choices[sourceP]['cds'] = cds 
	Choices[sourceP]['finish'] = 'end'

	local LastTable = {
		[1] = Choices[sourceP]
	}
    vSERVER.FinishChoices(LastTable)
    Choices[sourceP] = nil -- Limpar Table
end)
RegisterNetEvent("DeleteChoices")
AddEventHandler("DeleteChoices",function(data)
	TriggerEvent('dynamic:closeSystem2')
	local sourceP = GetPlayerServerId(PlayerId())
	local cds = GetEntityCoords(PlayerPedId())
	Choices[sourceP]['cds'] = cds 
	Choices[sourceP]['finish'] = 'end'

	local LastTable = {
		[1] = Choices[sourceP]
	}
    vSERVER.DeleteChoices(LastTable)
    Choices[sourceP] = nil -- Limpar Table
end)
RegisterNetEvent("VenderCasas")
AddEventHandler("VenderCasas",function(data)
	TriggerEvent('dynamic:closeSystem2')
	local sourceP = GetPlayerServerId(PlayerId())
	local cds = GetEntityCoords(PlayerPedId())
    vSERVER.VenderResidencia(LastTable)
end)
----------------- Criar casas
-------------------------------------------------------------------
-- Roda uma vez e morre!
-------------------------------------------------------------------
BlipAP = {}
CreateThread(function()
	BlipApartamentos()
end)
------
function BlipApartamentos()
	BlipAP = vSERVER.APlocations()
end 
---------------------------------------------------------------
-- modelo do objeto de interfone: 623406777
-- modelo do objeto de interfone: xxxxxx

------
-- THREAD 1 - FUNCIONA POR OBJETO, CHEGANDO PERTO DO PROP, JA MOSTRA PRA INTERFONAR
------w
local blip1 = {}

-- CreateThread(function()
-- 	while true do
-- 		local idle = 1000
-- 		local ped = PlayerPedId()
-- 		local pedCds = GetEntityCoords(ped)

-- 		local interfone = GetClosestObjectOfType(pedCds,2.0,623406777,0,0,0)
-- 		local x2,y2,z2 = table.unpack(GetEntityCoords(interfone))
-- 		if DoesEntityExist(interfone) then
-- 			idle = 5					
-- 			DrawText3D(x2,y2,z2+0.2,"~b~E~w~<br>INTERFONAR~w~",350)
-- 			if blip1[ped] ~= nil then 
-- 				if IsControlJustPressed(0,38) then 
-- 					TriggerEvent('LatinoFestaNoAP',blip1[ped])
-- 				end 
-- 			else 
-- 				for k,v in pairs(BlipAP) do
-- 					local distance2 = #(pedCds - vector3(tonumber(v["x"]),tonumber(v["y"]),tonumber(v["z"])))
					
-- 					if distance2 <= 1.5 then 
-- 						blip1[ped] = v.Apartamentos
-- 						break
-- 					end
-- 				end
-- 			end
-- 		else 
-- 			blip1[ped] = nil
-- 		end 	
-- 		Wait(idle)
-- 	end 					
-- end) 

-----------------------
-- THREAD 2 - Funciona puxando na config as loce marcando no marca qnd o player tiver proximo.
-----------------------
CreateThread(function()
	while true do
		local idle = 1000
		local ped = PlayerPedId()
		local pedCds = GetEntityCoords(ped)

		for k,v in pairs(BlipAP) do 
			local distance = #(pedCds - vector3(tonumber(v["x"]),tonumber(v["y"]),tonumber(v["z"])))
			if distance <= config.visivel then 
				idle = 1
				DrawText3D(tonumber(v.x),tonumber(v.y),tonumber(v.z),textoInterfonar)
				config.DrawMarkerPorta(tonumber(v.x),tonumber(v.y),tonumber(v.z))
				if distance < config.distanceuse then
					if IsControlJustPressed(0,38) then 
						TriggerEvent('LatinoFestaNoAP',v.Apartamentos)
					end 
				end
			end 
		end 
		Wait(idle)
	end
end)

RegisterNetEvent("LatinoFestaNoAP")
AddEventHandler("LatinoFestaNoAP",function(name) -- Vai puxar o nome pela coord!
	local data = vSERVER.getApartamento(name)
	local predioName = name
	local i = 0 
	if next(data) then 
		exports["dynamic"]:SubMenu('<b>[ '..predioName:gsub('"', '')..' Tower] </b>','Tocar o inferfone','Interfonezin')
		for user_id,v in pairs(data) do
			i = i + 1 
			user_id = tonumber(user_id)
			exports["dynamic"]:AddButton('AP: 0'..i,'[DONO:] '..vSERVER.GetName(user_id),'CampainhaAP',user_id..'/'..name,'Interfonezin',false)-- Irão sair, pois a tabela irá retornar e preencher as colunas, mas é só pro visual por hora..
		end
	end 
	exports["dynamic"]:SubMenu('<b>[OPÇÕES]</b>','Listar opções','optionsAP') -- kaique
	exports["dynamic"]:AddButton('Comprar','Adquirir um imóvel neste Apartamento','optionsAP','buy'..'/'..predioName:gsub('"', ''),'optionsAP',false)
	if vSERVER.IsOwner(predioName:gsub('"', '')) then 
		exports["dynamic"]:AddButton('Vender','Vender seu Imóvel','optionsAP','sell'..'/'..predioName:gsub('"', ''),'optionsAP',false)
	end 
end)

RegisterNetEvent("optionsAP")
AddEventHandler("optionsAP",function(demand)
	local data = {}
	for w in demand:gmatch("([^/]+)") do 
		table.insert(data,w)
	end
	if data[1] == 'buy' then 
		vSERVER.BuyApartment(data[2])
	elseif data[1] == 'sell' then 
		TriggerEvent('dynamic:closeSystem2')
		exports["dynamic"]:SubMenu('<b>Opções</b>','Listar opções','sellOptions')
		exports["dynamic"]:AddButton('Cidadão','Vender o imóvel para um cidadão','sellOptions','player/'..data[2],'sellOptions',false)
	end 
end)

RegisterNetEvent("sellOptions")
AddEventHandler("sellOptions",function(stringer)
	TriggerEvent('dynamic:closeSystem2')
	local data = {}
	for w in stringer:gmatch("([^/]+)") do 
		table.insert(data,w)
	end
	vSERVER.SellApartment(data)
end)

RegisterNetEvent("CampainhaAP")
AddEventHandler("CampainhaAP",function(stringer)
	TriggerEvent('dynamic:closeSystem2')
	if type(stringer) == 'string' then 
		local data = {}
		for w in stringer:gmatch("([^/]+)") do 
			table.insert(data,w)
		end
		vRP._playAnim(false,{{"amb@prop_human_atm@male@idle_a","idle_a"}},true)
		if vSERVER.APjoin(data,true) then 
			LocalPlayer.state.homeselistore = true
			local coordinate = config.Apartamento[data[2]]['location']
			local xH,yH,zH,hH = coordinate.x, coordinate.y, coordinate.z, coordinate.h
			local ped = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(ped))
			DoScreenFadeOut(1000)
			TriggerEvent("vrp_sound:source","enterexithouse",0.7)

			SetTimeout(1400,function()
				SetEntityCoords(ped,xH,yH,zH,1,0,0,1)
				SetEntityHeading(ped, hH)

				Wait(750)
				DoScreenFadeIn(1000)
				LimboserChecker(xH,yH,zH,hH)
				ApExit(data[2])
			end)
		end 
	else 
		local inside, cds = vSERVER.APjoin(nil,false) 
		if inside then 
			local xH,yH,zH,hH = table.unpack(cds)
			local ped = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(ped))
			if LocalPlayer.state.homeselistore then
				LocalPlayer.state.homeselistore = nil
			end
			DoScreenFadeOut(1000)
			TriggerEvent("vrp_sound:source","enterexithouse",0.7)

			SetTimeout(1400,function()
				SetEntityCoords(ped,xH,yH,zH,1,0,0,1)
				SetEntityHeading(ped, hH)

				Wait(750)
				DoScreenFadeIn(1000)
				LimboserChecker(xH,yH,zH,hH)
			end)
		end 
	end 
end)
function ApExit(name,home)
	print(name)
	local exit = config.Apartamento[name]['location']
	-- print(exit)
	local vault = config.Apartamento[name]['vault']
	local home = vSERVER.pegarUserId()	
	print(home)
	print(json.encode(vault))
	CreateThread(function()
		while true do
			local idle = 1000
			local ped = PlayerPedId()
			local pedCds = GetEntityCoords(ped)

			local distanceExit = #(pedCds - vector3(exit.x,exit.y,exit.z))
			local distanceVault = #(pedCds - vector3(vault.x,vault.y,vault.z))
			if distanceExit <= 1.5 then 
				idle = 5
				DrawText3D(exit.x,exit.y,exit.z,textosair)
				if IsControlJustPressed(0,38) then 
					TriggerEvent('CampainhaAP',false)
					break 
				end 
			elseif distanceVault < 1.5 then 
				idle = 5
				DrawText3D(vault.x,vault.y,vault.z,textobau,true)
				if IsControlJustPressed(0,38) then 
					print(home)
					TriggerEvent('DS:chest',home)
				end 
			end 
	
			Wait(idle)
		end
	end)
end 
function src.PutMeBackToTheWorld()
	DoScreenFadeOut(1000)
	SetTimeout(1400,function()
		SetEntityCoords(PlayerPedId(),-1795.35, -1174.72, 13.02)

		Wait(750)

		DoScreenFadeIn(1000)
	end)
end 
--------------------------------------------------------------------------------------------------
function src.getHomeStatistics()
	return tostring(houseOpen)
end

function src.setBlipsOwner(homeName,x,y,z)
	local blip = AddBlipForCoord(x,y,z)
	SetBlipSprite(blip,411)
	SetBlipAsShortRange(blip,true)
	SetBlipColour(blip,36)
	SetBlipScale(blip,0.4)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Residência: ~g~"..homeName)
	EndTextCommandSetBlipName(blip)
end

local blip2 = {}
function src.setBlipsHomes(blipa,houses)
	local cor = nil
	local text = ''

	if not blipa then 
		for k,v in pairs(blip2) do 
			if DoesBlipExist(v) then
				RemoveBlip(v)
			end
		end 
	else 
		for k,v in pairs(houses) do
			if v.transferivel == 'sold' then 
				cor = 1
				text = '~r~Vendida: ~w~'..k
			else 
				cor = 2
				text = "Disponível: ~g~"..k
			end
			
			blip2[k] = AddBlipForCoord(tonumber(v.x),tonumber(v.y),tonumber(v.z))
			SetBlipSprite(blip2[k],411)
			SetBlipAsShortRange(blip2[k],true)
			SetBlipColour(blip2[k],cor)
			SetBlipScale(blip2[k],0.4)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString(text)
			EndTextCommandSetBlipName(blip2[k])
		end
		SetTimeout(30000,function()
			for k,v in pairs(blip2) do 
				if DoesBlipExist(v) then
					RemoveBlip(v)
				end
			end
		end)
	end 
end

function DrawText3D(x,y,z,text,sphere)
	local onScreen,_x,_y = World3dToScreen2d(x,y,z)
	SetTextFont(4)
	SetTextScale(0.35,0.35)
	SetTextColour(255,255,255,255)
	SetTextEntry("STRING")
	SetTextCentre(1)
	AddTextComponentString(text)
	DrawText(_x,_y)
	local factor = (string.len(text)) / 400
	-- if not sphere then 
	-- 	DrawSphere(x,y,z-0.05, 0.25, 148, 0, 211, 0.2)
	-- end 
end

function drawTxt(text, font, x, y, scale, r, g, b, a)
    SetTextFont(font)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextOutline()
    SetTextCentre(1)
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x, y)
end