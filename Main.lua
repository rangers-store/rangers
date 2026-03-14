-- wait game load
repeat task.wait() until game:IsLoaded()
repeat task.wait() until game.Players.LocalPlayer

local player = game.Players.LocalPlayer

-- place list
local Place_ID_With_Matching_Luarmor_ID = {
    [13643807539] = "https://api.luarmor.net/files/v4/loaders/801de8141111c27e3cad9b89a68cb9b1.lua"; -- South Bronx
    [14413475235] = "https://api.luarmor.net/files/v4/loaders/801de8141111c27e3cad9b89a68cb9b1.lua"; -- South Bronx
}

-- check place
if not Place_ID_With_Matching_Luarmor_ID[game.PlaceId] then
    player:Kick("Rangers.rawr | This game is not supported!")
    return
end

-- sync key dari semua sumber
if not getgenv().script_key then
    getgenv().script_key = _G.script_key or script_key
end

-- check key
if not (getgenv().script_key or _G.script_key or script_key) then
    player:Kick("Rangers.rawr | Key not found!")
    return
end

-- save key
local key = getgenv().script_key or _G.script_key or script_key
pcall(function()
    writefile("rangers_key.txt", key)
end)

-- set key
getgenv().script_key = key
_G.script_key = key
script_key = key

-- get loader url
local url = Place_ID_With_Matching_Luarmor_ID[game.PlaceId]

-- retry system
local success = false
local response

for i = 1,3 do
    success, response = pcall(function()
        return game:HttpGet(url, true)
    end)

    if success and response then
        break
    end

    warn("Rangers.rawr | Retry loading script ("..i.."/3)")
    task.wait(2)
end

-- execute script
if success and response then
    local func = loadstring(response)

    if func then
        func()
    else
        player:Kick("Rangers.rawr | Script compile failed!")
    end
else
    player:Kick("Rangers.rawr | Failed to load script!")
end
