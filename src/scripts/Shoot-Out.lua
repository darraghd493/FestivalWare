--[[
    FestivalWare.lua

    A script by darraghd493/doge2018 for harassing games.
    This script is free to use and modify, but please give credit to doge2018.

    This script is for a game and is designed to be used by the loader.
]]

local UI = loadstring(game:HttpGet("https://raw.githubusercontent.com/darraghd493/FestivalWare/master/src/ui/UI.lua"))()
local Window = UI:CreateWindow("FestivalWare")
local Player = Window:CreateTab("Player")
local Guns = Window:CreateTab("Guns")
local Server = Window:CreateTab("Server")
local Misc = Window:CreateTab("Misc")
local Settings = Window:CreateTab("Settings")

local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ReplicatedFirst = game:GetService("ReplicatedFirst")

local AimAssistSettings = require(ReplicatedFirst["_0xS0URC3X"].Shared.AimAssistSettings)
local GunSettings = ReplicatedFirst["_0xS0URC3X"].Shared.WeaponDataManager:GetChildren()

Player:CreateLabel("Cheats")
silent_aim = Player:CreateCheckbox("Silent Aim", function(toggled)
    if toggled then
        while silent_aim:GetState() do
            AimAssistSettings.MaxScreenCoverage = 9e9
            AimAssistSettings.MaxKDR = 9e9
            AimAssistSettings.MaxRange = 9e9
            wait()
        end
    end
    
    AimAssistSettings.MaxScreenCoverage = 0.15
    AimAssistSettings.MaxRange = 200
    AimAssistSettings.MaxKDR = 0.8
end)

Guns:CreateLabel("Mods")
automatic_fire = Guns:CreateCheckbox("Automatic Fire", function(toggled)
    if toggled then
        while automatic_fire:GetState() do
            for i,v in pairs(GunSettings) do
                local settings = require(v)
                settings.Settings.AUTOMATIC = true
            end
            wait()
        end
    end
end)
infinite_ammo = Guns:CreateCheckbox("Infinite Ammo", function(toggled)
    if toggled then
        while infinite_ammo:GetState() do
            for i,v in pairs(GunSettings) do
                local settings = require(v)
                settings.Settings.MAX_AMMO = 9e9
            end
            wait()
        end
    end
    
    for i,v in pairs(GunSettings) do
        local settings = require(v)
        settings.Settings.MAX_AMMO = 32
    end
end)
infinite_damage = Guns:CreateCheckbox("Infinite Damage", function(toggled)
    if toggled then
        while infinite_damage:GetState() do
            for i,v in pairs(GunSettings) do
                local settings = require(v)
                settings.Settings.MAX_DAMAGE = 9e9
            end
            wait()
        end
    end

    for i,v in pairs(GunSettings) do
        local settings = require(v)
        settings.Settings.MAX_DAMAGE = 100
    end
end)
no_recoil = Guns:CreateCheckbox("No Recoil", function(toggled)
    if toggled then
        while no_recoil:GetState() do
            for i,v in pairs(GunSettings) do
                local settings = require(v)
                settings.Settings.RECOIL_STRENGTH = 0
            end
            wait()
        end
    end

    for i,v in pairs(GunSettings) do
        local settings = require(v)
        settings.Settings.RECOIL_STRENGTH = 1.5
    end
end)
no_spread = Guns:CreateCheckbox("No Spread", function(toggled)
    if toggled then
        while no_spread:GetState() do
            for i,v in pairs(GunSettings) do
                local settings = require(v)
                settings.Settings.SPREAD = 0
            end
            wait()
        end
    end

    for i,v in pairs(GunSettings) do
        local settings = require(v)
        settings.Settings.SPREAD = 1
    end
end)
no_reload_time = Guns:CreateCheckbox("No Reload Time", function(toggled)
    if toggled then
        while no_reload_time:GetState() do
            for i,v in pairs(GunSettings) do
                local settings = require(v)
                settings.Settings.RELOAD_TIME = 0
            end
            wait()
        end
    end

    for i,v in pairs(GunSettings) do
        local settings = require(v)
        settings.Settings.RELOAD_TIME = 1
    end
end)
rapid_rate_of_fire = Guns:CreateCheckbox("Rapid Rate of Fire", function(toggled)
    if toggled then
        while rapid_rate_of_fire:GetState() do
            for i,v in pairs(GunSettings) do
                local settings = require(v)
                settings.Settings.FIRE_RATE = 9e9
            end
            wait()
        end
    end

    for i,v in pairs(GunSettings) do
        local settings = require(v)
        settings.Settings.FIRE_RATE = 400
    end
end)

Server:CreateLabel("Farming")
kill_all = Server:CreateCheckbox("Kill All", function(toggled)
    if toggled then
        while kill_all:GetState() do
            ReplicatedStorage.RemoteObjects.Deploy:FireServer()
            for i,v in pairs(Players:GetPlayers()) do
                pcall(function()
                        if v.Name ~= game.Players.LocalPlayer.Name and v.Character and v.Character:FindFirstChild("Head") and v.Character.Head.NameTag.TextLabel.TextColor3 == Color3.fromRGB(255, 0, 0) then
                            Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 3)
                        
                        wait()
                        ReplicatedStorage.RemoteObjects.Stab:FireServer({
                            ["WeaponModel"] = game.Players.LocalPlayer.Character.Knife,
                            ["HitPart"] = v.Character.HumanoidRootPart,
                            ["HitPosition"] = v.Character.HumanoidRootPart.Position,
                            ["HitPlayer"] = v
                        })
                    end
                end)
            end
            wait()
        end
    end
end)
collect_emeralds = Server:CreateCheckbox("Collect Emeralds", function(toggled)
    if toggled then
        while collect_emeralds:GetState() do
            for i,v in pairs(Workspace:GetDescendants()) do
                if v.Name == "Emerald" and v:FindFirstChild("Main", false) then
                    firetouchinterest(Players.LocalPlayer.Character.HumanoidRootPart, v.Main, 0)
                end
            end
            wait()
        end
    end
end)

Settings:CreateButton("Close", function()
    Window:Close()
end)