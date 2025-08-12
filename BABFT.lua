local GetService = game.GetService
local RunService = GetService(game, "RunService")
local Players = GetService(game, "Players")
local PathfindingService = GetService(game, "PathfindingService")
local Workspace = GetService(game, "Workspace")

local LocalPlayer = Players.LocalPlayer
local Vector3New = Vector3.new

local startPos = Vector3New(-54.48, 165, -192.64)
local chestPos = Vector3New(-51.5567, 3, 9287.4609)
local targetPos = Vector3New(-58.1185, -360.3995, 9486.8867)

local httpGetResult = game:HttpGet("https://raw.githubusercontent.com/Nebula-Softworks/Luna-Interface-Suite/refs/heads/main/source.lua", true)
local loadedFunc = loadstring(httpGetResult)
local lib = loadedFunc()
local window = lib[1]:CreateWindow({
    LoadingTitle = "Build A Boat For Treasure",
    Subtitle = ".gg/getfrost",
    LogoID = sailing,
    LoadingEnabled = true,
    LoadingSubtitle = "Loading..",
    ConfigSettings = {
        ConfigFolder = "FWONTOP"
    },
    Name = "Build A Boat For Treasure Script"
})

local farmTab = window:CreateTab({
    ShowTitle = true,
    ImageSource = "Material",
    Icon = "view_in_ar",
    Name = "Farm"
})

farmTab:CreateToggle({
    CurrentValue = false,
    Name = "Auto Farm Gold",
    Description = "Glide To The Chest Looply.",
    Callback = function(enabled)
        if not enabled then return end

        local function glideToChest()
            local char = LocalPlayer.Character
            if not char then return end

            local hrp = char:WaitForChild("HumanoidRootPart")

            local bodyGyro = Instance.new("BodyGyro")
            bodyGyro.MaxTorque = Vector3New(1e9, 1e9, 1e9)
            bodyGyro.P = 1e5
            bodyGyro.CFrame = CFrame.Angles(2, 0, 0)
            bodyGyro.Parent = hrp

            local bodyPos = Instance.new("BodyPosition")
            bodyPos.MaxForce = Vector3New(1e9, 1e9, 1e9)
            bodyPos.P = 1e5
            bodyPos.D = 1000
            bodyPos.Position = hrp.Position
            bodyPos.Parent = hrp

            local conn
            conn = RunService.Stepped:Connect(function()
                for _, part in ipairs(char:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
                if not enabled then
                    conn:Disconnect()
                end
            end)

            hrp.CFrame = CFrame.new(startPos)
            bodyPos.Position = chestPos
            task.wait(0.1)

            bodyGyro:Destroy()
            bodyPos:Destroy()
            conn:Disconnect()

            for _, part in ipairs(char:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = true
                end
            end

            task.wait(2)

            if not enabled then return end

            local humanoid = char:WaitForChild("Humanoid")
            local hrp = char:WaitForChild("HumanoidRootPart")

            local path = PathfindingService:CreatePath()
            path:ComputeAsync(hrp.Position, targetPos)

            if path.Status ~= Enum.PathStatus.Success then return end

            local waypoints = path:GetWaypoints()

            for _, waypoint in ipairs(waypoints) do
                if not enabled then break end
                humanoid:MoveTo(waypoint.Position)
                local reached = humanoid.MoveToFinished:Wait()
                if not reached then break end
            end
        end

        task.defer(glideToChest)

        LocalPlayer.CharacterAdded:Connect(function()
            task.wait(1.5)
            if enabled then
                glideToChest()
            end
        end)
    end
})

local buyTab = window:CreateTab({
    ShowTitle = true,
    ImageSource = "Material",
    Icon = "shopping_cart",
    Name = "Buy"
})

local crateType = "Common"
local crateQuantity = 1

buyTab:CreateDropdown({
    Description = "Choose the crate to buy",
    CurrentOption = {crateType},
    Name = "Crate Type",
    MultipleOptions = false,
    Options = {"Common", "Uncommon", "Rare", "Epic", "Legendary"},
    Callback = function(option)
        if type(option) == "table" then
            crateType = option[1]
        else
            crateType = option
        end
    end
})

buyTab:CreateInput({
    Numeric = true,
    CurrentValue = tostring(crateQuantity),
    PlaceholderText = "Enter number",
    MaxCharacters = 3,
    Description = "Number of crates to buy",
    Name = "Quantity",
    Callback = function(input)
        local num = tonumber(input)
        if num and num > 0 then
            crateQuantity = num
        end
    end
})

buyTab:CreateButton({
    Name = "Buy Crates",
    Description = "Buys the selected crates x quantity",
    Callback = function()
        local shop = Workspace:FindFirstChild("ItemBoughtFromShop")
        if shop then
            shop:InvokeServer(crateType, crateQuantity)
        else
            warn("Shop remote not found, dumbass.")
        end
    end
})

buyTab:CreateParagraph({
    Title = "Crate's Price",
    Text = "<font color=\"rgb(0,255,0)\">Common</font> Chest : 5 <font color=\"rgb(255,255,0)\">Gold</font>\n" ..
           "<font color=\"rgb(255,255,0)\">Uncommon</font> Chest : 15 <font color=\"rgb(255,255,0)\">Gold</font>\n" ..
           "<font color=\"rgb(255,0,0)\">Rare</font> Chest : 45 <font color=\"rgb(255,255,0)\">Gold</font>\n" ..
           "<font color=\"rgb(0,255,255)\">Epic</font> Chest : 135 <font color=\"rgb(255,255,0)\">Gold</font>\n" ..
           "<font color=\"rgb(128,0,128)\">Legendary</font> Chest : 405 <font color=\"rgb(255,255,0)\">Gold</font>"
})

local infoTab = window:CreateTab({
    ShowTitle = true,
    ImageSource = "Material",
    Icon = "info",
    Name = "Info"
})

infoTab:CreateParagraph({
    Title = "ATTENTION! ",
    Text = "This Script Is Recently Made. It Would Cause Bugs in rare cases."
})

infoTab:CreateButton({
    Name = "Use Our Executor!",
    Description = "With The UNC and the SUNC of 99%, Lag-Free Gameplay,Fast Key Sytem! click this to get it on our official Website!",
    Callback = function()
        setclipboard("getfrosts.xyz")
    end
})
