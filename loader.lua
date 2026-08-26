-- Zartex Hub - Loader
-- Kullanım: loadstring(game:HttpGet("https://raw.githubusercontent.com/KULLANICI_ADIN/ZartexHub/main/loader.lua"))()

local function HttpGet(url)
    local success, result = pcall(function()
        return game:HttpGet(url)
    end)
    if success then return result end
    return nil
end

-- Ana script'i yükle
local scriptUrl = "https://raw.githubusercontent.com/Mortql/zartex-hub/refs/heads/main/main.lua"
local script = HttpGet(scriptUrl)

if script then
    loadstring(script)()
else
    print("[Zartex] Script yüklenemedi!")
end
