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
                            label = '[' .. i .. '] ' .. 'Clock in/out!',
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
                                            return ESX.ShowNotification("Couldn't clock you out...")
                                        end

                                        local notificationText
                                        if totalTime ~= nil then
                                            notificationText = string.format("You are clocked off!\nTotal Menit: %d", totalTime)
                                        else
                                            notificationText = "You are clocked off!"
                                        end

                                        return ESX.ShowNotification(notificationText)
                                    end, data.name, false)
                                elseif jobName == jobTable.ClockedOutJob then
                                    ESX.TriggerServerCallback("joblock:ToggleClock", function(success)
                                        if not success then return ESX.ShowNotification("Couldn't clock you in...") end

                                        return ESX.ShowNotification("You are clocked in!")
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
