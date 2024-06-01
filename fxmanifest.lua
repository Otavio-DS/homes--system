fx_version "bodacious"
game "gta5" 

author 'Otávio DS'
description 'Elite Homes'
version 'v0.0.5'

lua54 'yes'

escrow_ignore {
	"vRP.lua",
	'config.lua',
	'exports.lua',
}

ui_page_preload "yes"

ui_page "nui/index.html"


client_scripts { 
	'@vrp/lib/utils.lua',
	'vRP.lua',
	'main/client.lua',
	'config.lua'
}

server_scripts {
	'@vrp/lib/utils.lua',
	'vRP.lua',
	'functions.lua',
	'main/server.lua',
	'config.lua'
}

files {
	"nui/*"
}