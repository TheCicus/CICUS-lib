fx_version('cerulean')
games({ 'gta5' })

author 'CICUS DEVELOPMENT'

description 'CICUS_lib. Libreria Fivem'

version '1.0'

shared_script('config/*.lua');

client_scripts({
    'modules/main.lua',
    'modules/key/client.lua',
    'lib.lua',
});

