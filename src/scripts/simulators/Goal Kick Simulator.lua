--[[
    FestivalWare.lua

    A script by darraghd493/doge2018 for harassing games.
    This script is free to use and modify, but please give credit to doge2018.

    This script is for a game and is designed to be used by the loader.
]]

local UI = loadstring(game:HttpGet("https://raw.githubusercontent.com/darraghd493/FestivalWare/master/src/ui/UI.lua"))()
local Window = UI:CreateWindow("FestivalWare")
local Player = Window:CreateTab("Player")
local Settings = Window:CreateTab("Settings")

local ReplicatedStorage = game:GetService("ReplicatedStorage")

Player:CreateLabel("Autofarms")
autokick = Player:CreateCheckbox("Auto Kick", function(toggled)
    if toggled then
        while autokick:GetState() do
            ReplicatedStorage.Remote.RemoteFunction:InvokeServer("Throw", 100)
            wait()
        end
    end
end)
autopack = Player:CreateCheckbox("Auto Pack", function(toggled)
    if toggled then
        while autopack:GetState() do
            local chests = workspace.ChestStands:GetChildren()

            for i, chest in pairs(chests) do
                ReplicatedStorage.Remote.RemoteFunction:InvokeServer("PromptPurchaseChest", chest)
            end
            wait()
        end
    end
end)

Settings:CreateButton("Close", function()
    Window:Close()
end)