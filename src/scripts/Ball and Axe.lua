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
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Mouse = Players.LocalPlayer:GetMouse()

function disable(signal, name)
    local success = true

    for _, connection in pairs(getconnections(signal)) do
        local disable_success, disable_error = pcall(connection.Disconnect)

        if not disable_success then
            success = false
            error("Failed to disable signal " .. signal.Name .. ": " .. disable_error)
        end
    end

    return success
end

disable(Workspace.playerModels[Players.LocalPlayer.Name].positionUpdate)

Player:CreateLabel("Cheats")
Player:CreateCheckbox("Reach", function()
    for _, part in pairs(Workspace.playerModels:GetDescendants()) do
        if part.Name == Players.LocalPlayer.Name then
            part.ball.spinner.LimitsEnabled = false
        end
    end
end)

Settings:CreateButton("Close", function()
    Window:Close()
end)