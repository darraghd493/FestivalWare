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

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local POTIONS = {
    "Strength Potion",
    "Growth Potion",
    "Shrink Potion",
    "Jump Potion",
    "Speed Potion"
}

Player:CreateLabel("Ragdoll")
Player:CreateButton("Ragdoll", function()
    Players.LocalPlayer.Character.Humanoid.RagdollRemoteEvent:FireServer(true)
end)
Player:CreateButton("Unragdoll", function()
    Players.LocalPlayer.Character.Humanoid.RagdollRemoteEvent:FireServer(false)
end)
Player:CreateButton("Float", function()
    ReplicatedStorage.RemoteEvents.FloatingCharacterServiceRemoteEvent:FireServer(true)
end)
Player:CreateButton("Un-float", function()
    ReplicatedStorage.RemoteEvents.FloatingCharacterServiceRemoteEvent:FireServer(false)
end)
always_ragdoll = Player:CreateCheckbox("Always Ragdoll", function(toggled)
    if toggled then
        while always_ragdoll:GetState() do
            Players.LocalPlayer.Character.Humanoid.RagdollRemoteEvent:FireServer(true)
            wait()
        end
    end
end)
always_float = Player:CreateCheckbox("Always Float", function(toggled)
    if toggled then
        while always_float:GetState() do
            ReplicatedStorage.RemoteEvents.FloatingCharacterServiceRemoteEvent:FireServer(true)
            wait()
        end
    end
end)
never_ragdoll = Player:CreateCheckbox("Never Ragdoll", function(toggled)
    if toggled then
        while never_ragdoll:GetState() do
            Players.LocalPlayer.Character.Humanoid.RagdollRemoteEvent:FireServer(false)
            wait()
        end
    end
end)
never_float = Player:CreateCheckbox("Never Float", function(toggled)
    if toggled then
        while never_float:GetState() do
            ReplicatedStorage.RemoteEvents.FloatingCharacterServiceRemoteEvent:FireServer(false)
            wait()
        end
    end
end)


Player:CreateLabel("Potions")
auto_potion = Player:CreateCheckbox("Auto Potion", function(toggled)
    if toggled then
        while auto_potion:GetState() do
            for i, POTION in pairs(POTIONS) do
                local target_item = Players.LocalPlayer.Character:FindFirstChild(POTION)
                if target_item ~= nil then
                    target_item.PotionRemoteEvent:FireServer(Players.LocalPlayer.Character.Humanoid)
                end
            end
            wait()
        end
    end
end)

Server:CreateLabel("Clap/Push")
clap_everyone = Server:CreateCheckbox("Clap Everyone", function(toggled)
    if toggled then
        while clap_everyone:GetState() do
            for i, player in pairs(Players:GetChildren()) do
                if player ~= Players.LocalPlayer then
                    if player.Character:FindFirstChild("Head") then
                        ReplicatedStorage.RemoteEvents.ShoveTool:FireServer({
                            player.Character.Humanoid
                        }, Vector3.new(0.3, -1, -1))
                    end
                end
            end
            wait()
        end
    end
end)

super_clap_everyone = Server:CreateCheckbox("Super Clap Everyone", function(toggled)
    if toggled then
        while super_clap_everyone:GetState() do
            for i, player in pairs(Players:GetChildren()) do
                if player ~= Players.LocalPlayer then
                    if player.Character:FindFirstChild("Head") then
                        ReplicatedStorage.RemoteEvent.Doomfist.DoomfistRemote:FireServer(
                            player.Character.Head,
                            Vector3.new(-20, -5, -45)
                        )
                        ReplicatedStorage.RemoteEvents.ShoveTool:FireServer({
                            player.Character.Humanoid
                        }, Vector3.new(-20, -5, -45))
                    end
                end
            end
            wait()
        end
    end
end)

anime_clap_everyone = Server:CreateCheckbox("Anime Clap Everyone", function(toggled)
    if toggled then
        while anime_clap_everyone:GetState() do
            for i, player in pairs(Players:GetChildren()) do
                if player ~= Players.LocalPlayer then
                    if player.Character:FindFirstChild("Head") then
                        ReplicatedStorage.RemoteEvent.Doomfist.DoomfistRemote:FireServer(
                            player.Character.Head,
                            Vector3.new(-math.huge, -math.huge, -math.huge)
                        )
                        ReplicatedStorage.RemoteEvents.ShoveTool:FireServer({
                            player.Character.Humanoid
                        }, Vector3.new(-math.huge, -math.huge, -math.huge))
                    end
                end
            end
            wait()
        end
    end
end)

Server:CreateLabel("Snowball")
snowball_everyone = Server:CreateCheckbox("Snowball Everyone", function(toggled)
    if toggled then
        Window:CreateNotification("FestivalWare", "The usage of snowballs is buggy.")
        while snowball_everyone:GetState() do
            for i, player in pairs(Players:GetChildren()) do
                if player ~= Players.LocalPlayer then
                    if player.Character:FindFirstChild("Head") then
                        ReplicatedStorage.RemoteEvent.Snowball:FireServer(
                            player.Character.Head,
                            Vector3.new(0.08, 0.35, 0.67)
                        )
                    end
                end
            end
            wait()
        end
    end
end)

super_snowball_everyone = Server:CreateCheckbox("Super Snowball Everyone", function(toggled)
    if toggled then
        Window:CreateNotification("FestivalWare", "The usage of snowballs is buggy.")
        while super_snowball_everyone:GetState() do
            for i, player in pairs(Players:GetChildren()) do
                if player ~= Players.LocalPlayer then
                    if player.Character:FindFirstChild("Head") then
                        ReplicatedStorage.RemoteEvent.Snowball:FireServer(
                            player.Character.Head,
                            Vector3.new(20, 20, 20)
                        )
                    end
                end
            end
            wait()
        end
    end
end)

Server:CreateLabel("Abuse")
feedback_spam = Server:CreateCheckbox("Feedback Spam", function(toggled)
    if toggled then
        while feedback_spam:GetState() do
            ReplicatedStorage.RemoteEvent.Feedback:FireServer("FestivalWare on top! #" .. tostring(math.random(1, 1000000)), "PC", "Bad")
            wait()
        end
    end
end)


Settings:CreateButton("Close", function()
    Window:Close()
end)