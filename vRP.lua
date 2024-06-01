Tunnel = module("vrp","lib/Tunnel")
Proxy = module("vrp","lib/Proxy")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
server = IsDuplicityVersion()

if server then
	vRP = Proxy.getInterface("vRP")
	vRPclient = Tunnel.getInterface("vRP")
	
	src = {}
	Tunnel.bindInterface("elite_homes",src)
	vCLIENT = Tunnel.getInterface("elite_homes")
	-- srv = Proxy.getInterface('ws-inventario')
	
	function src.openChestcustom(homename)
		local source = source
		local user_id = puxarID(source)
		if user_id then
			local pesoBau = nil
			local chestPeso = vRP.query('homes/HouseCustomData',{home = homename})
			local size = vRP.query('homes/chest_Size',{home = homename})
			if size[1].chestSize ~= 0 then 
				pesoBau = size[1].bau
			else
				pesoBau = size[1].bau 
			end 
			chestcustomopenserver(source,homename,homename,pesoBau)
		end
	end

else
	vRP = Proxy.getInterface("vRP")
	src = {}
	Tunnel.bindInterface("elite_homes",src)
	vSERVER = Tunnel.getInterface("elite_homes")
end