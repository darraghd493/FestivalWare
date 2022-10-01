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
local ESP = Window:CreateTab("ESP")
local Settings = Window:CreateTab("Settings")

local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local ReplicatedFirst = game:GetService("ReplicatedFirst")
local RunService = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer
local CurrentCamera = Workspace.CurrentCamera

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

Player:CreateLabel("Modifications")
walkspeed = Player:CreateSlider("Walkspeed", 16, 500, 0)
jumppower = Player:CreateSlider("Jump Power", 50, 500, 0)

if LocalPlayer.Character:FindFirstChild("Humanoid") ~= nil then
    walkspeed:SetValue(LocalPlayer.Character.Humanoid.WalkSpeed)
    jumppower:SetValue(LocalPlayer.Character.Humanoid.JumpPower)
end

use_modifications = Player:CreateCheckbox("Use Modifications", function(toggled)
    if toggled then
        while use_modifications:GetState() do
            if LocalPlayer.Character:FindFirstChild("Humanoid") ~= nil then
                LocalPlayer.Character.Humanoid.WalkSpeed = walkspeed:GetValue()
                LocalPlayer.Character.Humanoid.JumpPower = jumppower:GetValue()
            end
            wait()
        end
    end
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
                settings.Settings.ROF = 9e9
            end
            wait()
        end
    end

    for i,v in pairs(GunSettings) do
        local settings = require(v)
        settings.Settings.ROF = 400
    end
end)

Server:CreateLabel("Farming")
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

-- // ESP
ESP:CreateLabel("Box ESP")
local box_esp_toggle = ESP:CreateCheckbox("Box ESP")
local box_esp_team_check = ESP:CreateCheckbox("Team Check")
local box_esp_colour = ESP:CreateColourPicker("Colour", Color3.new(1, 1, 1))
local box_esp_use_team_colour = ESP:CreateCheckbox("Use Team Colour")
local box_esp_outline = ESP:CreateCheckbox("Outline")
local box_esp_outline_colour = ESP:CreateColourPicker("Outline Colour", Color3.new(0, 0, 0))
local box_esp_filled = ESP:CreateCheckbox("Filled")
local box_esp_filled_colour = ESP:CreateColourPicker("Filled colour", Color3.new(1, 1, 1))
local box_esp_filled_use_team_colour = ESP:CreateCheckbox("Use Team Colour")
local box_esp_filled_transparancy = ESP:CreateSlider("Filled Transparancy", 0, 1, 2)

ESP:CreateLabel("Name ESP")
local name_esp_toggle = ESP:CreateCheckbox("Toggled")
local name_esp_team_check = ESP:CreateCheckbox("Team Check")
local name_esp_displayname = ESP:CreateCheckbox("Display Name")
local name_esp_size = ESP:CreateSlider("Size", 8, 24, 1)
local name_esp_colour = ESP:CreateColourPicker("Colour", Color3.new(1, 1, 1))
local name_esp_use_team_colour = ESP:CreateCheckbox("Use Team Colour")
local name_esp_outline = ESP:CreateCheckbox("Outline")
local name_esp_outline_colour = ESP:CreateColourPicker("Outline Colour", Color3.new(0, 0, 0))

ESP:CreateLabel("Line ESP")
local line_esp_toggle = ESP:CreateCheckbox("Toggled")
local line_esp_team_check = ESP:CreateCheckbox("Team Check")
local line_esp_only_on_screen = ESP:CreateCheckbox("Only On Screen")
local line_esp_colour = ESP:CreateColourPicker("Colour", Color3.new(1, 1, 1))
local line_esp_use_team_colour = ESP:CreateCheckbox("Use Team Colour")
local line_esp_outline = ESP:CreateCheckbox("Outline")
local line_esp_outline_colour = ESP:CreateColourPicker("Outline Colour", Color3.new(0, 0, 0))

ESP:CreateLabel("Angle ESP")
local angle_esp_toggle = ESP:CreateCheckbox("Toggled")
local angle_esp_team_check = ESP:CreateCheckbox("Team Check")
local angle_esp_distance = ESP:CreateSlider("Distance", 1, 25, 5)
local angle_esp_colour = ESP:CreateColourPicker("Colour", Color3.new(1, 1, 1))
local angle_esp_use_team_colour = ESP:CreateCheckbox("Use Team Colour")
local angle_esp_outline = ESP:CreateCheckbox("Outline")
local angle_esp_outline_colour = ESP:CreateColourPicker("Outline Colour", Color3.new(0, 0, 0))
local angle_esp_hit_circle_toggle = ESP:CreateCheckbox("Hit Circle")
local angle_esp_hit_circle_size = ESP:CreateSlider("Hit Circle Size", 1, 50, 5)
local angle_esp_hit_circle_colour = ESP:CreateColourPicker("Hit Circle Colour", Color3.new(1, 1, 1))
local angle_esp_hit_circle_use_team_colour = ESP:CreateCheckbox("Use Team Colour")
local angle_esp_hit_circle_outline = ESP:CreateCheckbox("Hit Circle Outline")
local angle_esp_hit_circle_outline_colour = ESP:CreateColourPicker("Hit Circle Outline Colour", Color3.new(0, 0, 0))

local TEXT_HEAD_OFFSET = Vector3.new(0, 2, 0)
local HEAD_OFFSET = Vector3.new(0, 0.5, 0)
local LEG_OFFSET = Vector3.new(0, 3, 0)

function player_esp_check(player)
    return player.Character ~= nil
    and player.Character:FindFirstChild("Humanoid")
    and player.Character:FindFirstChild("HumanoidRootPart")
    and player ~= LocalPlayer
    and player.Character.Humanoid.Health > 0
end

function is_on_team(player)
    if player.Character.Head:WaitForChild("NameTag") then
        return player.Character.Head.NameTag.TextLabel.TextStrokeColor3 == Color3.fromRGB(44, 84, 255)
    end
    return false
end

function get_team_colour(player)
    if is_on_team(player) then
        return Color3.fromRGB(0, 255, 0)
    else
        return Color3.fromRGB(255, 0, 0)
    end
end

function box_esp(player)
    local box_outline = Drawing.new("Square")
    box_outline.Visible = false
    box_outline.Color = Color3.new(0, 0, 0)
    box_outline.Thickness = 3
    box_outline.Transparency = 1
    box_outline.Filled = false

    local box_fill = Drawing.new("Square")
    box_fill.Visible = false
    box_fill.Color = Color3.new(0, 0, 0)
    box_fill.Thickness = 1
    box_fill.Transparency = box_esp_filled_transparancy:GetValue()
    box_fill.Filled = true

    local box = Drawing.new("Square")
    box.Visible = false
    box.Color = Color3.new(1, 1, 1)
    box.Thickness = 1
    box.Transparency = 1
    box.Filled = false

    function handler()
        RunService.RenderStepped:Connect(function(deltaTime)
            if box_esp_toggle:GetState() then
                if player_esp_check(player) then
                    if is_on_team(player) and box_esp_team_check:GetState() then
                        box_outline.Visible = false
                        box.Visible = false
                        box_fill.Visible = false
                        return
                    end

                    local vector, on_screen = CurrentCamera:WorldToViewportPoint(player.Character.HumanoidRootPart.Position + HEAD_OFFSET)

                    local root_part = player.Character:FindFirstChild("HumanoidRootPart")
                    local head = player.Character:FindFirstChild("Head")

                    local root_position, root_on_screen = CurrentCamera:WorldToViewportPoint(root_part.Position)
                    local head_position, head_on_screen = CurrentCamera:WorldToViewportPoint(head.Position + HEAD_OFFSET)
                    local leg_position, leg_on_screen = CurrentCamera:WorldToViewportPoint(root_part.Position - LEG_OFFSET)

                    if head_on_screen then
                        box_outline.Visible = box_esp_outline:GetState()
                        box_fill.Visible = box_esp_filled:GetState()
                        box.Visible = true

                        box_outline.Color = box_esp_outline_colour:GetColour()

                        if box_esp_filled_use_team_colour:GetState() then
                            box_fill.Color = get_team_colour(player)
                        else
                            box_fill.Color = box_esp_filled_colour:GetColour()
                        end

                        if box_esp_use_team_colour:GetState() then
                            box.Color = get_team_colour(player)
                        else
                            box.Color = box_esp_colour:GetColour()
                        end

                        box_outline.Size = Vector2.new(1000/root_position.Z * 2.5, head_position.Y - leg_position.Y)
                        box_fill.Size = Vector2.new(1000/root_position.Z * 2.5, head_position.Y - leg_position.Y)
                        box.Size = Vector2.new(1000/root_position.Z * 2.5, head_position.Y - leg_position.Y)
                        
                        box_outline.Position = Vector2.new(root_position.X - box_outline.Size.X/2, root_position.Y - box_outline.Size.Y/2)
                        box_fill.Position = Vector2.new(root_position.X - box_fill.Size.X/2, root_position.Y - box_fill.Size.Y/2)
                        box.Position = Vector2.new(root_position.X - box.Size.X/2, root_position.Y - box.Size.Y/2)
                        
                        box_fill.Transparency = box_esp_filled_transparancy:GetValue()
                    else
                        box_outline.Visible = false
                        box.Visible = false
                        box_fill.Visible = false
                    end
                else
                    box_outline.Visible = false
                    box.Visible = false
                    box_fill.Visible = false
                end
            else
                box_outline.Visible = false
                box.Visible = false
                box_fill.Visible = false
            end
        end)
    end
    coroutine.wrap(handler)()
end

function name_esp(player)
    local text = Drawing.new("Text")
    text.Visible = false
    text.Color = Color3.new(1, 1, 1)
    text.Center = true
    text.Size = name_esp_size:GetValue()

    function handler()
        RunService.RenderStepped:Connect(function(deltaTime)
            if name_esp_toggle:GetState() then
                if player_esp_check(player) then
                    if is_on_team(player) and name_esp_team_check:GetState() then
                        text.Visible = false
                        return
                    end

                    local vector, on_screen = CurrentCamera:WorldToViewportPoint(player.Character.HumanoidRootPart.Position + HEAD_OFFSET)

                    local head = player.Character:FindFirstChild("Head")
                    local head_position, head_on_screen = CurrentCamera:WorldToViewportPoint(head.Position + TEXT_HEAD_OFFSET)

                    if head_on_screen then
                        text.Visible = true
                        
                        if name_esp_displayname:GetState() then
                            text.Text = player.DisplayName
                        else
                            text.Text = player.Name
                        end

                        text.Position = Vector2.new(head_position.X, head_position.Y)

                        if name_esp_use_team_colour:GetState() then
                            text.Color = get_team_colour(player)
                        else
                            text.Color = name_esp_colour:GetColour()
                        end
                        
                        text.Size = name_esp_size:GetValue()
                        text.Outline = name_esp_outline:GetState()
                        text.OutlineColor = name_esp_outline_colour:GetColour()
                    else
                        text.Visible = false
                    end
                else
                    text.Visible = false
                end
            else
                text.Visible = false
            end
        end)
    end
    coroutine.wrap(handler)()
end

function line_esp(player)
    local line_outline = Drawing.new("Line")
    line_outline.Visible = false
    line_outline.Color = Color3.new(1, 1, 1)
    line_outline.Thickness = 3

    local line = Drawing.new("Line")
    line.Visible = false
    line.Color = Color3.new(1, 1, 1)
    line.Thickness = 1

    function handler()
        RunService.RenderStepped:Connect(function(deltaTime)
            if line_esp_toggle:GetState() then
                if player_esp_check(player) then
                    if is_on_team(player) and line_esp_team_check:GetState() then
                        line_outline.Visible = false
                        line.Visible = false
                        return
                    end

                    local root_part = player.Character:FindFirstChild("HumanoidRootPart")
                    local root_position, root_on_screen = CurrentCamera:WorldToViewportPoint(root_part.Position)

                    if not root_on_screen and line_esp_only_on_screen:GetState() then
                        line_outline.Visible = false
                        line.Visible = false
                    else
                        line_outline.Visible = line_esp_outline:GetState()
                        line.Visible = true
                    end

                    line_outline.Color = line_esp_outline_colour:GetColour()

                    if line_esp_use_team_colour:GetState() then
                        line.Color = get_team_colour(player)
                    else
                        line.Color = line_esp_colour:GetColour()
                    end

                    line_outline.From = Vector2.new(math.clamp(CurrentCamera.ViewportSize.X/2, 0, CurrentCamera.ViewportSize.X), math.clamp(CurrentCamera.ViewportSize.Y/2, 0, CurrentCamera.ViewportSize.Y))
                    line.From = Vector2.new(math.clamp(CurrentCamera.ViewportSize.X/2, 0, CurrentCamera.ViewportSize.X), math.clamp(CurrentCamera.ViewportSize.Y/2, 0, CurrentCamera.ViewportSize.Y))
                    
                    line_outline.To = Vector2.new(math.clamp(root_position.X, 0, CurrentCamera.ViewportSize.X), math.clamp(root_position.Y, 0, CurrentCamera.ViewportSize.Y))
                    line.To = Vector2.new(math.clamp(root_position.X, 0, CurrentCamera.ViewportSize.X), math.clamp(root_position.Y, 0, CurrentCamera.ViewportSize.Y))
                else
                    line_outline.Visible = false
                    line.Visible = false
                end
            else
                line_outline.Visible = false
                line.Visible = false
            end
        end)
    end
    coroutine.wrap(handler)()
end

function angle_esp(player)
    local angle_outline = Drawing.new("Line")
    angle_outline.Visible = false
    angle_outline.Thickness = 3
    angle_outline.Color = Color3.new(0,0,0)

    local angle = Drawing.new("Line")
    angle.Visible = false
    angle.Thickness = 1
    angle.Color = Color3.new(1,1,1)

    local hit_circle_outline = Drawing.new("Circle")
    hit_circle_outline.Visible = false
    hit_circle_outline.NumSides = 24
    hit_circle_outline.Thickness = 3
    hit_circle_outline.Radius = 10
    hit_circle_outline.Color = Color3.new(0,0,0)

    local hit_circle = Drawing.new("Circle")
    hit_circle.Visible = false
    hit_circle.NumSides = 24
    hit_circle.Thickness = 1
    hit_circle.Radius = 10
    hit_circle.Color = Color3.new(1,1,1)

    function handler()
        RunService.RenderStepped:Connect(function(deltaTime)
            if angle_esp_toggle:GetState() then
                if player_esp_check(player) then
                    local root_part = player.Character:FindFirstChild("HumanoidRootPart")
                    local head = player.Character:FindFirstChild("Head")

                    local ray_hit, hit_pos = workspace:FindPartOnRayWithIgnoreList(Ray.new(head.Position, head.CFrame.lookVector * angle_esp_distance:GetValue()), {player.Character, root_part})
                    local viewport_point_hit, hit_on_screen = CurrentCamera:WorldToViewportPoint(hit_pos)
                    local viewport_point_head, head_on_screen = CurrentCamera:WorldToViewportPoint(head.Position)

                    if hit_on_screen then
                        if is_on_team(player) and angle_esp_team_check:GetState() then
                            angle_outline.Visible = false
                            angle.Visible = false
                            hit_circle_outline.Visible = false
                            hit_circle.Visible = false
                            return
                        end

                        angle.Visible = true
                        angle_outline.Visible = angle_esp_outline:GetState()

                        angle_outline.From = Vector2.new(viewport_point_head.X, viewport_point_head.Y)
                        angle.From = Vector2.new(viewport_point_head.X, viewport_point_head.Y)

                        angle_outline.To = Vector2.new(viewport_point_hit.X, viewport_point_hit.Y)
                        angle.To = Vector2.new(viewport_point_hit.X, viewport_point_hit.Y)

                        angle_outline.Color = angle_esp_outline_colour:GetColour()
                        
                        if angle_esp_use_team_colour:GetState() then
                            angle.Color = get_team_colour(player)
                        else
                            angle.Color = angle_esp_colour:GetColour()
                        end

                        hit_circle_outline.Visible = angle_esp_hit_circle_outline:GetState()
                        hit_circle.Visible = angle_esp_hit_circle_toggle:GetState()

                        hit_circle_outline.Position = Vector2.new(viewport_point_hit.X, viewport_point_hit.Y)
                        hit_circle.Position = Vector2.new(viewport_point_hit.X, viewport_point_hit.Y)
                        
                        hit_circle_outline.Radius = angle_esp_hit_circle_size:GetValue()
                        hit_circle.Radius = angle_esp_hit_circle_size:GetValue()

                        hit_circle_outline.Color = angle_esp_hit_circle_outline_colour:GetColour()

                        if angle_esp_hit_circle_use_team_colour:GetState() then
                            hit_circle.Color = get_team_colour(player)
                        else
                            hit_circle.Color = angle_esp_hit_circle_colour:GetColour()
                        end
                    else
                        angle_outline.Visible = false
                        angle.Visible = false
                        hit_circle_outline.Visible = false
                        hit_circle.Visible = false
                    end
                else
                    angle_outline.Visible = false
                    angle.Visible = false
                    hit_circle_outline.Visible = false
                    hit_circle.Visible = false
                end
            else
                angle_outline.Visible = false
                angle.Visible = false
                hit_circle_outline.Visible = false
                hit_circle.Visible = false
            end
        end)
    end
    coroutine.wrap(handler)()
end

for _, player in pairs(Players:GetChildren()) do
    box_esp(player)
    name_esp(player)
    line_esp(player)
    angle_esp(player)
end

Players.PlayerAdded:Connect(function(player)
    box_esp(player)
    name_esp(player)
    line_esp(player)
    angle_esp(player)
end)