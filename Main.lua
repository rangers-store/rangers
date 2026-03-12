-- wait game load
repeat task.wait() until game:IsLoaded()
repeat task.wait() until game.Players.LocalPlayer

-- place list
local Place_ID_With_Matching_Luarmor_ID = {
    [13643807539] = "https://api.luarmor.net/files/v4/loaders/16fbd70fa4f67e17014e3a949c9d57bf.lua"; -- South Bronx
}

-- check place
if not Place_ID_With_Matching_Luarmor_ID[game.PlaceId] then
    game.Players.LocalPlayer:Kick("Rangers.rawr | This game is not supported!")
    return
end

-- check key
if not getfenv().script_key then
    game.Players.LocalPlayer:Kick("Rangers.rawr | Key not found!")
    return
end

-- save key
pcall(function()
    writefile("rangers_key.txt", getfenv().script_key)
end)

-- set key
script_key = getfenv().script_key

-- load main script
local url = Place_ID_With_Matching_Luarmor_ID[game.PlaceId]

local success, response = pcall(function()
    return game:HttpGet(url)
end)

if success and response then
    loadstring(response)()
else
    game.Players.LocalPlayer:Kick("Rangers.rawr | Failed to load script!")
end
