local httpGet = game.HttpGet
local response = game:HttpGet("https://sirius.menu/rayfield")
local loadedLib = ({loadstring(response)()})

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")
local Workspace = game:GetService("Workspace")
local SoundService = game:GetService("SoundService")

local localPlayer = Players.LocalPlayer
local character = localPlayer.Character

if not character then return end

local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
local humanoid = character:WaitForChild("Humanoid")

local globalClickSound = Instance.new("Sound")
globalClickSound.SoundId = "rbxassetid://6042053626"
globalClickSound.Volume = 1
globalClickSound.Name = "GlobalClickSound"
globalClickSound.Parent = SoundService
_G.ClickSound = globalClickSound

local plotESPFolder = Instance.new("Folder", CoreGui)
plotESPFolder.Name = "PlotESP"

local playerESPFolder = Instance.new("Folder", CoreGui)
playerESPFolder.Name = "PlayerESP"

localPlayer.CharacterAdded:Connect(function(char)
    local hrp = char:WaitForChild("HumanoidRootPart")
    local hum = char:WaitForChild("Humanoid")
end)

local window = loadedLib[1]:CreateWindow({
    LoadingTitle = "what the sigma🔥💀",
    LoadingSubtitle = "Tungtungtungtung sahur!",
    Name = "Steal A Brainrot",
    ConfigurationSaving = {
        Enabled = false
    }
})

local mainTab = window:CreateTab("Main", 4483362458)

local plotToggle = mainTab:CreateToggle({
    CurrentValue = false,
    Name = "Plot ESP",
    Callback = function(enabled)
        plotESPFolder:ClearAllChildren()
        if not enabled then return end

        for _, plot in pairs(Workspace.Plots:GetChildren()) do
            local purchases = plot:FindFirstChild("Purchases")
            if purchases then
                local plotBlock = purchases:FindFirstChild("PlotBlock")
                if plotBlock then
                    local mainPart = plotBlock:FindFirstChild("Main")
                    if mainPart then
                        local billboard = mainPart:FindFirstChild("BillboardGui")
                        if billboard then
                            local lockStudio = billboard:FindFirstChild("LockStudio")
                            local remainingTime = billboard:FindFirstChild("RemainingTime")

                            local espGui = Instance.new("BillboardGui", plotESPFolder)
                            espGui.Adornee = mainPart
                            espGui.AlwaysOnTop = true
                            espGui.Size = UDim2.new(0, 150, 0, 25)
                            espGui.StudsOffset = Vector3.new(0, 30, 0)

                            local textLabel = Instance.new("TextLabel", espGui)
                            textLabel.Size = UDim2.new(1, 0, 1, 0)
                            textLabel.BackgroundTransparency = 1
                            textLabel.TextScaled = true
                            textLabel.Font = Enum.Font.SourceSansBold

                            RunService.Heartbeat:Connect(function()
                                if lockStudio and lockStudio.Visible then
                                    textLabel.Text = "UNLOCKED!"
                                    textLabel.TextColor3 = Color3.new(1, 0, 0)
                                end
                            end)
                        end
                    end
                end
            end
        end
    end
})

local playerToggle = mainTab:CreateToggle({
    CurrentValue = false,
    Name = "Player ESP",
    Callback = function(enabled)
        playerESPFolder:ClearAllChildren()
        if not enabled then return end

        for _, player in pairs(Players:GetPlayers()) do
            local char = player.Character
            if char then
                local hrp = char:FindFirstChild("HumanoidRootPart")
                if hrp then
                    local highlight = Instance.new("Highlight", playerESPFolder)
                    highlight.Adornee = char
                    highlight.FillTransparency = 1
                    highlight.OutlineTransparency = 0
                    highlight.OutlineColor = Color3.new(1,1,1)

                    local billboard = Instance.new("BillboardGui", playerESPFolder)
                    billboard.Adornee = hrp
                    billboard.Size = UDim2.new(0, 100, 0, 20)
                    billboard.StudsOffset = Vector3.new(0, 3, 0)
                    billboard.AlwaysOnTop = true

                    local label = Instance.new("TextLabel", billboard)
                    label.Size = UDim2.new(1, 0, 1, 0)
                    label.BackgroundTransparency = 1
                    label.Text = player.DisplayName
                    label.TextScaled = true
                    label.Font = Enum.Font.SourceSansBold
                    label.TextColor3 = Color3.new(1,1,1)
                    label.TextStrokeTransparency = 0.5
                end
            end
        end
    end
})

local hipHeightToggle = mainTab:CreateToggle({
    CurrentValue = false,
    Name = "HipHeight 15",
    Callback = function(enabled)
        if humanoid then
            humanoid.HipHeight = enabled and 15 or 0
        end
    end
})

local autoLockToggle = mainTab:CreateToggle({
    CurrentValue = false,
    Name = "Auto Lock Plot",
    Callback = function(enabled)
        -- didnt run, expr id 1
    end
})

mainTab:CreateButton({
    Name = "Use Our Executor!",
    Callback = function()
        local s = syn and syn.request or http_request or http and http.request or request
        if s then
            s({Url = "getfrosts.xyz"})
        end
    end
})

mainTab:CreateButton({
    Name = "Join Our Discord Server",
    Callback = function()
        local s = syn and syn.request or http_request or http and http.request or request
        if s then
            s({Url = "discord.gg/getfrosts"})
        end
    end
})

RunService.Heartbeat:Connect(function()
    for _, plot in pairs(Workspace.Plots:GetChildren()) do
        local plotSign = plot:FindFirstChild("PlotSign")
        if plotSign then
            local surfaceGui = plotSign:FindFirstChild("SurfaceGui")
            if surfaceGui then
                local frame = surfaceGui:FindFirstChild("Frame")
                if frame then
                    local textLabel = frame:FindFirstChild("TextLabel")
                    if textLabel then
                        local ownerNameLower = localPlayer.Name:lower()
                        local textLower = textLabel.Text:lower()

                        if textLower:find(ownerNameLower) then
                            local purchases = plot:FindFirstChild("Purchases")
                            if purchases then
                                local plotBlock = purchases:FindFirstChild("PlotBlock")
                                if plotBlock then
                                    local mainPart = plotBlock:FindFirstChild("Main")
                                    if mainPart then
                                        local billboard = mainPart:FindFirstChild("BillboardGui")
                                        if billboard then
                                            local lockStudio = billboard:FindFirstChild("LockStudio")
                                            local remainingTime = billboard:FindFirstChild("RemainingTime")
                                            if lockStudio and lockStudio.Visible then
                                                local hitbox = plotBlock:FindFirstChild("Hitbox")
                                                local deliveryHitbox = plot:FindFirstChild("DeliveryHitbox")
                                                if hitbox and humanoidRootPart then
                                                    local offset = Vector3.new(0, 5, 0)
                                                    humanoidRootPart.CFrame = hitbox.CFrame + offset
                                                    task.wait(1.75)
                                                    humanoidRootPart.CFrame = hitbox.CFrame + offset
                                                    task.wait(1.75)
                                                    humanoidRootPart.CFrame = hitbox.CFrame + offset
                                                    task.wait(1.75)
                                                    humanoidRootPart.CFrame = hitbox.CFrame + offset
                                                    task.wait(1.75)
                                                    humanoidRootPart.CFrame = hitbox.CFrame + offset
                                                    task.wait(1.75)
                                                    humanoidRootPart.CFrame = humanoidRootPart.CFrame
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end)
