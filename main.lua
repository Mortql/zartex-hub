-- Zartex Hub - Hata Ayıklamalı
print("[Zartex] Yükleniyor...")

local success, WindUI = pcall(function()
    return loadstring(game:HttpGet("https://raw.githubusercontent.com/Footagesus/WindUI/main/source.lua"))()
end)

if not success or not WindUI then
    print("[Zartex] WindUI yüklenemedi! Hata: " .. tostring(success))
    return
end

print("[Zartex] WindUI yüklendi!")

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
    Value = false,
    Callback = function(state)
        print("[Zartex] Auto Farm: " .. tostring(state))
    end
})

print("[Zartex] Zartex Hub başarıyla yüklendi!")
