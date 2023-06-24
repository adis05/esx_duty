--─▄▄▀▀█▀▀▄▄       |
--▐▄▌─▀─▀─▐▄▌      |
--──█─▄▄▄─█──▄▄    |
--──▄█▄▄▄█▄─▐──▌   |
--▄█▀█████▐▌─▀─▐   |
--▀─▄██▀██▀█▀▄▄▀   | ─────────────────────────────────────|
-- Symbiote#3027 - Discord: https://discord.gg/Vk7eY8xYV2 |
--────────────────────────────────────────────────────────
lib.locale()

CityHall = {}

CityHall.Debug = false

CityHall.Type = 'ox_target'   -- ox_target/ox_textui

CityHall.TextUiKey = 38       -- Default E (38)

CityHall.Icon = 'briefcase'   -- Icon for interaction 

CityHall.MarkGPSOnSetJob = true   -- Cuando el jugador obtiene el trabajo seleccionado se marca en el mapa la posision donde se inicia el trabajo, PARA ESTO TIENE QUE CONFIGURAR CityHall.JobPosStart 

CityHall.UnemployedNameDB = 'unemployed'    -- Default ESX unemployed 

CityHall.ProgressBar = {
    enable = true,  
    time = 2000,

}


CityHall.Zones = {
    ['Disnaker'] = { -- Name Blip
        -- Position 
        Pos = vec4(-261.5454, -965.2300, 30.2241, 117.1752),--vec4(-550.8719, -190.2443, 36.7226, 178.2979),
        -- NPC Options
        NPC = true,                    -- Activar/desactivar NPC
        Hash = 'cs_debra',             -- Hash NPC 
        Scenario = false,              -- Scenario NPC
        -- Blip
        Blip = true,           -- Activar/desactivar blip
        Sprite = 407,          -- Blip sprite
        Display = 4,           -- Blip Display
        Scale = 0.6,           -- Blip size
        Colour = 0,            -- Blip colour
        ShortRange = true,     -- Blip Short Range
        -- Um-idcard
        -- Fivem post = https://forum.cfx.re/t/free-um-idcard-mugshot-card-maker/5067690 // GitHub = https://github.com/alp1x/um-idcard
        Um_idcard = true, 
        documents = {
            ['ktp'] = { --- Item name
                title = 'ID Card',
                description = 'Ambil KTP Baru',
            },
        }

    },
    --[[['Example'] = {           --- Blip Name
        Type = 'target',
        Pos = vec4(-543.8060, -203.1001, 37.2148, 212.3065),
        -- NPC Options
        NPC = true,
        Hash = 'cs_debra',
        Scenario = 'WORLD_CROW_STANDING', --"PROP_HUMAN_SEAT_COMPUTER", This animation makes the npc sit and type on a pc
        -- Blip
        Blip = true,
        Sprite = 407,
        Display = 4,
        Scale = 0.6,
        Colour = 0,
        ShortRange = true,
        -- Um-idcard
        -- Fivem post = https://forum.cfx.re/t/free-um-idcard-mugshot-card-maker/5067690 // GitHub = https://github.com/alp1x/um-idcard
        Um_idcard = true, -- Dependecia Fivem post = https://forum.cfx.re/t/free-um-idcard-mugshot-card-maker/5067690 // GitHub = https://github.com/alp1x/um-idcard
        documents = {
           ['id_card'] = {
                title = 'recover ID Card',
                description = 'Recover your lost document.',
            },
            ['driver_license'] = {
                title = 'driver_license',
                description = 'Recupera tu documento extraviados.',
            },
            ['weaponlicense'] = {
                title = 'weaponlicense',
                description = 'Recupera tu documento extraviados.',
            },
            ['lawyerpass'] = {
                title = 'lawyerpass',
                description = 'Recupera tu documento extraviados.',
            },
        }

    }]]
}

CityHall.JobPosStart = {
    ['busdriver'] = {                             -- Job DB name
        PosStart = vec3(297.48, -1204.27, 29.19), -- Job start position
    },

    ['garbage'] = {                               -- Job DB name
        PosStart = vec3(-322.25, -1545.85, 31.02), -- Job start position
    },

    ['lumberjack'] = {                             -- Job DB name
        PosStart = vec3(-552.99, 5348.98, 74.74), -- Job start position
    },

    ['miner'] = {                                       -- Job DB name
        PosStart = vec3(2707.14, 2777.46, 37.88), -- Job start position
    },

    ['slaughterer'] = {                             -- Job DB name
        PosStart = vec3(-62.54, 6242.23, 31.09), -- Job start position
    },

    ['farmer'] = {                               -- Job DB name
        PosStart = vec3(2748.0, 3473.0, 55.67), -- Job start position
    },

    --[[ ['recycling'] = {                               -- Job DB name
        PosStart = vec3(56.0931, 6471.5054, 31.4253), -- Job start position
    }, ]]
}



RegisterNetEvent('mono_citiyhall:Notification', function(msg, icon)
    lib.notify({
        title = locale('lang4'),
        description = msg,
        icon = icon,
    })
end)

Config = {}

Config.Jobs = {
    Police = {
        ClockedInJob = "police",
        ClockedOutJob = "offpolice",
        Locations = {
            vec3(441.87, -985.75, 30.94)
        },
        Webhook = 'https://discord.com/api/webhooks/1109302447203160105/j_yeK0FLrbQ6MIiu4ba9NcXY6eDa6tApT9soXXWZYK34iwkAIG8v4CDcpY0nSQYh2SvZ',
        Avatar = 'https://cdn.discordapp.com/attachments/1103381294911590531/1109909397771145327/LOGO_LCPD.png'
    },

    Ambulance = {
        ClockedInJob = "ambulance",
        ClockedOutJob = "offambulance",
        Locations = {
            vec3(1139.25, -1544.98, 35.38)
        },
        Webhook = 'https://discord.com/api/webhooks/1109302653084762184/RYQWic0t5FhYWJRnDAtanRYo8ij5gqE5kqiijeR6KVNy_GW5O5Q8ZbabsJmHoS0irRdZ',
        Avatar = 'https://cdn.discordapp.com/attachments/1103381294911590531/1106455274094596167/LMC.png'
    },

    Mechanic = {
        ClockedInJob = "mechanic",
        ClockedOutJob = "offmechanic",
        Locations = {
            vec3(124.76, -3007.84, 7.04)
        },
        Webhook = 'https://discord.com/api/webhooks/1109303010867294289/hctPTxwUu4wZQHoRL-ZjfPfINEZ4cBq9B50eX2Jh4AbDVc9XL7jaCRcZjWHgmP6vqw-U',
        Avatar = 'https://cdn.discordapp.com/attachments/1103381294911590531/1106146311843098624/MAIN_LOGO.jpg'
    },

    Pedagang = {
        ClockedInJob = "pedagang",
        ClockedOutJob = "offpedagang",
        Locations = {
            vec3(-401.62, 6079.91, 31.51)
        },
        Webhook = 'https://discord.com/api/webhooks/1109303181642575912/LBlGyPgQF-65Ehww5eM7eMJeO4O9c5FESxHdxTBd49ytP1_HkndkmS8idwbqpcULdkVL',
        Avatar = 'https://cdn.discordapp.com/attachments/1103381294911590531/1106141918729097226/LASTORANT_LOGO.png'
    },

    Taxi = {
        ClockedInJob = "taxi",
        ClockedOutJob = "offtaxi",
        Locations = {
            vec3(904.81, -162.63, 74.22)
        },
        Webhook = 'https://discord.com/api/webhooks/1109303338496958615/CSDjmwVNt467MD5NkKVb_aSByG_7rPBklMNtmT8k1HPzOMvUZHn2EQmTky0ysYxXeFb8',
        Avatar = 'https://cdn.discordapp.com/attachments/1103381294911590531/1108704103841931326/LASTRANS_2.png'
    },

    Pemerintah = {
        ClockedInJob = "pemerintah",
        ClockedOutJob = "offpemerintah",
        Locations = {
            vec3(716.71, 2526.96, 73.51)
        },
        Webhook = 'https://discord.com/api/webhooks/1109303338496958615/CSDjmwVNt467MD5NkKVb_aSByG_7rPBklMNtmT8k1HPzOMvUZHn2EQmTky0ysYxXeFb8',
        Avatar = 'URL_AVATAR_POLICE'
    },
    
}
