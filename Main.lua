-- wait game load
repeat task.wait() until game:IsLoaded()
repeat task.wait() until game.Players.LocalPlayer

local player = game.Players.LocalPlayer

-- place list
local Place_ID_With_Matching_Luarmor_ID = {
    [13643807539] = "https://api.luarmor.net/files/v4/loaders/16fbd70fa4f67e17014e3a949c9d57bf.lua"; -- South Bronx
}

-- check place
if not Place_ID_With_Matching_Luarmor_ID[game.PlaceId] then
    player:Kick("Rangers.rawr | This game is not supported!")
    return
end

-- check key
if not (getgenv().script_key or script_key) then
    player:Kick("Rangers.rawr | Key not found!")
    return
end

-- save key
local key = getgenv().script_key or script_key
pcall(function()
    writefile("rangers_key.txt", key)
end)

-- set key
getgenv().script_key = key
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
