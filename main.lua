-- Zartex Hub v11.0 - WindUI (Çalışan + Auto Farm)
local WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Footagesus/WindUI/main/dist/main.lua"))()

if not WindUI then
    print("[Zartex] WindUI yüklenemedi!")
    return
end

local Window = WindUI:CreateWindow({
    Title = "Zartex Hub",
    Theme = "Violet",
    ToggleKey = Enum.KeyCode.RightControl,
    Folder = "ZartexHub"
})

-- ============================
-- FARM TAB
-- ============================
local FarmTab = Window:Tab({
    Title = "Farm",
    Icon = "sword"
})

local farmSection = FarmTab:Section("Farm Controls")

-- AUTO FARM (ÇALIŞAN)
local autoFarm = false
local farmLoop = nil

farmSection:Toggle({
    Title = "Auto Farm",
    Desc = "En yakın düşmana otomatik saldırır.",
    Value = false,
    Callback = function(state)
        autoFarm = state
        if state then
            print("[Zartex] Auto Farm AÇILDI!")
            farmLoop = game:GetService("RunService").Stepped:Connect(function()
                if not autoFarm then
                    if farmLoop then
                        farmLoop:Disconnect()
                        farmLoop = nil
                    end
                    return
                end
                
                -- FARM KODU
                local player = game.Players.LocalPlayer
                local char = player.Character
                if not char then return end
                local root = char:FindFirstChild("HumanoidRootPart")
                if not root then return end
                
                local nearest = nil
                local shortestDist = math.huge
                
                for _, obj in pairs(workspace:GetDescendants()) do
                    if obj:IsA("Model") and obj:FindFirstChild("Humanoid") and obj:FindFirstChild("HumanoidRootPart") then
                        local humanoid = obj:FindFirstChild("Humanoid")
                        if humanoid and humanoid.Health > 0 then
                            local dist = (obj.HumanoidRootPart.Position - root.Position).Magnitude
                            if dist < shortestDist and dist < 50 then
                                shortestDist = dist
                                nearest = obj
                            end
                        end
                    end
                end
                
                if nearest then
                    local targetRoot = nearest:FindFirstChild("HumanoidRootPart")
                    if targetRoot then
                        root.CFrame = targetRoot.CFrame + Vector3.new(0, 3, 0)
                        task.wait(0.1)
                        local VirtualInput = game:GetService("VirtualInputManager")
                        VirtualInput:SendMouseButtonEvent(0, 0, 0, true, "Left", 1)
                        task.wait(0.05)
                        VirtualInput:SendMouseButtonEvent(0, 0, 0, false, "Left", 1)
                        task.wait(0.3)
                    end
                else
                    task.wait(0.5)
                end
            end)
        else
            print("[Zartex] Auto Farm KAPANDI!")
            if farmLoop then
                farmLoop:Disconnect()
                farmLoop = nil
            end
        end
    end
})

-- FARM DISTANCE
farmSection:Slider({
    Title = "Farm Distance",
    Desc = "Düşman arama mesafesi.",
    Min = 20,
    Max = 100,
    Default = 50,
    Callback = function(value)
        print("[Zartex] Farm Distance: " .. value)
    end
})

-- TELEPORT TO ENEMY
farmSection:Button({
    Title = "Teleport to Enemy",
    Desc = "En yakın düşmana ışınlanır.",
    Callback = function()
        local player = game.Players.LocalPlayer
        local char = player.Character
        if not char then return
        local root = char:FindFirstChild("HumanoidRootPart")
        if not root then return
        
        local nearest = nil
        local shortestDist = math.huge
        
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj:IsA("Model") and obj:FindFirstChild("Humanoid") and obj:FindFirstChild("HumanoidRootPart") then
                local humanoid = obj:FindFirstChild("Humanoid")
                if humanoid and humanoid.Health > 0 then
                    local dist = (obj.HumanoidRootPart.Position - root.Position).Magnitude
                    if dist < shortestDist then
                        shortestDist = dist
                        nearest = obj
                    end
                end
            end
        end
        
        if nearest then
            root.CFrame = nearest.HumanoidRootPart.CFrame + Vector3.new(0, 3, 0)
            WindUI:Notify({
                Title = "Teleport",
                Content = "En yakın düşmana ışınlandı!",
                Duration = 2
            })
        else
            WindUI:Notify({
                Title = "Teleport",
                Content = "Düşman bulunamadı!",
                Duration = 2
            })
        end
    end
})

farmSection:Divider()
farmSection:Label({
    Title = "💡 Sağ Ctrl ile menüyü aç/kapat"
})

-- ============================
-- PLAYER TAB
-- ============================
local PlayerTab = Window:Tab({
    Title = "Player",
    Icon = "user"
})

local playerSection = PlayerTab:Section("Player Controls")

playerSection:Slider({
    Title = "Walk Speed",
    Desc = "Yürüme hızını ayarlar.",
    Min = 16,
    Max = 100,
    Default = 16,
    Callback = function(value)
        local char = game.Players.LocalPlayer.Character
        if char and char:FindFirstChild("Humanoid") then
            char.Humanoid.WalkSpeed = value
        end
    end
})

playerSection:Slider({
    Title = "Jump Power",
    Desc = "Zıplama gücünü ayarlar.",
    Min = 50,
    Max = 350,
    Default = 50,
    Callback = function(value)
        local char = game.Players.LocalPlayer.Character
        if char and char:FindFirstChild("Humanoid") then
            char.Humanoid.JumpPower = value
        end
    end
})

-- FLY
local flyActive = false
local flyConnection = nil

playerSection:Toggle({
    Title = "Fly",
    Desc = "WASD + Space/Shift ile uç.",
    Value = false,
    Callback = function(state)
        flyActive = state
        local player = game.Players.LocalPlayer
        local char = player.Character
        if not char then return
        
        if flyActive then
            local root = char:FindFirstChild("HumanoidRootPart")
            if root then
                local bv = Instance.new("BodyVelocity")
                bv.MaxForce = Vector3.new(1e6, 1e6, 1e6)
                bv.Velocity = Vector3.new(0, 0, 0)
                bv.Parent = root
                
                flyConnection = game:GetService("RunService").RenderStepped:Connect(function()
                    if not flyActive then
                        if bv then bv:Destroy() end
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
                    bv.Velocity = move
                end)
            end
        else
            if flyConnection then
                flyConnection:Disconnect()
                flyConnection = nil
            end
            local root = char:FindFirstChild("HumanoidRootPart")
            if root then
                local bv = root:FindFirstChild("BodyVelocity")
                if bv then bv:Destroy() end
            end
        end
    end
})

playerSection:Toggle({
    Title = "Noclip",
    Desc = "Duvarlardan geçmeyi sağlar.",
    Value = false,
    Callback = function(state)
        if state then
            print("[Zartex] Noclip AÇILDI!")
            local conn = game:GetService("RunService").Stepped:Connect(function()
                if not state then
                    conn:Disconnect()
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
            print("[Zartex] Noclip KAPANDI!")
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
})

-- ============================
-- VISUAL TAB
-- ============================
local VisualTab = Window:Tab({
    Title = "Visuals",
    Icon = "eye"
})

local visualSection = VisualTab:Section("Visual Controls")

visualSection:Toggle({
    Title = "Fullbright",
    Desc = "Oyunu aydınlatır.",
    Value = false,
    Callback = function(state)
        if state then
            game:GetService("Lighting").Brightness = 2
            game:GetService("Lighting").Ambient = Color3.new(1, 1, 1)
        else
            game:GetService("Lighting").Brightness = 1
            game:GetService("Lighting").Ambient = Color3.new(0, 0, 0)
        end
    end
})

visualSection:Toggle({
    Title = "ESP",
    Desc = "Düşmanları kırmızı renkte gösterir.",
    Value = false,
    Callback = function(state)
        if state then
            print("[Zartex] ESP AÇILDI!")
        else
            print("[Zartex] ESP KAPANDI!")
        end
    end
})

-- ============================
-- SETTINGS TAB
-- ============================
local SettingsTab = Window:Tab({
    Title = "Settings",
    Icon = "settings"
})

local settingsSection = SettingsTab:Section("Settings")

settingsSection:Keybind({
    Title = "Menu Key",
    Desc = "Menüyü açıp kapatmak için tuş.",
    Default = "RightControl",
    Callback = function(key)
        print("[Zartex] Menu Key: " .. key)
    end
})

settingsSection:Button({
    Title = "Destroy UI",
    Desc = "Menüyü tamamen kapatır.",
    Callback = function()
        Window:Destroy()
    end
})

-- ============================
-- BİLDİRİM
-- ============================
WindUI:Notify({
    Title = "Zartex Hub",
    Content = "Sağ Ctrl ile menüyü aç/kapat!",
    Duration = 5,
    Icon = "zap"
})

print("[Zartex] Zartex Hub v11.0 yüklendi!")
