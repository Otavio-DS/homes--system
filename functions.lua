local Tunnel = module("vrp","lib/Tunnel")
local Proxy  = module("vrp","lib/Proxy")
local Tools  = module("vrp","lib/Tools")
-- local sanitizes = module("cfg/sanitizes") -- Varia de base para base
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- USE PARA CONFIGURAR DE ACORDO COM SUA BASE
-----------------------------------------------------------------------------------------------------------------------------------------

puxarID = function(source)
    return vRP.getUserId(source)
end

getUserFullName = function(user_id) 
    local identity = vRP.getUserIdentity(user_id)
    local name = identity.name.." "..identity.firstname
    return name
end

getUserFirstName = function(user_id)
    local identity = vRP.getUserIdentity(user_id)
    local firstname = identity.firstname
    return firstname
end

getUserName = function(user_id)
    local identity = vRP.getUserIdentity(user_id)
    local namec = identity.name
    return namec
end

perguntar = function(id,text,time)
    return vRP.request(id,text,time)
end

expulsar = function(source,motivodokick)
    return vRP.kick(source,motivodokick) 
end

pegarIdentidade = function(user_id)
    return vRP.getUserIdentity(user_id)
end

temPermissao = function(user_id, permission)
    return vRP.hasPermission(user_id, permission)
end

promptdepergunta = function(title,default_text,text)
    return vRP.prompt(title,default_text,text)
end

pegarPagamento = function(user_id,amount)
    return vRP.tryPayment(user_id,amount)
end

pagarComtudo = function(user_id,amount)
    return vRP.tryFullPayment(user_id,amount)
end

darDinheiroNoBanco = function(user_id,amount)
    return vRP.giveBankMoney(user_id,amount)
end

verificarDinheiroEmConta = function(user_id)
    return vRP.getBankMoney(user_id)
end

pegarSource = function()
    return vRP.getUserSource()
end

pegarServerData = function(key, cbr)
    return vRP.getSData(key, cbr)
end
 
setarDadosNoServerData = function(key, value)
    return vRP.setSData(key, value)
end

darItemNoInventario = function(user_id,idname,amount,notify,slot)
    return vRP.giveInventoryItem(user_id,idname,amount,notify,slot)
end

pegarItemDoInventario = function(user_id,idname,amount,notify,slot)
    return vRP.tryGetInventoryItem(user_id,idname,amount,notify,slot)
end

verificarPesoInventario = function(user_id)
    return vRP.getInventoryWeight(user_id)
end

pegarDoBau = function(user_id,chestData,itemName,amount,slot,type1)
    return vRP.tryChestItem(user_id,chestData,itemName,amount,slot,type1)
end

colocarNoBau = function(user_id,chestData,itemName,amount,chestWeight,slot)
    return vRP.storeChestItem(user_id,chestData,itemName,amount,chestWeight,slot)
end

verificarInventario = function(user_id)
    return vRP.getInventory(user_id)
end

verificarPesoMaximoDoInv = function(user_id)
    return vRP.getInventoryMaxWeight(user_id)
end

verificarPesoMaximoBau = function(user_id)
    return vRP.computeChestWeight(user_id)
end

verificarArmas = function(user_id)
    return vRP.getWeaponsId(user_id)
end

vRP._prepare("homes/getGarages","SELECT * FROM elite_homes_garage WHERE user_id = @user_id")
------------------------------------------------------------------------------------------------------------------------------------------------------
---------[ PREPARES ]---------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
vRP._prepare("homes/get_homeuser","SELECT * FROM elite_homes_permissions WHERE user_id = @user_id AND home = @home")
vRP._prepare("homes/get_homeuserid","SELECT * FROM elite_homes_permissions WHERE user_id = @user_id")
vRP._prepare("homes/get_homeuserowner","SELECT * FROM elite_homes_permissions WHERE user_id = @user_id AND home = @home AND owner = 1")
vRP._prepare("homes/get_homeuseridowner","SELECT * FROM elite_homes_permissions WHERE home = @home AND owner = 1")
vRP._prepare("homes/get_homeuseridco_owner","SELECT * FROM elite_homes_permissions WHERE user_id = @user_id AND home = @home AND owner = 0")
vRP._prepare("homes/get_homepermissions","SELECT * FROM elite_homes_permissions WHERE home = @home")
vRP._prepare("homes/add_permissions","INSERT IGNORE INTO elite_homes_permissions(home,user_id) VALUES(@home,@user_id)")
vRP._prepare("homes/buy_permissions","INSERT IGNORE INTO elite_homes_permissions(home,user_id,owner,tax,garage) VALUES(@home,@user_id,1,@tax,1)")
vRP._prepare("homes/count_homepermissions","SELECT COUNT(*) as qtd FROM elite_homes_permissions WHERE home = @home")
vRP._prepare("homes/upd_permissionsGarage","UPDATE elite_homes_garage SET co_owner = user_id WHERE home = @home")
vRP._prepare("homes/rem_permissions","DELETE FROM elite_homes_permissions WHERE home = @home AND user_id = @user_id")
vRP._prepare("homes/rem_allpermissions","DELETE FROM elite_homes_permissions WHERE home = @home")
vRP._prepare("homes/chest_Size","SELECT bau FROM elite_homes WHERE home = @home ")
vRP._prepare("homes/chest_UPDATE","UPDATE elite_homes SET bau = @bau WHERE home = @home")
vRP._prepare("homes/selling","DELETE FROM elite_homes_permissions WHERE home = @home")
vRP._prepare("deleteHouse","DELETE FROM elite_homes WHERE home = @home")
vRP._prepare("homes/userPermissions","SELECT valor FROM elite_homes WHERE home = @home")
vRP._prepare("homes/create_house","INSERT INTO elite_homes(home,interior,bau,valor,valeCasa,qtd_chaves,transferivel,disponivel,x,y,z) VALUES(@home,@interior,@bau,@valor,@valeCasa,@qtd_chaves,@transferivel,@disponivel,@x,@y,@z)")
------------ Garagem da casa -------------
vRP._prepare('homes/GarageCreate','INSERT INTO elite_homes_garage(user_id,home,garagem,spawn) VALUES(@user_id,@home,@garagem,@spawn) ')
vRP._prepare('homes/GarageSelect','SELECT garagem,spawn FROM elite_homes_garage WHERE user_id = @user_id AND home = @home ') 
vRP._prepare('homes/GarageUpdate','UPDATE elite_homes_garage SET garagem = @garagem,spawn = @spawn WHERE user_id = @user_id AND home = @home ')
vRP._prepare('homes/Garage','SELECT * FROM elite_homes_garage')
-------------------------------------------------
--Selecionar o interior
vRP._prepare('homes/UserHouserInterior','SELECT interior FROM elite_homes_permissions WHERE user_id = @user_id AND home = @home ')
vRP._prepare('homes/HouseCustomData','SELECT * FROM elite_homes WHERE home = @home ')
vRP._prepare('homes/GetAllHouse','SELECT * FROM elite_homes')
vRP._prepare('homes/ChangeInterior','UPDATE elite_homes_permissions SET interior = @interior WHERE user_id = @user_id AND home = @home')


-------------------------------------------------
vRP._prepare('apartamento/SELECTAll','SELECT * FROM elite_apartment') --UNCHECK
vRP._prepare('apartamento/INSERT','INSERT INTO elite_apartment(Apartamentos,Donos,Moradores,price,bau,x,y,z) VALUES(@Apartamentos,@Donos,@Moradores,@price,@bau,@x,@y,@z)') --UNCHECK
vRP._prepare('apartamento/SELECT_APLocal','SELECT Apartamentos,x,y,z FROM elite_apartment') -- CHECK 

vRP._prepare('apartamento/HouseCustomDataApartamento','SELECT * FROM elite_apartment WHERE Apartamentos = @Apartamentos ')

vRP._prepare('apartamento/price','SELECT price FROM elite_apartment WHERE Apartamentos = @Apartamentos') -- CHECK
vRP._prepare('apartamento/SELECT_QTDOwner','SELECT Donos FROM elite_apartment WHERE Apartamentos = @Apartamentos') -- CHECK
vRP._prepare("apartamento/UPDATE_QTDOwner","UPDATE elite_apartment SET Donos = Donos + 1 WHERE Apartamentos = @Apartamentos") -- CHECK

vRP._prepare('apartamento/SELECTMorador','SELECT Moradores FROM elite_apartment WHERE Apartamentos = @Apartamentos') --CHECK
vRP._prepare('apartamento/newOwner','UPDATE elite_apartment SET Moradores = @Moradores WHERE Apartamentos = @Apartamentos') --CHECK

vRP._prepare('apartamento/LOCATION','SELECT x,y,z FROM elite_apartment WHERE Apartamentos = @Apartamentos') -- CHECK

vRP._prepare('inHome/out-inside','UPDATE vrp_user_identities SET inHome = @inHome WHERE user_id = @user_id') -- WORKING
vRP._prepare('inHome/inside','SELECT inHome FROM vrp_user_identities WHERE user_id = @user_id') -- WORKING
vRP._prepare('inHome/bugandoHomes','UPDATE vrp_user_identities SET BugHomeIN = 1 WHERE user_id = @user_id') -- WORKING