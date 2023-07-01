local cutscene_menu = RageUI.CreateMenu("cutscenes", "cutscene Menu")
cutscene_menu:SetStyleSize(200)
cutscene_menu:DisplayPageCounter(true)
local open = false
local selected_cutscene = nil
local selected_strength = 1

cutscene_menu.Closed = function()
    open = false
end

local path_to_cutscenes = "config.json"

local fileJson = LoadResourceFile(GetCurrentResourceName(), path_to_cutscenes)
if fileJson then
    cutscenes_list = json.decode(fileJson)
end

RegisterCommand("cutscenes", function()
    OpencutsceneMenu()
end)

CreateThread(function()
    -- sort the list by name
    table.sort(cutscenes_list, function(a, b)
        return a < b
    end)
end)

local function ShowNotification(text)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(text)
    DrawNotification(false, false)
end

function OpencutsceneMenu()
    if open then
        open = false
        RageUI.Visible(cutscene_menu, false)
        return
    else
        open = true
        selected_cutscene = nil
        RageUI.Visible(cutscene_menu, true)
        CreateThread(function()
            while open do
                RageUI.IsVisible(cutscene_menu, function()
                    -- add a button to select a cutscene
                    for k, v in pairs(cutscenes_list) do
                        RageUI.Button(v, nil, { RightLabel = ">" }, true, {
                            onSelected = function(Index, Item)
                                -- play the cutscene (if it's already playing, stop it)
                                Citizen.CreateThread(function()
                                    if IsCutsceneActive() then
                                        StopCutsceneImmediately()
                                    else
                                        RequestCutscene(v, 8)
                                        local timeout = GetGameTimer() + 10000
                                        while not HasCutsceneLoaded() and GetGameTimer() < timeout do
                                            Wait(0)
                                        end
                                        if HasCutsceneLoaded() then
                                            StartCutscene(v)
                                            CreateThread(function()
                                                SetTimeout(100, function()
                                                    if IsCutsceneActive() then
                                                        local coords = GetWorldCoordFromScreenCoord(0.5, 0.5)
                                                        NewLoadSceneStartSphere(coords.x, coords.y, coords.z, 1000, 0)
                                                    end
                                                end)
                                            end)
                                        else
                                            ShowNotification("Cutscene failed to load")
                                        end
                                    end
                                end)
                            end
                        })
                    end
                end)
                Wait(0)
            end
        end)
    end
end