fx_version 'cerulean'
game { 'gta5' }

-- Author info
description "A FiveM 3D Map plugin"
author "Akkariin"
version "1.0.0"
url "https://www.zerodream.net/"

ui_page 'html/index.html'

shared_scripts {
	'config.lua'
}

client_scripts {
	'client.lua'
}

server_scripts {
	'server.lua'
}

files {
	'html/obj/*.jpg',
	'html/*.js',
	'html/index.html',
	'html/obj/model.obj',
	'html/obj/model.mtl'
}
