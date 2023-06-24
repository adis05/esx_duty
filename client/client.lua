CreateThread(function()
    for i, j in pairs(Config.Jobs) do
        for _, v in pairs(j.Locations) do
            if GetResourceState("ox_target") ~= "missing" then
                exports.ox_target:addSphereZone({
                    coords = v,
                    radius = 1,
                    debug = false,
                    options = {
                        {
                            name = i,
                            icon = 'fa-solid fa-business-time',
                            label = '[' .. i .. '] ' .. 'Duty On/Off!',
                            canInteract = function(entity, distance, coords, name)
                                local playerData = ESX.GetPlayerData()
                                local jobTable = Config.Jobs[name]
                                local jobName = playerData.job.name

                                if distance < 2 and (jobName == jobTable.ClockedInJob or jobName == jobTable.ClockedOutJob) then
                                    return true
                                else
                                    return false
                                end
                            end,
                            onSelect = function (data)
                                local playerData = ESX.GetPlayerData()
                                local jobTable = Config.Jobs[data.name]
                                local jobName = playerData.job.name

                                if jobName == jobTable.ClockedInJob then
                                    ESX.TriggerServerCallback("joblock:ToggleClock", function(success, totalTime)
                                        if not success then
                                            return ESX.ShowNotification("Couldn't Duty you Off...")
                                        end

                                        local notificationText
                                        if totalTime ~= nil then
                                            notificationText = string.format("You are Duty off!\nTotal Menit: %d", totalTime)
                                        else
                                            notificationText = "You are Off Duty!"
                                        end

                                        return ESX.ShowNotification(notificationText)
                                    end, data.name, false)
                                elseif jobName == jobTable.ClockedOutJob then
                                    ESX.TriggerServerCallback("joblock:ToggleClock", function(success)
                                        if not success then return ESX.ShowNotification("Couldn't Duty you On...") end

                                        return ESX.ShowNotification("You are On Duty!")
                                    end, data.name, true)
                                end
                            end
                        }
                    }
                })
            end
        end
    end
end)
