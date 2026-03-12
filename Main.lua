local Place_ID_With_Matching_Luarmor_ID = {
    [13643807539] = "https://api.luarmor.net/files/v3/loaders/16fbd70fa4f67e17014e3a949c9d57bf.lua"; -- South Bronx
};

if not Place_ID_With_Matching_Luarmor_ID[game.PlaceId] then
    game.Players.LocalPlayer:Kick("Rangers.rawr | This game is not supported!")
end

if not getfenv().script_key then
    game.Players.LocalPlayer:Kick("Rangers.rawr | Key not found!")
end

script_key = getfenv().script_key

writefile('rangers_key.txt', getfenv().script_key)

loadstring(game:HttpGet(Place_ID_With_Matching_Luarmor_ID[game.PlaceId]))()
