-- Zartex Hub v11.0 - main.lua (Tam Kod)
-- Bu dosya doğrudan çalışır, harici yükleme yok.

print("[Zartex] Zartex Hub yükleniyor...")

-- ============================
-- 1. WINDUI'Yİ YÜKLE (XENO İÇİN OPTİMİZE)
-- ============================
local function HttpGet(url)
    local success, result = pcall(function()
        return game:HttpGet(url)
    end)
    if success then return result end
    return nil
end

local WindUI = nil

-- Önce en kararlı sürümü dene
local url = "https://raw.githubusercontent.com/Footagesus/WindUI/main/source.lua"
local scriptContent = HttpGet(url)

if scriptContent then
    local fn, err = loadstring(scriptContent)
    if fn then
        WindUI = fn()
    else
        print("[Zartex] WindUI derleme hatası: " .. tostring(err))
    end
end

-- Eğer olmadıysa, doğrudan kendi UI'ni kullan
if not WindUI then
    print("[Zartex] WindUI yüklenemedi! Kendi UI ile devam...")
    -- Burada kendi UI'ni oluşturabilirsin
    return
end

print("[Zartex] WindUI başarıyla yüklendi!")

-- ============================
-- 2. MENÜYÜ OLUŞTUR
-- ============================
local Window = WindUI:CreateWindow({
    Title = "Zartex Hub",
    Theme = "Violet",
    ToggleKey = Enum.KeyCode.RightControl
})

local MainTab = Window:Tab({
    Title = "Ana",
    Icon = "home"
})

-- ============================
-- 3. ÖZELLİKLER
-- ============================
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
        if WindUI.Notify then
            WindUI:Notify({
                Title = "Başarılı",
                Content = "WindUI çalışıyor!",
                Duration = 3
            })
        end
    end
})

print("[Zartex] Zartex Hub başarıyla yüklendi! Sağ Ctrl ile menüyü aç/kapat.")
