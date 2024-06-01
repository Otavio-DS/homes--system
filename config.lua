config = {} 
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------- [ WEBHOOKs ] -----------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

config.iptu = 'WEBHOOK' -- Log do pagamento do IPTU 
config.vender = 'WEBHOOK' -- Log de venda de residências para a prefeitura
config.delete = 'WEBHOOK' -- Log referente a delete de residências
config.darcasa = 'WEBHOOK' -- Log de adição de casas
config.invasao = 'WEBHOOK' -- Log de invasão a residências
config.remcasa = 'WEBHOOK' -- Log de remoção de casas
config.criarap = 'WEBHOOK' -- Webhook log de criação de apartamentos
config.criarcasa = 'WEBHOOK' -- Webhook log de criação de casas
config.buyhomes = 'WEBHOOK' -- Log de compra de casas
config.transfer = 'WEBHOOK' -- Log de trasnferência do imóvel
config.addhomes = 'WEBHOOK' -- Log de adição de permissão na casa
config.remhomes = 'WEBHOOK' -- Log de remoção de permissão na casa
config.bugRotear = 'WEBHOOK' -- Log de pessoa tentando bugar pra sair da casa
config.addpermgarage = 'WEBHOOK' -- Log de adição de permissão na garagem da casa
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------- [ SCRIPT ELITE HOMES ] -----------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
AlterarInterior = true -- Se quiser deixar a opção de mudança de interior ativada deixe true
AlterarGaragem = true -- Se quiser deixar a opção do Player escolher onde vai querer a garagem, deixe true

config.DeleteBau = false -- Se quiser que quando a casa for deletada perca as coisas do baú 
config.policePerm = 'policia.permissao' -- Permissao para que poderá fazer invasões
config.permissaoadd = 'addhomes.permissao' -- Permissão para adicionar casas
config.permissaorem = 'remhomes.permissao' -- Permissão para remover casas
config.admpermissao = 'manager.permissao' -- Permissão que poderá CRIAR casas na cidade
config.houseDecor = false -- Se vc usa o sistema de decoração, deixa ativado. Se vc não tiver e deixar true, vai crashar! (Ainda sem funcionamento)
config.IsMoneyItem = true -- Se na sua base o dinheiro for item deixar igual true, se for carteira então false
config.chestcustomclient = false -- Se o evento do seu Inventário for via Client-Side deixe true e o de baixo false
config.chestcustomserver = false -- Se o evento do seu Inventário for via Server-Side deixe true e o de cima false
config.roupascustom = false -- Caso use Guarda Roupas personalizados (Como o do nyo)
config.garagevalor = '500000' -- Valor para adicionar/mudar de posição a gargem
config.qtdvalegaragem = 12 -- Quantidade de itens (VIPs) necessário para adicionar/mudar a posição da garagem (Com esse item, não precisa de dinheiro para mexer na garagem)
config.addgarage = '100' -- Valor para adicionar permissão a outro morador na garagem
config.NameItemMoney = '		' -- Como se chama o nome do item dinheiro na sua base? Mudar aqui
config.taxas = 0.15 -- Taxa das residências em % (Normais) (Atual, 15%)
config.taxvip = 0.000020 -- Taxa das casas VIPs (Para que essa taxa se aplique o valor das residências devem estar a cima de R$999.999.9 )
config.porcentagemVenda = 0.10 -- Porcentagem do valor total da casa que irá ser vendida (Atual, 10%)
config.podeVenderVIP = 0 -- Para que seja possível vender casas VIP, coloque aqui o valor -1
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------- [ VALES DAS CASAS ] -----------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--[[{
	Se por acaso não queira que seja possível efetuar a compra de uma residência usando vale casas, 
	basta deixar a tabela ValeCasa no Banco de dado com o número 0.
	Dessa forma será possível comprar essa casa somente com dinheiro.
	O mesmo serve para casas que podem ser compradas somente com Vale Casa
	Se os dois valores estiverem a cima de 0, irá poder comprar das duas formas.
}]]

config.valecasa = "valecasa" -- Item que vale a casa
config.nameValeCasa = "Vale Casa" -- Nome Bonitinho do item 

config.valeinterior = "valeinterior" -- Item que vale mudar o interior
config.nameValeInterior = "Vale Interior" -- Nome Bonitinho do item 

config.valeiptu = "valeiptu" -- Item que vale um IPTU da casa
config.nameValeIptu = "Vale IPTU" -- Nome bonitinho do item
config.qtdvaleiptu = 1 -- Quantidade desse item para pagar o IPTU

config.valegaragem = "valegaragem" -- Item que vale uma garagem
config.nameValeGaragem = "Vale Garagem" -- Nome bonitinho do item

config.valebau = "valebau" -- Item que vale uma melhoria de baú
config.nameValeBau = "Vale Baú" -- Nome bonitinho do item

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------- [ MARKERS ] -------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
config.DrawMarkerPorta = function(x,y,z) -- Aqui você configura o BLIP que fica no chão na porta de entrada e saída
    DrawMarker(21,x,y,z-0.8,0,0,0, 0.0,0,0,0.5,0.5,0.4, 0,255,255,100 ,0,0,0,1)
end

config.DrawMarkerBau = function(x,y,z) -- Aqui você configura o BLIP que fica no chão para abertura do baú
    DrawMarker(21,x,y,z-0.8,0,0,0, 0.0,0,0,0.5,0.5,0.4, 0,255,255,100 ,0,0,0,1)
end

config.DrawMarkerRoupas = function(x,y,z) -- Aqui você configura o BLIP que fica no chão para abertura do guarda roupas
    DrawMarker(21,x,y,z-0.8,0,0,0, 0.0,0,0,0.5,0.5,0.4, 0,255,255,100 ,0,0,0,1)
end

config.visivel = 2.5 -- Distancia de visibilidade dos blips
config.distanceuse = 1.5 -- Distancia para acionamento

textobau = "Aperte ~r~E~w~ P/ Baú ~g~" -- Texto que aparece no Blip do BAÚ
textosair = "Aperte ~r~E~w~ P/ SAIR ~g~ " -- Texto que aparece no Blip para SAIR da Casa
textoenter = "Aperte ~r~E~w~ P/ ENTRAR ~g~" -- Texto que aparece no Blip pra ENTRAR na Casa
textoroupas = "~r~E~w~  Roupas" -- Texto que aparece no Blip do Guarda Roupas

textoInterfonar = '~r~E~w~ INTERFORNAR' -- Texto que aparece na porta dos prédios para interfornar

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------- [ EVENTOS DE NOTIFY ] -----------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

config.nbuyhouse = "Dinheiro ou "..config.nameValeCasa.." insuficientes." -- Notify de negado compra por falta de item ou dinheiro
config.savegarage = 'Blip da garagem <b>salvo</b>' -- Notify de aviso de salvo blip de garagem
config.blipsalvo = 'Spawn do veiculo <b>salvo</b>' -- Notify de aviso de blip de spawn da garagem salvo
config.npodemudargarage = "Você não pode fazer isso" -- Notify de quando você deixar "false" mudar garagem
config.buyhouse = "Você comprou uma nova Residência" -- Notify de compra de casa
config.sucessointerior = 'Interior alterado com sucesso' -- Notify de alteração do interior
config.carspawn = 'Por favor, fique onde o carro irá spawnar!' -- Notify de ajuda para mudança da garagem
config.attgarage = 'A localização da garagem foi <b>atualizada</b>' -- Notify de sucesso da garagem
config.sucessobau = 'O tamanho do bau foi aumentado com <b>sucesso</b>'	 -- Notify de aumento do baú feito
config.maxmorador = "A residência atual atingiu o máximo de moradores." -- Notify de máximo de moradores atingido
config.negadobau = 'Item '..config.nameValeBau..' ou dinheiro insuficiente' -- Notify de negado aumento de baú
config.iptuatrasada = "A <b>Property Tax</b> da residência está atrasada." -- Notify IPTU atrasado
config.buygarage = 'Por favor, fique onde o blip da garagem será acessado!' -- Notify de ajuda do BLIP de garagem
config.negadogaragem = 'Item '..config.nameValeGaragem..' ou dinheiro insuficiente' -- Notify de negado troca de BLIP da garagem
config.negadointerior = 'Item '..config.nameValeInterior..' ou dinheiro insuficiente' -- Notify de troca de interior negado
config.iptusellhouse = "A <b>Property Tax</b> venceu por <b>3 dias</b> e a casa foi vendida." -- Notify de perda de casa por falta de pagamento

evento_aviso = "aviso" -- Evento de notify de sucesso/verde
evento_negado = "negado" -- Evento de notify de aviso/amarelo
evento_sucesso = "sucesso" -- Evento de notify de negado/vermelho

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------- [ EVENTOS DE BAÚ E GAURDA ROUPAS ] -----------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

function roupascustomopen(home) -- Se for client e deixe o config.roupascustom = true
	TriggerEvent('DS:roupas',home) -- Evento aqui 
end

function chestcustomopenclient(homename) -- Se for client e deixe o config.chestcustomclient = true
	exports['vrp_chest']:homechest(homename)
	-- TriggerEvent('ld-inv:Server:OpenInventory','chest:'..houseName,{isHouse=true,slots=20,weight=1000},houseName) -- Evento aqui
end

function chestcustomopenserver(source,homename,homename,pesoBau) -- Se for server  e deixe o config.chestcustomserver = true
	if pesoBau == nil then 
		pesoBau = 500 
	end
	print(homename,'homename')
	TriggerClientEvent("DS:homeChestInventory",homename) -- Se for triggerClientEvent
end

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------- [ CONFIGURAÇÃO DOS BAÚS ] -----------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

config.chest = {
	['Small'] = { -- Nome do Baú
		valor = 300, -- Valor do Baú para aumentar
		inItem = 10, -- Valor em item VIP
		size = 1000,  -- Tamanho em KG do baú
		['info'] = '[1000KG] Baú pequeno, mas útil' -- Informação do Baú
	},
	
	['Medium'] = { -- Nome do Baú
		valor = 3000, -- Valor do Baú para aumentar
		inItem = 10, -- Valor em item VIP
		size = 2000, -- Tamanho em KG do baú
		['info'] = '[2000KG] Para quem não tem muita coisa para guardar'  -- Informação do Baú
	},

	['Big'] = { -- Nome do Baú
		valor = 6000, -- Valor do Baú para aumentar
		inItem = 10, -- Valor em item VIP
		size = 3000, -- Tamanho em KG do baú
		['info'] = '[3000KG] Baú grande, e bem espaçoso!'  -- Informação do Baú
	},

	['XLbig'] = { -- Nome do Baú
		valor = 50000, -- Valor do Baú para aumentar
		inItem = 10, -- Valor em item VIP
		size = 5000, -- Tamanho em KG do baú
		['info'] = '[5000KG] Vai caber a familia toda aqui..'  -- Informação do Baú
	},
}

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------- [ CONFIGURAÇÃO DOS INTERIORES DAS CASAS ] -----------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

config.Interiores = { -- Tem total liberdade para adição de MAIS interiores

	['Hotel'] = { -- Nome do interior que aparecerá para a troca
		['price'] = 10, -- Preço do interior (Apenas para trocar os interiores)
		['vItem'] = 12, -- Preço em item (ValeInterior) para colocar este interior 
		['info'] = 'Um quarto de Hotel', -- Informação que aparece sobre o interior
		['location'] = { ['x'] = 324.31, ['y'] = -173.8, ['z'] = 70.37, ['h'] = 262.08 }, -- Localização da Porta de Entrada do interior
		['vault'] = { ['x'] = 319.75, ['y'] = -172.39, ['z'] = 70.37 }, -- Localização do Baú no interior
		['geladeira'] = { ['x'] = 321.98, ['y'] = -173.75, ['z'] = 70.37 },  -- Localização da Geladeira ou Armário do interior (Por enquanto sem função mas coloque) 
		['armario'] = { ['x'] = 317.89, ['y'] = -170.57, ['z'] = 70.37 } -- Localização do Guarda Roupas no interior (Mesmo se usar OUTRO script pra função de Guarda Roupas)
	},

	['AppartamentoM'] = { -- Nome do interior que aparecerá para a troca
		['price'] = 1500000, -- Preço do interior (Apenas para trocar os interiores)
		['vItem'] = 12, -- Preço em item (ValeInterior) para colocar este interior 
		['info'] = 'Luxo1', -- Informação que aparece sobre o interior
		['location'] = { ['x'] = 119.85, ['y'] = 514.3, ['z'] = 138.97, ['h'] = 3.563}, -- Localização da Porta de Entrada do interior
		['vault'] = { ['x'] = 106.01, ['y'] = 505.73, ['z'] = 138.37 }, -- Localização do Baú no interior
		['geladeira'] = { ['x'] = 110.76, ['y'] = 499.76, ['z'] = 138.37 }, -- Localização da Geladeira ou Armário do interior (Por enquanto sem função mas coloque) 
		['armario'] = { ['x'] = 131.82, ['y'] = 512.78, ['z'] = 137.77 } -- Localização do Guarda Roupas no interior (Mesmo se usar OUTRO script pra função de Guarda Roupas)
	},

	['AppartamentoG'] = { -- Nome do interior que aparecerá para a troca
		['price'] = 2500000, -- Preço do interior (Apenas para trocar os interiores)
		['vItem'] = 12, -- Preço em item (ValeInterior) para colocar este interior 
		['info'] = 'Luxo2',-- Informação que aparece sobre o interior
		['location'] = { ['x'] = 330.79, ['y'] = 454.04, ['z'] = 137.0, ['h'] = 89.98}, -- Localização da Porta de Entrada do interior 
		['vault'] = { ['x'] = 320.07, ['y'] = 460.22, ['z'] = 137.01 }, -- Localização do Baú no interior
		['geladeira'] = { ['x'] = 312.5, ['y'] = 464.82, ['z'] = 135.6 }, -- Localização da Geladeira ou Armário do interior (Por enquanto sem função mas coloque) 
		['armario'] = { ['x'] = 314.73, ['y'] = 473.17, ['z'] = 130.8 } -- Localização do Guarda Roupas no interior (Mesmo se usar OUTRO script pra função de Guarda Roupas)
	},

	['HouseP'] = { -- Nome do interior que aparecerá para a troca
		['price'] = 1000000, -- Preço do interior (Apenas para trocar os interiores)
		['vItem'] = 12, -- Preço em item (ValeInterior) para colocar este interior 
		['info'] = 'Casa Simples', -- Informação que aparece sobre o interior
		['location'] = { ['x'] = 321.02, ['y'] = -1856.04, ['z'] = 20.03, ['h'] = 196.22}, -- Localização da Porta de Entrada do interior
		['vault'] = { ['x'] = 328.92, ['y'] = -1861.63, ['z'] = 20.03 }, -- Localização do Baú no interior
		['geladeira'] = { ['x'] = 325.09, ['y'] = -1865.75, ['z'] = 20.03 }, -- Localização da Geladeira ou Armário do interior (Por enquanto sem função mas coloque) 
		['armario'] = { ['x'] = 324.66, ['y'] = -1853.91, ['z'] = 20.03 } -- Localização do Guarda Roupas no interior (Mesmo se usar OUTRO script pra função de Guarda Roupas)
	},

	['ApartamentoP'] = { -- Nome do interior que aparecerá para a troca
		['price'] = 850000, -- Preço do interior (Apenas para trocar os interiores)
		['vItem'] = 12, -- Preço em item (ValeInterior) para colocar este interior 
		['info'] = 'AP Simples', -- Informação que aparece sobre o interior
		['location'] = { ['x'] = 254.52, ['y'] = -1725.85, ['z'] = 20.64, ['h'] = 139.617}, -- Localização da Porta de Entrada do interior
		['vault'] = { ['x'] = 260.74, ['y'] = -1730.54, ['z'] = 22.64 }, -- Localização do Baú no interior
		['geladeira'] = { ['x'] = 262.5, ['y'] = -1731.79, ['z'] = 22.64 }, -- Localização da Geladeira ou Armário do interior (Por enquanto sem função mas coloque) 
		['armario'] = { ['x'] = 261.37, ['y'] = -1723.21, ['z'] = 22.64 } -- Localização do Guarda Roupas no interior (Mesmo se usar OUTRO script pra função de Guarda Roupas)
	},

	['HouseLuxuosa'] = { -- Nome do interior que aparecerá para a troca
		['price'] = 5000000,  -- Preço do interior (Apenas para trocar os interiores)
		['vItem'] = 12, -- Preço em item (ValeInterior) para colocar este interior 
		['info'] = 'Luxo Master', -- Informação que aparece sobre o interior
		['location'] = { ['x'] = -2994.74, ['y'] = 719.47, ['z'] = 14.56, ['h'] = 186.77}, -- Localização da Porta de Entrada do interior
		['vault'] = { ['x'] = -2990.78, ['y'] = 719.92, ['z'] = 6.95 }, -- Localização do Baú no interior
		['geladeira'] = { ['x'] = -2994.02, ['y'] = 723.99, ['z'] = 14.56 }, -- Localização da Geladeira ou Armário do interior (Por enquanto sem função mas coloque) 
		['armario'] = { ['x'] = -2986.0, ['y'] = 728.48, ['z'] = 10.75 } -- Localização do Guarda Roupas no interior (Mesmo se usar OUTRO script pra função de Guarda Roupas)
	},

	['ApartamentoM'] = { -- Nome do interior que aparecerá para a troca
		['price'] = 900000,  -- Preço do interior (Apenas para trocar os interiores)
		['vItem'] = 12, -- Preço em item (ValeInterior) para colocar este interior 
		['info'] = 'AP Médio', -- Informação que aparece sobre o interior
		['location'] = { ['x'] = 1386.66, ['y'] = -573.9, ['z'] = 67.84, ['h'] = 89.33}, -- Localização da Porta de Entrada do interior
		['vault'] = {['x'] = 1401.73, ['y'] = -572.86, ['z'] = 67.84 }, -- Localização do Baú no interior
		['geladeira'] = { ['x'] = 1396.22, ['y'] = -566.69, ['z'] = 67.84 }, -- Localização da Geladeira ou Armário do interior (Por enquanto sem função mas coloque) 
		['armario'] = { ['x'] = 1406.04, ['y'] = -569.73, ['z'] = 67.84 } -- Localização do Guarda Roupas no interior (Mesmo se usar OUTRO script pra função de Guarda Roupas)
	},

}

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------- [ CONFIGURAÇÃO DE QUANTOS APs VAI APARECER NA OPÇÃO DE CRIAR APARTAMENTOS ] -----------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

config.QTDaps = { -- Não é interessante colocar um numero muito alto!, pq vai sobrecarregar a DB.
	['min'] = 1,
	['max'] = 10
}

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------- [ CONFIGURAÇÃO DOS INTERIORES DOS APARTAMENTOS ] -----------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

config.Apartamento = {

	['Suites'] = { 
		['price'] = 500000, -- Preço do interior (Apenas para trocar os interiores)
		['info'] = 'Um quarto de Hotel', -- Informação que aparece sobre o interior
		['location'] = { ['x'] = 324.31, ['y'] = -173.8, ['z'] = 70.37, ['h'] = 262.08 }, -- Localização da Porta de Entrada do interior
		['vault'] = { ['x'] = 319.75, ['y'] = -172.39, ['z'] = 70.37 }, -- Localização do Baú no interior
		['size'] = 10000, -- Tamanho do baú do Apartamento (Apartamento não poderão AUMENTAR os Baús)
		['armario'] = { ['x'] = 317.89, ['y'] = -170.57, ['z'] = 70.37 } -- Localização do Guarda Roupas no interior (Mesmo se usar OUTRO script pra função de Guarda Roupas)
	},

	['Officer'] = { 
		['price'] = 2500000,
		['info'] = 'Luxo2',
		['location'] = { ['x'] = -787.08, ['y'] = 315.6, ['z'] = 187.92, ['h'] = 354.80 }, 
		['vault'] = { ['x'] = -794.99, ['y'] = 326.42, ['z'] = 187.32 }, 
		['size'] = 10000, 
		['armario'] = { ['x'] = -797.82, ['y'] = 328.03, ['z'] = 190.72 } 
	}, 

	['Executive1'] = { 
		['price'] = 2500000, 
		['info'] = 'Executivo',
		['location'] = { ['x'] = -781.92, ['y'] = 325.87, ['z'] = 176.81, ['h'] = 354.80 }, 
		['vault'] = { ['x'] = -783.04, ['y'] = 321.81, ['z'] = 176.81 }, 
		['size'] = 10000, 
		['armario'] = { ['x'] = -760.76, ['y'] = 325.32, ['z'] = 170.61 } 
	},

}

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------- [ CONFIGURAÇÃO DOS COMANDOS DISPONÍVEIS PARA USAR SEM O DYNAMIC ] -----------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

RegisterCommand("UpdateBlips",function() -- Comando para dar update nos blips após criar a casa
	TriggerEvent('DS:UpdateBlipsHomes')
end) 

RegisterCommand("moradia",function(source) -- Nome do comando para criar Casas/Apartamentos
	local adm, id = vSERVER.PermADM()
	if not adm then 
		TriggerEvent('Notify', evento_negado, 'Você não possui permissão para gerenciar residências' )
		return 
	end  -- COMENTAR PARA QUALQUER UM CRIAR E GERENCIAR CASAS
	local sourceP = GetPlayerServerId(PlayerId())
	if vSERVER.Ciente() then 
		Choices[sourceP] = {}
		Choices[sourceP]['creating'] = true
		Choices[sourceP]['user_id'] = id
		exports["dynamic"]:SubMenu("Gerenciar Casas: ","Criar Moradias","GerenciarHomes")
		exports["dynamic"]:AddButton("Casa","Criar Casa","InvokeHomeAndAp",'casinha',"GerenciarHomes",false)
		-- exports["dynamic"]:AddButton("Apartamento","Criar Apartamento","InvokeHomeAndAp",'apartamento',"GerenciarHomes",false)
		exports["dynamic"]:AddButton("Deletar","Deletar residências","DeleteChoices",'DeleteChoices',"GerenciarHomes",false)
	end 
end)

return config