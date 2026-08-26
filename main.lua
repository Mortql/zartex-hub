-- Zartex Hub v28.0 - VanixiaUI + Auto Farm + ESP + Chams + Tracer + Fly + Noclip
-- English Only - Global Use

print("[Zartex] Zartex Hub loading...")

local VanixiaUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Thuan6565/Vanixian-UI-Library/refs/heads/main/VanixiaUI.lua"))()

if not VanixiaUI then
    print("[Zartex] VanixiaUI failed to load!")
    return
end

local Window = VanixiaUI:CreateWindow({
    Title = "Zartex Hub",
    Author = "by Zartex",
    Size = UDim2.fromOffset(536, 400),
    ToggleKey = Enum.KeyCode.RightControl,
    Color = "Yellow"
})

Window:CreateTag("v2.5", "Yellow")

-- ============================
-- TABS
-- ============================
local FarmTab = Window:CreateTab("Farm", "sword")
local PlayerTab = Window:CreateTab("Player", "user")
local VisualTab = Window:CreateTab("Visuals", "eye")
local ESPTab = Window:CreateTab("ESP", "eye")
local SettingsTab = Window:CreateTab("Settings", "settings")
local InfoTab = Window:CreateTab("Info", "info")

-- ============================
-- GAME DETECTION
-- ============================
local Games = {
    [142823291] = "Murder Mystery 2",
    [537413528] = "Build A Boat For Treasure",
    [9872472334] = "Evade",
    [10449761463] = "The Strongest Battlegrounds",
    [13772394625] = "Blade Ball",
    [8908228901] = "SharkBite 2",
    [155615604] = "Prison Life",
    [738339342] = "Flood Escape 2",
    [6447798030] = "Funky Friday",
    [6229116934] = "Hoopz"
}

local currentGameId = game.PlaceId
local currentGameName = Games[currentGameId] or "Unknown Game"

-- ============================
-- AUTO FARM SYSTEM
-- ============================
local farmEnabled = false
local farmLoop = nil
local farmRange = 50

local function findEnemy()
    local char = game.Players.LocalPlayer.Character
    if not char then return nil end
    local root = char:FindFirstChild("HumanoidRootPart")
    if not root then return nil end
    
    local nearest = nil
    local shortest = math.huge
    
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("Model") and obj:FindFirstChild("Humanoid") and obj:FindFirstChild("HumanoidRootPart") then
            local hum = obj:FindFirstChild("Humanoid")
            if hum and hum.Health > 0 then
                local dist = (obj.HumanoidRootPart.Position - root.Position).Magnitude
                if dist < shortest and dist < farmRange then
                    shortest = dist
                    nearest = obj
                end
            end
        end
    end
    return nearest
end

local function attackEnemy(enemy)
    if not enemy or not enemy:FindFirstChild("HumanoidRootPart") then return end
    local char = game.Players.LocalPlayer.Character
    if not char then return end
    local root = char:FindFirstChild("HumanoidRootPart")
    if not root then return end
    
    root.CFrame = enemy.HumanoidRootPart.CFrame + Vector3.new(0, 3, 0)
    task.wait(0.1)
    
    local VirtualInput = game:GetService("VirtualInputManager")
    VirtualInput:SendMouseButtonEvent(0, 0, 0, true, "Left", 1)
    task.wait(0.05)
    VirtualInput:SendMouseButtonEvent(0, 0, 0, false, "Left", 1)
end

local function startFarm()
    if farmLoop then return end
    farmLoop = game:GetService("RunService").Stepped:Connect(function()
        if not farmEnabled then
            if farmLoop then
                farmLoop:Disconnect()
                farmLoop = nil
            end
            return
        end
        local enemy = findEnemy()
        if enemy then
            attackEnemy(enemy)
        end
        task.wait(0.5)
    end)
end

-- ============================
-- FLY SYSTEM
-- ============================
local flyEnabled = false
local flyConnection = nil
local flyBodyVelocity = nil

local function toggleFly(state)
    flyEnabled = state
    local char = game.Players.LocalPlayer.Character
    if not char then return end
    local root = char:FindFirstChild("HumanoidRootPart")
    if not root then return end
    
    if flyEnabled then
        flyBodyVelocity = Instance.new("BodyVelocity")
        flyBodyVelocity.MaxForce = Vector3.new(1e6, 1e6, 1e6)
        flyBodyVelocity.Velocity = Vector3.new(0, 0, 0)
        flyBodyVelocity.Parent = root
        
        flyConnection = game:GetService("RunService").RenderStepped:Connect(function()
            if not flyEnabled then
                if flyBodyVelocity then flyBodyVelocity:Destroy() end
                if flyConnection then flyConnection:Disconnect() end
                return
            end
            local move = Vector3.new(0, 0, 0)
            local uis = game:GetService("UserInputService")
            if uis:IsKeyDown(Enum.KeyCode.W) then move = move + Vector3.new(0, 0, -50) end
            if uis:IsKeyDown(Enum.KeyCode.S) then move = move + Vector3.new(0, 0, 50) end
            if uis:IsKeyDown(Enum.KeyCode.A) then move = move + Vector3.new(-50, 0, 0) end
            if uis:IsKeyDown(Enum.KeyCode.D) then move = move + Vector3.new(50, 0, 0) end
            if uis:IsKeyDown(Enum.KeyCode.Space) then move = move + Vector3.new(0, 50, 0) end
            if uis:IsKeyDown(Enum.KeyCode.LeftShift) then move = move + Vector3.new(0, -50, 0) end
            flyBodyVelocity.Velocity = move
        end)
    else
        if flyConnection then
            flyConnection:Disconnect()
            flyConnection = nil
        end
        if flyBodyVelocity then
            flyBodyVelocity:Destroy()
            flyBodyVelocity = nil
        end
    end
end

-- ============================
-- NOCLIP SYSTEM
-- ============================
local noclipEnabled = false
local noclipConnection = nil

local function toggleNoclip(state)
    noclipEnabled = state
    if noclipEnabled then
        noclipConnection = game:GetService("RunService").Stepped:Connect(function()
            if not noclipEnabled then
                noclipConnection:Disconnect()
                return
            end
            local char = game.Players.LocalPlayer.Character
            if char then
                for _, part in pairs(char:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            end
        end)
    else
        if noclipConnection then
            noclipConnection:Disconnect()
            noclipConnection = nil
        end
        local char = game.Players.LocalPlayer.Character
        if char then
            for _, part in pairs(char:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = true
                end
            end
        end
    end
end

-- ============================
-- ESP SYSTEM
-- ============================
local espEnabled = false
local espObjects = {}
local espColor = Color3.fromRGB(255, 0, 0)

local function createESP()
    for _, player in pairs(game:GetService("Players"):GetPlayers()) do
        if player ~= game.Players.LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local highlight = Instance.new("Highlight")
            highlight.Adornee = player.Character
            highlight.FillColor = espColor
            highlight.FillTransparency = 0.5
            highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
            highlight.Parent = player.Character
            espObjects[player] = highlight
        end
    end
end

local function removeESP()
    for player, highlight in pairs(espObjects) do
        if highlight then highlight:Destroy() end
    end
    espObjects = {}
end

local function toggleESP(state)
    espEnabled = state
    if espEnabled then
        createESP()
        game.Players.PlayerAdded:Connect(function(p)
            if espEnabled then
                p.CharacterAdded:Connect(function()
                    task.wait(0.5)
                    if espEnabled and p.Character then
                        local h = Instance.new("Highlight")
                        h.Adornee = p.Character
                        h.FillColor = espColor
                        h.FillTransparency = 0.5
                        h.Parent = p.Character
                        espObjects[p] = h
                    end
                end)
            end
        end)
    else
        removeESP()
    end
end

-- ============================
-- CHAMS SYSTEM (Box ESP)
-- ============================
local chamsEnabled = false
local chamsObjects = {}

local function createChams()
    for _, player in pairs(game:GetService("Players"):GetPlayers()) do
        if player ~= game.Players.LocalPlayer and player.Character then
            for _, part in pairs(player.Character:GetDescendants()) do
                if part:IsA("BasePart") then
                    local box = Instance.new("BoxHandleAdornment")
                    box.Size = part.Size + Vector3.new(0.5, 0.5, 0.5)
                    box.Adornee = part
                    box.Color3 = espColor
                    box.Transparency = 0.3
                    box.AlwaysOnTop = true
                    box.Parent = part
                    chamsObjects[#chamsObjects + 1] = box
                end
            end
        end
    end
end

local function removeChams()
    for _, box in pairs(chamsObjects) do
        if box then box:Destroy() end
    end
    chamsObjects = {}
end

local function toggleChams(state)
    chamsEnabled = state
    if chamsEnabled then
        createChams()
    else
        removeChams()
    end
end

-- ============================
-- TRACER SYSTEM
-- ============================
local tracerEnabled = false
local tracerObjects = {}

local function createTracers()
    for _, player in pairs(game:GetService("Players"):GetPlayers()) do
        if player ~= game.Players.LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local tracer = Instance.new("LineHandleAdornment")
            tracer.Adornee = player.Character.HumanoidRootPart
            tracer.Thickness = 1
            tracer.Color3 = espColor
            tracer.Length = 15
            tracer.Transparency = 0.5
            tracer.Parent = player.Character.HumanoidRootPart
            tracerObjects[player] = tracer
        end
    end
end

local function removeTracers()
    for player, tracer in pairs(tracerObjects) do
        if tracer then tracer:Destroy() end
    end
    tracerObjects = {}
end

local function toggleTracer(state)
    tracerEnabled = state
    if tracerEnabled then
        createTracers()
    else
        removeTracers()
    end
end

-- ============================
-- FARM TAB
-- ============================
FarmTab:CreateToggle("Auto Farm", function(state)
    farmEnabled = state
    if state then
        print("[Zartex] Auto Farm Started!")
        VanixiaUI:CreateNotification({
            Title = "Auto Farm",
            Description = "Started!",
            Icon = "play",
            Theme = "Yellow",
            Duration = 2
        })
        startFarm()
    else
        print("[Zartex] Auto Farm Stopped!")
        VanixiaUI:CreateNotification({
            Title = "Auto Farm",
            Description = "Stopped!",
            Icon = "pause",
            Theme = "Yellow",
            Duration = 2
        })
        if farmLoop then
            farmLoop:Disconnect()
            farmLoop = nil
        end
    end
end)

FarmTab:CreateSlider("Farm Range", 20, 100, 50, function(value)
    farmRange = value
    print("[Zartex] Farm Range: " .. value)
end)

FarmTab:CreateButton("Teleport to Enemy", function()
    local enemy = findEnemy()
    if enemy then
        local char = game.Players.LocalPlayer.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            char.HumanoidRootPart.CFrame = enemy.HumanoidRootPart.CFrame + Vector3.new(0, 3, 0)
            VanixiaUI:CreateNotification({
                Title = "Teleport",
                Description = "Teleported to enemy!",
                Icon = "send",
                Theme = "Yellow",
                Duration = 2
            })
        end
    else
        VanixiaUI:CreateNotification({
            Title = "Teleport",
            Description = "No enemy found!",
            Icon = "alert-circle",
            Theme = "Yellow",
            Duration = 2
        })
    end
end)

FarmTab:CreateParagraph("Game Info", "Current Game: " .. currentGameName .. "\nGame ID: " .. currentGameId)

-- ============================
-- PLAYER TAB
-- ============================
PlayerTab:CreateSlider("Walk Speed", 16, 100, 16, function(value)
    local char = game.Players.LocalPlayer.Character
    if char and char:FindFirstChild("Humanoid") then
        char.Humanoid.WalkSpeed = value
    end
    print("[Zartex] Walk Speed: " .. value)
end)

PlayerTab:CreateSlider("Jump Power", 50, 350, 50, function(value)
    local char = game.Players.LocalPlayer.Character
    if char and char:FindFirstChild("Humanoid") then
        char.Humanoid.JumpPower = value
    end
    print("[Zartex] Jump Power: " .. value)
end)

PlayerTab:CreateToggle("Fly", function(state)
    toggleFly(state)
    if state then
        print("[Zartex] Fly Enabled!")
        VanixiaUI:CreateNotification({
            Title = "Fly",
            Description = "Enabled! WASD + Space/Shift",
            Icon = "plane",
            Theme = "Yellow",
            Duration = 2
        })
    else
        print("[Zartex] Fly Disabled!")
    end
end)

PlayerTab:CreateToggle("Noclip", function(state)
    toggleNoclip(state)
    if state then
        print("[Zartex] Noclip Enabled!")
        VanixiaUI:CreateNotification({
            Title = "Noclip",
            Description = "Enabled!",
            Icon = "ghost",
            Theme = "Yellow",
            Duration = 2
        })
    else
        print("[Zartex] Noclip Disabled!")
    end
end)

-- ============================
-- ESP TAB
-- ============================
ESPTab:CreateToggle("ESP (Player)", function(state)
    toggleESP(state)
    if state then
        print("[Zartex] ESP Enabled!")
        VanixiaUI:CreateNotification({
            Title = "ESP",
            Description = "Enabled!",
            Icon = "eye",
            Theme = "Yellow",
            Duration = 2
        })
    else
        print("[Zartex] ESP Disabled!")
    end
end)

ESPTab:CreateToggle("Chams (Box)", function(state)
    toggleChams(state)
    if state then
        print("[Zartex] Chams Enabled!")
    else
        print("[Zartex] Chams Disabled!")
    end
end)

ESPTab:CreateToggle("Tracer", function(state)
    toggleTracer(state)
    if state then
        print("[Zartex] Tracer Enabled!")
    else
        print("[Zartex] Tracer Disabled!")
    end
end)

ESPTab:CreateButton("ESP Color Picker", function()
    -- Simple color picker placeholder
    local colors = {
        {name = "Red", color = Color3.fromRGB(255, 0, 0)},
        {name = "Green", color = Color3.fromRGB(0, 255, 0)},
        {name = "Blue", color = Color3.fromRGB(0, 0, 255)},
        {name = "Yellow", color = Color3.fromRGB(255, 255, 0)},
        {name = "Purple", color = Color3.fromRGB(255, 0, 255)}
    }
    
    -- For simplicity, cycle through colors
    local currentIndex = 1
    espColor = colors[currentIndex].color
    
    VanixiaUI:CreateNotification({
        Title = "ESP Color",
        Description = "Color set to: " .. colors[currentIndex].name,
        Icon = "palette",
        Theme = "Yellow",
        Duration = 2
    })
    
    -- Refresh ESP with new color
    if espEnabled then
        removeESP()
        createESP()
    end
    if chamsEnabled then
        removeChams()
        createChams()
    end
    if tracerEnabled then
        removeTracers()
        createTracers()
    end
end)

-- ============================
-- VISUAL TAB
-- ============================
VisualTab:CreateToggle("Fullbright", function(state)
    if state then
        game:GetService("Lighting").Brightness = 2
        game:GetService("Lighting").Ambient = Color3.new(1, 1, 1)
        print("[Zartex] Fullbright Enabled!")
    else
        game:GetService("Lighting").Brightness = 1
        game:GetService("Lighting").Ambient = Color3.new(0, 0, 0)
        print("[Zartex] Fullbright Disabled!")
    end
end)

-- ============================
-- INFO TAB
-- ============================
InfoTab:CreateParagraph("Zartex Hub v2.5", "Global Script Hub for Roblox\n\nMade by Zartex")
InfoTab:CreateParagraph("Current Game", "Name: " .. currentGameName .. "\nID: " .. currentGameId)
InfoTab:CreateParagraph("Features", "Auto Farm\nESP (Player Highlight)\nChams (Box ESP)\nTracer\nFly\nNoclip\nFullbright\nSpeed/Jump Control")

-- ============================
-- SETTINGS TAB
-- ============================
SettingsTab:CreateButton("Destroy UI", function()
    Window:Destroy()
    print("[Zartex] UI Destroyed!")
end)

-- ============================
-- NOTIFICATION
-- ============================
VanixiaUI:CreateNotification({
    Title = "Zartex Hub",
    Description = "Right Ctrl to toggle menu!",
    Icon = "zap",
    Theme = "Yellow",
    Duration = 5
})

print("[Zartex] Zartex Hub v28.0 loaded! Current Game: " .. currentGameName)
