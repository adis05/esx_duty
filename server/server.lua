-- Mendefinisikan fungsi SendDiscordWebhook
local function SendDiscordWebhook(webhook, message)
    if webhook == nil then return end

    PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode(message), { ['Content-Type'] = 'application/json' })
end

-- Menggunakan fungsi SendDiscordWebhook di dalam callback server
ESX.RegisterServerCallback('joblock:ToggleClock', function(src, cb, jobName, clockIn)
    local jobTable = Config.Jobs[jobName]
    if jobTable == nil then return cb(false) end

    local xPlayer = ESX.GetPlayerFromId(src)
    local xPlayerJob = xPlayer.getJob()

    local job = jobTable.ClockedOutJob

    if clockIn then
        job = jobTable.ClockedInJob
    end

    if ESX.DoesJobExist(job, xPlayerJob.grade) then
        xPlayer.setJob(job, xPlayerJob.grade)

        local jobDisplayName = jobTable.JobDisplayName or jobName
        local clockStatus = clockIn and "On-Duty" or "Off-Duty"
        local playerName = GetPlayerName(src)

        -- Mendapatkan waktu WIB saat ini
        local currentTime = os.date("!%H:%M:%S", os.time()+25200) -- Menambahkan 7 jam (25200 detik) ke waktu UTC

        local currentDate = os.date("%d/%m/%Y")
        
        -- Menghitung total menit dari "On-Duty" ke "Off-Duty"
        local totalTime = 0
        if clockIn then
            xPlayer.set("jobclock", os.time()) -- Simpan waktu saat "On-Duty"
        else
            local onDutyTime = xPlayer.get("jobclock") -- Dapatkan waktu saat "On-Duty"
            if onDutyTime then
                totalTime = math.floor((os.time() - onDutyTime) / 60) -- Hitung total menit
            end
        end
        
        local statusColor = clockIn and 65280 or 16711680 -- Green or Red color
        
        -- Mengirim webhook dengan avatar
        local webhookMessage = {
            embeds = {
                {
                    title = string.format("%s - Job Status", GetCurrentResourceName()),
                    description = string.format("**Nama**: **%s**\n**Status**: %s\n**Job**: %s\n**Tgl**: %s\n**Jam**: %s WIB\n**Total Menit Duty**: %d", xPlayer.name, clockStatus, jobDisplayName, currentDate, currentTime, totalTime),
                    color = statusColor,
                    thumbnail = {
                        url = jobTable.Avatar
                    }
                }
            }
        }
        
        SendDiscordWebhook(jobTable.Webhook, webhookMessage)

        cb(true)
    else
        cb(false)
    end
end)
