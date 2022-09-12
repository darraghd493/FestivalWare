local UI = loadstring(game:HttpGet("https://raw.githubusercontent.com/darraghd493/FestivalWare/master/src/ui/UI.lua"))()
local Window = UI:CreateWindow("Car Crash Test")
local Crasher = Window:CreateTab("Crasher")

local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

Crasher:CreateButton("Destroy Everything", function()
    for i, v in pairs(Workspace:GetChildren()) do
        ReplicatedStorage.DeleteCar:FireServer(v)
    end
end)
