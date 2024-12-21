--[[ Metadata ]]--
fx_version 'cerulean'
games { 'gta5' }

-- [[ Author ]] --
author 'Izumi S. <https://discordapp.com/users/871877975346405388>'
description 'Lananed Development | Pause Menu Changes'
discord 'https://discord.lanzaned.com'
github 'https://github.com/Lanzaned-Enterprises/'
docs 'https://docs.lanzaned.com/'

-- [[ Version ]] --
version '1.0.0'

-- [[ Files ]] --
ui_page 'html/index.html'

files {
    'html/index.html',
    'html/logo.png'
}

shared_scripts { 
    'shared/*.lua',
}

server_scripts { 
    'server/*.lua',
}

client_scripts { 
    'client/cl_main.lua'
}

-- [[ Tebex ]] --
lua54 'yes'

escrow_ignore {
    'shared/*.lua'
}