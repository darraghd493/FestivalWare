--[[
    FestivalWare.lua

    A script by darraghd493/doge2018 for harassing games.
    This script is free to use and modify, but please give credit to doge2018.

    This script is for a game and is designed to be used by the loader.
]]

-- game:GetService("ReplicatedStorage").Playerdata.first_spawn:InvokeServer()
-- game:GetService("ReplicatedStorage").Achievements.InteractionKeyPressed:FireServer()
-- game:GetService("ReplicatedStorage").Simchassis.Modules.VehicleSeats.seat_player:InvokeServer(workspace.Vehicles:FindFirstChild("91").Chassis.VehicleSeat)
-- game:GetService("ReplicatedStorage").speed_camera:FireServer("police_camera")
-- game:GetService("ReplicatedStorage").VehicleEvents.VehicleRegen:InvokeServer("91")

local UI = loadstring(game:HttpGet("https://raw.githubusercontent.com/darraghd493/FestivalWare/master/src/ui/UI.lua"))()
local Window = UI:CreateWindow("FestivalWare")
local Vehicle = Window:CreateTab("Vehicle")
local Player = Window:CreateTab("Player")
local Server = Window:CreateTab("Server")
local Teleport = Window:CreateTab("Teleport")
local Misc = Window:CreateTab("Misc")
local Settings = Window:CreateTab("Settings")

local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local StarterGui = game:GetService("StarterGui")

local RagdollHandler = require(ReplicatedStorage.RagdollHandler)

function play_client_sound(soundId: string)
    local sound = Instance.new("Sound")
    sound.SoundId = soundId
    sound.Parent = Players.LocalPlayer.Character
    sound:Play()
end

function identify_car()
    local vehicles = Workspace.Vehicles:GetChildren()
    
    for i=1,#vehicles do
        if vehicles[i]:FindFirstChild("owner") then
            if vehicles[i].owner.Value == Players.LocalPlayer.Name then
                return vehicles[i]
            end
        end
    end
    return nil
end

Player:CreateLabel("Exploits")
Player:CreateButton("Collect Gamepasses", function()
    Players.LocalPlayer.UserId = 1099580
end)

Player:CreateLabel("Leaderboard Stats")
Player:CreateNumberBox("Money", function(value)
    Players.LocalPlayer.leaderstats.Money.Value = value
end)

Player:CreateNumberBox("Miles", function(value)
    Players.LocalPlayer.leaderstats.Miles.Value = value
end)

Player:CreateLabel("Ragdoll")
Player:CreateButton("Ragdoll", function()
    Players.LocalPlayer.Character.Humanoid:ChangeState(11)
	Workspace.CurrentCamera.CameraSubject = Players.LocalPlayer.Character.HumanoidRootPart
	RagdollHandler(Players.LocalPlayer.Character.Humanoid, true)
end)
Player:CreateButton("Unragdoll", function()
    Players.LocalPlayer.Character.Humanoid:ChangeState(11)
	Workspace.CurrentCamera.CameraSubject = Players.LocalPlayer.Character.HumanoidRootPart
	RagdollHandler(Players.LocalPlayer.Character.Humanoid, false)
end)
never_ragdoll = Player:CreateCheckbox("Never Ragdoll", function(toggled)
    if toggled then
        while never_ragdoll:GetState() do
            RagdollHandler(Players.LocalPlayer.Character.Humanoid, false)
            wait()
        end
    end
end)

Player:CreateLabel("Other")
Player:CreateButton("Seat Random Car", function()
    ReplicatedStorage.Achievements.InteractionKeyPressed:FireServer()
    ReplicatedStorage.Simchassis.Modules.VehicleSeats.seat_player:InvokeServer(Workspace.Vehicles:GetChildren()[math.random(1, #Workspace.Vehicles:GetChildren())].Chassis.VehicleSeat)
end)

Server:CreateLabel("Ragdoll")
Server:CreateButton("Ragdoll All", function()
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= Players.LocalPlayer then
            RagdollHandler(player.Character.Humanoid, true)
        end
    end
end)
Server:CreateButton("Unragdoll All", function()
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= Players.LocalPlayer then
            RagdollHandler(player.Character.Humanoid, false)
        end
    end
end)
always_ragdoll_all = Server:CreateCheckbox("Always Ragdoll All", function(toggled)
    if toggled then
        while always_ragdoll_all:GetState() do
            for _, player in pairs(Players:GetPlayers()) do
                if player ~= Players.LocalPlayer then
                    RagdollHandler(player.Character.Humanoid, true)
                end
            end
            wait()
        end
    end
end)
never_ragdoll_all = Server:CreateCheckbox("Never Ragdoll All", function(toggled)
    if toggled then
        while always_ragdoll_all:GetState() do
            for _, player in pairs(Players:GetPlayers()) do
                if player ~= Players.LocalPlayer then
                    RagdollHandler(player.Character.Humanoid, false)
                end
            end
            wait()
        end
    end
end)

Server:CreateLabel("Abuse")
error_spam = Server:CreateCheckbox("Error Spam", function(toggled) -- Not local - used within callback function
    if toggled then
        while error_spam:GetState() do
            ReplicatedStorage.RemoteEvents.GAReportLogErrorsRemoteEvent:FireServer("error#1" .. tostring(math.random(1000, 10000)), Enum.MessageType.MessageError, DateTime.now().UnixTimestampMillis)
            ReplicatedStorage.admin:WaitForChild("send_bug"):FireServer("error#1" .. tostring(math.random(1000, 10000)))
            wait()
        end
    end
end)

Teleport:CreateLabel("Player")
Teleport:CreateButton("Teleport to Car", function()
    local car = identify_car()
    if car == nil then
        Window:CreateNotification("FestivalWare", "You do not have a car spawned!")
    else
        Players.LocalPlayer.Character.HumanoidRootPart.CFrame = car.Chassis.CFrame
        ReplicatedStorage.Simchassis.Modules.VehicleSeats.seat_player:InvokeServer(car.Chassis.VehicleSeat)
    end
end)

Misc:CreateLabel("GUIs")
Misc:CreateCheckbox("Show Wanted", function(toggled)
    Players.LocalPlayer.PlayerGui.CopGui.Frame.Visible = toggled
end)
Misc:CreateCheckbox("Show Store", function(toggled)
    Players.LocalPlayer.PlayerGui.StoreGui.Enabled = toggled
end)
Misc:CreateCheckbox("Hide Information", function(toggled)
    Players.LocalPlayer.PlayerGui.CharacterGui.Enabled = not toggled
end)
Misc:CreateCheckbox("Hide Backpack", function(toggled)
    Players.LocalPlayer.PlayerGui.Backpack.Enabled = not toggled
end)
Misc:CreateCheckbox("Show Exploiter Menu", function(toggled)
    Players.LocalPlayer.PlayerGui.ExploitOr.Enabled = toggled
end)
Misc:CreateCheckbox("Show Death Screen", function(toggled)
    Players.LocalPlayer.PlayerGui.DeathGui.Vignette.Visible = toggled
end)
Misc:CreateCheckbox("Show WIP Screen", function(toggled)
    Players.LocalPlayer.PlayerGui.WIP.Main_UI.Enabled = toggled
end)
Misc:CreateCheckbox("Hide Map", function(toggled)
    Players.LocalPlayer.PlayerGui.MapGui.Enabled = not toggled
end)

Misc:CreateLabel("Local Sounds")
Misc:CreateButton("Play Busted Sound", function()
    play_client_sound("rbxassetid://2567183889")
end)
Misc:CreateNumberBox("Play Sound", function(value)
    play_client_sound("rbxassetid://" .. tostring(value))
end)
Misc:CreateButton("Stop Sounds", function()
    for _, sound in pairs(Players.LocalPlayer.Character:GetChildren()) do
        if sound:IsA("Sound") then
            sound:Stop()
        end
    end
end)

Settings:CreateButton("Close", function()
    Window:Close()
end)