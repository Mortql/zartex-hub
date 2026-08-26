-- Zartex Hub - main.lua (GitHub'daki ana dosya)
-- Bu dosya, kullanıcı loadstring ile çalıştırdığında çalışır.

local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()

if not WindUI then
    print("[Zartex] WindUI yüklenemedi!")
    return
end

local Window = WindUI:CreateWindow({
    Title = "Zartex Hub",
    Theme = "Violet",
    ToggleKey = Enum.KeyCode.RightControl
})

local MainTab = Window:Tab({
    Title = "Ana",
    Icon = "home"
})

MainTab:Toggle({
    Title = "Auto Farm",
    Description = "Düşmanları otomatik keser.",
    Value = false,
    Callback = function(state)
        if state then
            print("[Zartex] Auto Farm AÇILDI!")
        else
            print("[Zartex] Auto Farm KAPANDI!")
        end
    end
})

MainTab:Slider({
    Title = "Hız Ayarı",
    Description = "Yürüme hızını değiştirir.",
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

print("[Zartex] Zartex Hub yüklendi! Sağ Ctrl ile menüyü aç/kapat.")
