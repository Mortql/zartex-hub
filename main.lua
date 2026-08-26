-- main.lua (Zartex Hub - Tüm Özellikler)
local WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Footagesus/WindUI/main/dist/main.lua"))()

local Window = WindUI:CreateWindow({
    Title = "Zartex Hub",
    Theme = "Violet",
    ToggleKey = Enum.KeyCode.RightControl,
    Folder = "ZartexHub"
})

-- 1. FARM TAB
local FarmTab = Window:Tab({ Title = "Farm", Icon = "sword" })
local farmSection = FarmTab:Section("Farm Controls")

-- Auto Farm Toggle
farmSection:Toggle({
    Title = "Auto Farm",
    Value = false,
    Callback = function(state)
        if state then
            print("[Zartex] Auto Farm AÇILDI!")
            -- Farm döngünü başlat
        else
            print("[Zartex] Auto Farm KAPANDI!")
        end
    end
})

-- Farm Distance Slider
farmSection:Slider({
    Title = "Farm Distance",
    Min = 20,
    Max = 100,
    Default = 50,
    Callback = function(value)
        print("[Zartex] Distance: " .. value)
    end
})

-- Teleport Button
farmSection:Button({
    Title = "Teleport to Enemy",
    Callback = function()
        print("[Zartex] Teleport!")
        -- Teleport kodun
    end
})

-- 2. PLAYER TAB
local PlayerTab = Window:Tab({ Title = "Player", Icon = "user" })
local playerSection = PlayerTab:Section("Player Controls")

playerSection:Slider({
    Title = "Walk Speed",
    Min = 16,
    Max = 100,
    Default = 16,
    Callback = function(value)
        local char = game.Players.LocalPlayer.Character
        if char then char.Humanoid.WalkSpeed = value end
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

-- 3. VISUAL TAB
local VisualTab = Window:Tab({ Title = "Visuals", Icon = "eye" })
local visualSection = VisualTab:Section("Visual Controls")

visualSection:Toggle({
    Title = "Fullbright",
    Value = false,
    Callback = function(state)
        if state then
            game:GetService("Lighting").Brightness = 2
        else
            game:GetService("Lighting").Brightness = 1
        end
    end
})

visualSection:Colorpicker({
    Title = "ESP Color",
    Value = Color3.fromRGB(255, 0, 0),
    Callback = function(color)
        print("[Zartex] ESP Color: " .. color:ToHex())
    end
})

-- 4. SETTINGS TAB
local SettingsTab = Window:Tab({ Title = "Settings", Icon = "settings" })
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

-- Bildirim
WindUI:Notify({
    Title = "Zartex Hub",
    Content = "Sağ Ctrl ile menüyü aç/kapat!",
    Duration = 5
})

print("[Zartex] Zartex Hub yüklendi!")
