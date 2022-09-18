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

function get_current_plot()
    return ReplicatedStorage.Remotes.GetPlot:InvokeServer(Players.LocalPlayer)
end

Player:CreateLabel("Autofarms")
instant_checkout = Player:CreateCheckbox("Auto Checkout", function(toggled)
    if toggled then
        while instant_checkout:GetState() do
            for i, item in pairs(get_current_plot().Items:GetChildren()) do
                if item:FindFirstChild("HitBox") ~= nil then
                    ReplicatedStorage.Remotes.Checkout:FireServer(item.HitBox)
                end
            end
            wait()
        end
    end
end)

auto_feed = Player:CreateCheckbox("Auto Feed", function(toggled)
    if toggled then
        while auto_feed:GetState() do
            for i, item in pairs(get_current_plot().Items:GetChildren()) do
                if item:FindFirstChild("Pet") ~= nil then
                    ReplicatedStorage.Remotes.FeedPet:InvokeServer(item.Pet.Hitbox, workspace)
                end
            end
            wait()
        end
    end
end)

auto_restock = Player:CreateCheckbox("Auto Restock", function(toggled)
    if toggled then
        while auto_restock:GetState() do
            for i, item in pairs(get_current_plot().Items:GetChildren()) do
                if item:FindFirstChild("HitBox") then      
                    ReplicatedStorage.Remotes.GrabBox:FireServer(get_current_plot().Items.Storage.HitBox)

                    local box = nil
                    for v, part in ipairs(Players.LocalPlayer.Character:GetChildren()) do
                        if string.match(part.Name, "Box") then
                            box = part
                        end
                    end

                    if box ~= nil then
                        ReplicatedStorage.Remotes.Restock:FireServer(item.HitBox, box)
                        ReplicatedStorage.Remotes.RemoveBox:InvokeServer(nil)
                    end
                end
            end
            wait()
        end
    end
end)

auto_quest = Player:CreateCheckbox("Auto Quest", function(toggled)
    if toggled then
        Window:CreateNotification("FestivalWare", "Auto Quest currently only supports cleaning.", 5)
        while auto_quest:GetState() do
            ReplicatedStorage.Remotes.EditQuest:FireServer("Clean", 1)
            wait()
        end
    end
end)

Player:CreateLabel("Leaderboard Stats")
Player:CreateNumberBox("Money", function(value)
    ReplicatedStorage.Remotes.CashChange:FireServer(value)
end)

Settings:CreateButton("Close", function()
    Window:Close()
end)
