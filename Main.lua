repeat task.wait() until game:IsLoaded()

local Players = game:GetService("Players")
local player = Players.LocalPlayer

local Place_ID_With_Matching_Loader = {
    [13643807539] = "https://api.luarmor.net/files/v4/loaders/16fbd70fa4f67e17014e3a949c9d57bf.lua";
}

if not Place_ID_With_Matching_Loader[game.PlaceId] then
    player:Kick("Rangers.rawr | This game is not supported!")
    return
end

local key = getgenv().script_key
if not key then
    player:Kick("Rangers.rawr | Key not found!")
    return
end

script_key = key

-- save key if executor support
if writefile then
    pcall(function()
        writefile("rangers_key.txt", key)
    end)
end

task.wait(0.2)

-- universal httpget
local url = Place_ID_With_Matching_Loader[game.PlaceId]

local data
pcall(function()
    data = game:HttpGet(url)
end)

if not data then
    player:Kick("Failed to load script")
    return
end

loadstring(data)()
