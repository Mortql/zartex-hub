-- Zartex Hub v12.0 - WindUI (Düzeltilmiş)
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
-- FARM TAB (BÖLÜM EKLENDİ)
-- ============================
local FarmTab = Window:Tab({
    Title = "Farm",
    Icon = "sword"
})

-- BÖLÜM OLUŞTUR
local farmSection = FarmTab:Section("Farm Controls")

-- ŞİMDİ ELEMENTLER ÇALIŞIR
farmSection:Toggle({
    Title = "Auto Farm",
    Desc = "En yakın düşmana otomatik saldırır.",
    Value = false,
    Callback = function(state)
        if state then
            print("[Zartex] Auto Farm AÇILDI!")
        else
            print("[Zartex] Auto Farm KAPANDI!")
        end
    end
})

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

farmSection:Button({
    Title = "Teleport to Enemy",
    Desc = "En yakın düşmana ışınlanır.",
    Callback = function()
        print("[Zartex] Teleport!")
    end
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

playerSection:Toggle({
    Title = "Fly",
    Value = false,
    Callback = function(state)
        if state then
            print("[Zartex] Fly AÇILDI!")
        else
            print("[Zartex] Fly KAPANDI!")
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
    Default = "RightControl",
    Callback = function(key)
        print("[Zartex] Menu Key: " .. key)
    end
})

settingsSection:Button({
    Title = "Destroy UI",
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

print("[Zartex] Zartex Hub v12.0 yüklendi!")
