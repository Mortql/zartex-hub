-- Zartex Hub - WindUI ile
local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()

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

print("[Zartex] WindUI ile Zartex Hub çalışıyor!")
