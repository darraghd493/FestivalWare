--[[
    FestivalWare.lua

    A script by darraghd493/doge2018 for harassing games.
    This script is free to use and modify, but please give credit to doge2018.

    This script is for a game and is designed to be used by the loader.
]]

local UI = loadstring(game:HttpGet("https://raw.githubusercontent.com/darraghd493/FestivalWare/master/src/ui/UI.lua"))()
local Window = UI:CreateWindow("FestivalWare")
local Player = Window:CreateTab("Player")
local Server = Window:CreateTab("Server")
local Settings = Window:CreateTab("Settings")

local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

Player:CreateLabel("Cheats")
Player:CreateCheckbox("Reach", function(toggled)
    for _, part in pairs(Workspace.playerModels:GetDescendants()) do
        if part.Name == Players.LocalPlayer.Name then
            part.ball.spinner.LimitsEnabled = not toggled
        end
    end
end)

Server:CreateLabel("Abuse")
local error_spam = Server:CreateCheckbox("Error Spam", function(toggled) -- Not local - used within callback function
    if toggled then
        while error_spam:GetState() do
            ReplicatedStorage.GameAnalyticsRemoteConfigs:FireServer("error", "", "error")
            wait()
        end
    end
end)

Settings:CreateButton("Close", function()
    Window:Close()
end)