-- Zartex Hub - main.lua (WindUI Example - Düzeltildi)
print("[Zartex] Zartex Hub yükleniyor...")

-- ============================
-- WINDUI'Yİ YÜKLE (GARANTİLİ)
-- ============================
local WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Footagesus/WindUI/main/dist/main.lua"))()

if not WindUI then
    print("[Zartex] WindUI yüklenemedi!")
    return
end

print("[Zartex] WindUI başarıyla yüklendi!")

-- ============================
-- PENCERE
-- ============================
local Window = WindUI:CreateWindow({
    Title = "Zartex Hub",
    Theme = "Violet",
    ToggleKey = Enum.KeyCode.RightControl
})

-- ============================
-- ANA TAB
-- ============================
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

MainTab:Button({
    Title = "Test Butonu",
    Description = "Tıkla ve çalıştığını gör.",
    Callback = function()
        print("[Zartex] Butona basıldı!")
        WindUI:Notify({
            Title = "Başarılı",
            Content = "WindUI çalışıyor!",
            Duration = 3
        })
    end
})

print("[Zartex] Zartex Hub başarıyla yüklendi! Sağ Ctrl ile menüyü aç/kapat.")
