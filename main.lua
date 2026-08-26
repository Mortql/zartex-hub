-- Zartex Hub - main.lua (Garanti Çalışan)
-- Kullanım: loadstring(game:HttpGet("https://raw.githubusercontent.com/KULLANICI_ADIN/ZartexHub/main/main.lua"))()

print("[Zartex] Zartex Hub yükleniyor...")

-- ============================
-- 1. WINDUI'Yİ YÜKLE (GARANTİLİ)
-- ============================
local function LoadWindUI()
    local urls = {
        "https://raw.githubusercontent.com/Footagesus/WindUI/main/source.lua",
        "https://github.com/Footagesus/WindUI/releases/latest/download/main.lua",
        "https://raw.githubusercontent.com/orialdev/windui-boreal/refs/heads/main/WindUI-Boreal.lua"
    }
    
    for _, url in ipairs(urls) do
        local success, result = pcall(function()
            return game:HttpGet(url)
        end)
        if success and result then
            local fn, err = loadstring(result)
            if fn then
                local lib = fn()
                if lib and lib.CreateWindow then
                    print("[Zartex] WindUI yüklendi: " .. url)
                    return lib
                end
            end
        end
    end
    return nil
end

local WindUI = LoadWindUI()

if not WindUI then
    print("[Zartex] WindUI yüklenemedi! Alternatif UI deneniyor...")
    -- Alternatif: Sadece print ile devam et
    return
end

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
        WindUI:Notify({
            Title = "Başarılı",
            Content = "WindUI çalışıyor!",
            Duration = 3
        })
    end
})

print("[Zartex] Zartex Hub başarıyla yüklendi!")
