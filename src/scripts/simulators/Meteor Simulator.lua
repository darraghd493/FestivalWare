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

local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

Player:CreateLabel("Autofarms")
autofarm = Player:CreateCheckbox("Auto Farm", function(toggled)
    if toggled then
        while autofarm:GetState() do
            for i, Object in pairs(Workspace.Objects:GetChildren()) do
                ReplicatedStorage.Communication.RE:FireServer("SelectObject", Object.HitBox)
            end
            wait()
        end
    end
end)

Settings:CreateButton("Close", function()
    Window:Close()
end)