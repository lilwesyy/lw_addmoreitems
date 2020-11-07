fx_version 'cerulean'
game 'gta5'
author 'lilwesyy#4670'
description 'ESX Add More Items'
version '1.0.0'

client_script{
    '@es_extended/locale.lua',
	'client/main.lua'
}

server_script{
	'@mysql-async/lib/MySQL.lua',
	'@es_extended/locale.lua',	
	'server/main.lua'
}

dependency{
    "es_extended",
    "mythic_notify",
    "rprogress"
} 
