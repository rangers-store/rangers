-- Wait game load
repeat task.wait() until game:IsLoaded()

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Place whitelist
local Place_ID_With_Matching_Loader = {
    [13643807539] = "https://api.luarmor.net/files/v4/loaders/16fbd70fa4f67e17014e3a949c9d57bf.lua"; -- South Bronx
}

-- Check place
if not Place_ID_With_Matching_Loader[game.PlaceId] then
    player:Kick("Rangers.rawr | This game is not supported!")
    return
end

-- Get key
local key = getgenv().script_key
if not key then
    player:Kick("Rangers.rawr | Key not found!")
    return
end

script_key = key

-- Save key if supported
if writefile then
    pcall(function()
        writefile("rangers_key.txt", key)
    end)
end

-- Wait a little
task.wait(0.3)

-- HttpGet compatibility
local HttpGet = game.HttpGet or game.httpget

local success, result = pcall(function()
    return HttpGet(game, Place_ID_With_Matching_Loader[game.PlaceId])
end)

if not success then
    player:Kick("Rangers.rawr | Failed to load script!")
    return
end

-- Execute
loadstring(result)()
