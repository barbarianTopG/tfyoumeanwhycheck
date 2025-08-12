local httpGet = game.HttpGet
local response = game:HttpGet("https://sirius.menu/rayfield")
local loadFunc = loadstring(response)
local loadedLib = ({loadFunc()})
local createWindowFunc = loadedLib[1].CreateWindow

local window = loadedLib[1]:CreateWindow({
    Name = "Merge Brainrots"
    LoadingTitle = "brainrot",
    KeySystem = false,
    DisableBuildWarnings = false,
    DisableRayfieldPrompts = false,
    Discord = {
        Enabled = false,
    },
    ConfigurationSaving = {
        Enabled = false,
    },
    ToggleUIKeybind = "K",
    LoadingSubtitle = "by frostware team",
    Theme = "Default",
    Icon = 0
})

local createTabFunc = window.CreateTab
local infMoneyTab = window:CreateTab("Inf Money")

local insertCashInput = infMoneyTab:CreateInput({
    RemoveTextAfterFocusLost = true,
    CurrentValue = "",
    PlaceholderText = "Example: 69420",
    Callback = function(input)
        local cashAmount = tonumber(input)
        if cashAmount then
            local remote = game:GetService("ReplicatedStorage").Remotes.GiveCashEvent
            remote:FireServer(cashAmount)
        end
    end,
    Name = "Insert how much cash you want"
})

local insertGemsInput = infMoneyTab:CreateInput({
    RemoveTextAfterFocusLost = true,
    CurrentValue = "",
    PlaceholderText = "Example: 21",
    Callback = function(input)
        local gemAmount = tonumber(input)
        if gemAmount then
            local remote = game:GetService("ReplicatedStorage").Remotes.GemEvent
            remote:FireServer(gemAmount)
        end
    end,
    Name = "Insert how many gems you want"
})
