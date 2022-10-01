--[[
    FestivalWare.lua

    A script by darraghd493/doge2018 for harassing games.
    This script is free to use and modify, but please give credit to doge2018.

    This script is a UI library for the FestivalWare script.
    It is not intended to be used on its own.
]]

-- // Randomise the seed
math.randomseed(os.time())

-- // Register services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local GUIService = game:GetService("GuiService")
local CoreGui = game:GetService("CoreGui")

-- // Register local variables
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

-- // Create the library
local library = {}

-- // Utility functions
-- // Returns current mouse location
function GetMouseLocation()
    return UserInputService:GetMouseLocation() - GUIService:GetGuiInset()
end

-- // A better round function
-- // Allows for decimal places
function round(value, decimals)
    local multiplier = 1

    for i=1,decimals do
        multiplier = multiplier * 10
    end

    return math.round(value*multiplier)/multiplier
end

-- // Random string generator
local charset = {}  do -- [0-9a-zA-Z]
    for c = 48, 57  do table.insert(charset, string.char(c)) end
    for c = 65, 90  do table.insert(charset, string.char(c)) end
    for c = 97, 122 do table.insert(charset, string.char(c)) end
end

function random(length)
    if not length or length <= 0 then return '' end
    math.randomseed(os.clock()^5)
    return random(length - 1) .. charset[math.random(1, #charset)]
end

-- // Converts a mouse location to a position within the frame given
function InBounds(frame, mouseX, mouseY)
    if frame == nil then return nil end

	local X, Y = mouseX - frame.AbsolutePosition.X, mouseY - frame.AbsolutePosition.Y
	local MaxX, MaxY = frame.AbsoluteSize.X, frame.AbsoluteSize.Y

	return X/MaxX, Y/MaxY
end

-- // Gives wether a mouse is within a frame
function IsInBounds(frame, mouseX, mouseY)
    if frame == nil then return nil end

    local X, Y = InBounds(frame, mouseX, mouseY)
    return X >= 0 and X <= 1 and Y >= 0 and Y <= 1
end

-- // Dragging functions
-- // Allows for dragging of frames
function draggable(frame, exclude)
    local tweenInfo = TweenInfo.new(0.37245, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)

	local dragging
	local dragStart
	local startPos

    local function update(input)
        local delta = input.Position - dragStart
        local position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    
        local positionTween = TweenService:Create(frame, tweenInfo, {
            Position = position
        })
        positionTween:Play()
    end
    
    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            if IsInBounds(exclude, input.Position.X, input.Position.Y) then
                dragging = false
                return
            end
            
            dragging = true
            dragStart = input.Position
            startPos = frame.Position
    
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) and dragging then
            update(input)
        end
    end)
    
    UserInputService.InputEnded:Connect(function(input)
        if dragging then
            dragging = false
        end
    end)
end

-- // Create UI
function library:CreateWindow(Text : string)
    -- // Create the main frame's library
    local library = {}

    -- // Create the main frame
    local FestivalWare = Instance.new("ScreenGui")
    
    -- // Check if Synapse X is being used
    -- // and if so, protect the frame
    if syn then
        syn.protect_gui(FestivalWare)
    end

    -- // Randomise the name of the GUI
    -- // as a minimal form of protection
    FestivalWare.Name = random(16)

    -- // Complete the GUI behaviour
    FestivalWare.Parent = CoreGui
    FestivalWare.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    -- // Create the base window frame
    local Body = Instance.new("Frame")
    Body.Name = "Body"
    Body.Parent = FestivalWare
    Body.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Body.BackgroundTransparency = 1.000
    Body.BorderSizePixel = 0
    Body.Position = UDim2.new(0.333857447, 0, 0.298545778, 0)
    Body.Size = UDim2.new(0, 700, 0, 400)
    
    local Background = Instance.new("ImageLabel")
    Background.Name = "Background"
    Background.Parent = Body
    Background.BackgroundColor3 = Color3.fromRGB(36, 36, 36)
    Background.Size = UDim2.new(1, 0, 1, 0)
    Background.Image = "http://www.roblox.com/asset/?id=10865271650"

    local Panel = Instance.new("Frame")
    Panel.Name = "Panel"
    Panel.Parent = Body
    Panel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    Panel.BackgroundTransparency = 0.850
    Panel.BorderSizePixel = 0
    Panel.Size = UDim2.new(0, 170, 0, 400)

    local Title = Instance.new("TextLabel")
    Title.Name = "Title"
    Title.Parent = Panel
    Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Title.BackgroundTransparency = 1.000
    Title.BorderSizePixel = 0
    Title.Position = UDim2.new(0.0411764719, 0, 0.0199999996, 0)
    Title.Size = UDim2.new(0, 155, 0, 44)
    Title.Font = Enum.Font.GothamBold
    Title.Text = Text
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextScaled = true
    Title.TextSize = 32.000
    Title.TextWrapped = true

    local Description = Instance.new("TextLabel")
    Description.Name = "Description"
    Description.Parent = Panel
    Description.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Description.BackgroundTransparency = 1.000
    Description.BorderSizePixel = 0
    Description.Position = UDim2.new(0.0411764719, 0, 0.129999995, 0)
    Description.Size = UDim2.new(0, 155, 0, 20)
    Description.Font = Enum.Font.GothamBold
    Description.Text = "Just exploiting."
    Description.TextColor3 = Color3.fromRGB(220, 220, 220)
    Description.TextSize = 16.000
    Description.TextWrapped = true
    Description.TextYAlignment = Enum.TextYAlignment.Top

    local Buttons = Instance.new("ScrollingFrame")
    Buttons.Name = "Buttons"
    Buttons.Parent = Panel
    Buttons.Active = true
    Buttons.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    Buttons.BackgroundTransparency = 0.800
    Buttons.BorderSizePixel = 0
    Buttons.Position = UDim2.new(0.0411764719, 0, 0.197500005, 0)
    Buttons.Size = UDim2.new(0, 155, 0, 267)
    Buttons.ScrollBarThickness = 0
    Buttons.CanvasSize = UDim2.new(0, 0, 0, 0)

    local UIListLayout = Instance.new("UIListLayout")
    UIListLayout.Parent = Buttons
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout.Padding = UDim.new(0, 0)

    local UserInformation = Instance.new("Frame")
    UserInformation.Name = "UserInformation"
    UserInformation.Parent = Panel
    UserInformation.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    UserInformation.BackgroundTransparency = 0.800
    UserInformation.BorderSizePixel = 0
    UserInformation.Position = UDim2.new(0.0411764719, 0, 0.887499988, 0)
    UserInformation.Size = UDim2.new(0, 155, 0, 37)

    local ProfileImage, ProfileIsReady = Players:GetUserThumbnailAsync(LocalPlayer.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420)

    repeat
        warn("Waiting for profile image to load...")
        wait()
    until ProfileIsReady

    local Profile = Instance.new("ImageLabel")
    Profile.Name = "Profile"
    Profile.Parent = UserInformation
    Profile.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    Profile.BackgroundTransparency = 0.600
    Profile.BorderSizePixel = 0
    Profile.Position = UDim2.new(0.045161292, 0, 0.108108111, 0)
    Profile.Size = UDim2.new(0, 28, 0, 28)
    Profile.Image = ProfileImage

    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(1, 0)
    UICorner.Parent = Profile

    local Username = Instance.new("TextLabel")
    Username.Name = "Username"
    Username.Parent = UserInformation
    Username.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Username.BackgroundTransparency = 1.000
    Username.BorderSizePixel = 0
    Username.Position = UDim2.new(0.283870965, 0, 0.108108111, 0)
    Username.Size = UDim2.new(0, 92, 0, 28)
    Username.Font = Enum.Font.Gotham
    Username.Text = LocalPlayer.Name
    Username.TextColor3 = Color3.fromRGB(223, 223, 223)
    Username.TextScaled = true
    Username.TextSize = 14.000
    Username.TextWrapped = true

    local Menu = Instance.new("Frame")
    Menu.Name = "Menu"
    Menu.Parent = Body
    Menu.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    Menu.BackgroundTransparency = 0.800
    Menu.BorderSizePixel = 0
    Menu.Position = UDim2.new(0.254285723, 0, 0.0299999993, 0)
    Menu.Size = UDim2.new(0, 509, 0, 380)

    local UIScale = Instance.new("UIScale")
    UIScale.Parent = Body

    -- // Create the notifications frame
    local Notifications = Instance.new("Frame")
    Notifications.Name = "Notifications"
    Notifications.Parent = FestivalWare
    Notifications.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Notifications.BackgroundTransparency = 1.000
    Notifications.BorderSizePixel = 0
    Notifications.Size = UDim2.new(1, 0, 0.980000019, 0)

    local UIListLayout_1 = Instance.new("UIListLayout")
    UIListLayout_1.Parent = Notifications
    UIListLayout_1.HorizontalAlignment = Enum.HorizontalAlignment.Right
    UIListLayout_1.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout_1.VerticalAlignment = Enum.VerticalAlignment.Bottom
    UIListLayout_1.Padding = UDim.new(0, 5)

    local UIScale_1 = Instance.new("UIScale")
    UIScale_1.Parent = Notifications
    
    -- // Functions
    local index = 0
    function library:CreateTab(TabText: string)
        local firstTab = false
        
        -- // Check if there is a tab already
        if index == 0 then
            firstTab = true
        end
        index = index + 1

        -- // Create the tabs's library
        local library = {}

        -- // Create the tab button    
        local Button = Instance.new("TextButton")
        Button.Name = TabText
        Button.Parent = Buttons
        Button.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Button.BackgroundTransparency = 1.000
        Button.BorderSizePixel = 0
        Button.Size = UDim2.new(0, 155, 0, 31)
        Button.Font = Enum.Font.Gotham
        Button.Text = TabText
        Button.TextColor3 = Color3.fromRGB(211, 211, 211)
        Button.TextSize = 14.000

        -- // Extend the tab area
        Buttons.CanvasSize = Buttons.CanvasSize + UDim2.new(0, 0, 0, 31)

        -- // Create the tab panel
        local Frame = Instance.new("ScrollingFrame")
        Frame.Name = "Frame"
        Frame.Parent = Menu
        Frame.Active = true
        Frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Frame.BackgroundTransparency = 1.000
        Frame.BorderSizePixel = 0
        Frame.CanvasSize = UDim2.new(0, 0, 0, 0)
        Frame.Size = UDim2.new(0, 508, 0, 375)
        Frame.ScrollBarThickness = 0
        Frame.Visible = firstTab

        -- // Create the tab's UIListLayout
        local UIListLayout = Instance.new("UIListLayout")
        UIListLayout.Parent = Frame
        UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
        UIListLayout.Padding = UDim.new(0, 0)

        -- // Create the tab's UIPadding
        local UIPadding = Instance.new("UIPadding")
        UIPadding.Parent = Frame
        UIPadding.PaddingLeft = UDim.new(0, 5)
        UIPadding.PaddingRight = UDim.new(0, 5)
        UIPadding.PaddingTop = UDim.new(0, 5)
        UIPadding.PaddingBottom = UDim.new(0, 5)

        -- // Functions
        -- // Label
        function library:CreateLabel(Text: string)
            -- // Create the elements's library
            local element_library = {}

            -- // Create the label
            local Label = Instance.new("Frame")
            Label.Name = "Label"
            Label.Parent = Frame
            Label.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Label.BackgroundTransparency = 1.000
            Label.BorderSizePixel = 0
            Label.Size = UDim2.new(0, 496, 0, 42)

            local TextLabel = Instance.new("TextLabel")
            TextLabel.Parent = Label
            TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            TextLabel.BackgroundTransparency = 1.000
            TextLabel.BorderSizePixel = 0
            TextLabel.ClipsDescendants = true
            TextLabel.Size = UDim2.new(1, 0, 1, 0)
            TextLabel.Font = Enum.Font.GothamBold
            TextLabel.Text = Text
            TextLabel.TextColor3 = Color3.fromRGB(230, 230, 230)
            TextLabel.TextSize = 32.000

            Frame.CanvasSize = Frame.CanvasSize + UDim2.new(0, 0, 0, 42)

            -- // Functions
            function element_library:SetText(Text: string)
                TextLabel.Text = Text
            end

            function element_library:GetText()
                return TextLabel.Text
            end

            function element_library:Destroy()
                Label:Destroy()
            end

            -- // Return the element's library
            return element_library
        end

        -- // Button
        function library:CreateButton(Text: string, Callback)
            -- // Create the elements's library
            local element_library = {}

            -- // Create the button
            local Button = Instance.new("Frame")
            Button.Name = "Button"
            Button.Parent = Frame
            Button.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Button.BackgroundTransparency = 1.000
            Button.Size = UDim2.new(0, 496, 0, 42)

            local Button_1 = Instance.new("TextButton")
            Button_1.Parent = Button
            Button_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Button_1.BackgroundTransparency = 1.000
            Button_1.BorderSizePixel = 0
            Button_1.ClipsDescendants = true
            Button_1.Size = UDim2.new(1, 0, 1, 0)
            Button_1.Font = Enum.Font.SourceSans
            Button_1.Text = ""
            Button_1.TextColor3 = Color3.fromRGB(0, 0, 0)
            Button_1.TextSize = 14.000

            local Background = Instance.new("Frame")
            Background.Name = "Background"
            Background.Parent = Button_1
            Background.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
            Background.BackgroundTransparency = 0.800
            Background.BorderSizePixel = 0
            Background.Size = UDim2.new(1, 0, 1, 0)

            local Container = Instance.new("Frame")
            Container.Name = "Container"
            Container.Parent = Background
            Container.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
            Container.BackgroundTransparency = 0.800
            Container.BorderSizePixel = 0
            Container.Size = UDim2.new(1, 0, 1, 0)

            local Label = Instance.new("TextLabel")
            Label.Parent = Button_1
            Label.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Label.BackgroundTransparency = 1.000
            Label.BorderSizePixel = 0
            Label.Size = UDim2.new(1, 0, 1, 0)
            Label.Font = Enum.Font.GothamMedium
            Label.Text = Text
            Label.TextColor3 = Color3.fromRGB(236, 236, 236)
            Label.TextSize = 18.000
            Label.TextWrapped = true

            Frame.CanvasSize = Frame.CanvasSize + UDim2.new(0, 0, 0, 42)

            -- // Run the script
            local active = false
            local hovering = false
            
            local circleColour = Color3.fromRGB(53, 53, 53)
            
            local function CreateCircle()
                local circle = Instance.new("Frame")
                local cornerRadius = Instance.new("UICorner")
            
                circle.AnchorPoint = Vector2.new(0.5, 0.5)
                circle.BackgroundColor3 = circleColour
                circle.Size = UDim2.new(0, 0, 0, 0)
            
                cornerRadius.CornerRadius = UDim.new(0.5, 0)
                cornerRadius.Parent = circle
            
                return circle
            end
            
            local function CalculateDistance(pointA, pointB)
                return math.sqrt(((pointB.X - pointA.X) ^ 2) + ((pointB.Y - pointA.Y) ^ 2))
            end
            
            local function OnMouseButton1Down()
                active = true
                
                if Callback ~= nil then
                    Callback()
                end
            
                local buttonAbsoluteSize = Button_1.AbsoluteSize
                local buttonAbsolutePosition = Button_1.AbsolutePosition
            
                local mouseAbsolutePosition = Vector2.new(Mouse.X, Mouse.Y)
                local mouseRelativePosition = (mouseAbsolutePosition - buttonAbsolutePosition)
                
                local circle = CreateCircle()
                circle.BackgroundTransparency = 0.84
                circle.Position = UDim2.new(0, mouseRelativePosition.X, 0, mouseRelativePosition.Y)
                circle.Parent = Container
            
                local topLeft = CalculateDistance(mouseRelativePosition, Vector2.new(0, 0))
                local topRight = CalculateDistance(mouseRelativePosition, Vector2.new(buttonAbsoluteSize.X, 0))
                local bottomRight = CalculateDistance(mouseRelativePosition, buttonAbsoluteSize)
                local bottomLeft = CalculateDistance(mouseRelativePosition, Vector2.new(0, buttonAbsoluteSize.Y))
                local size = math.max(topLeft, topRight, bottomRight, bottomLeft) * 2
            
                local tweenTime = 0.5
                local startedTimestamp
                local completed = false
            
                local expand = TweenService:Create(circle, TweenInfo.new(tweenTime, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                    Size = UDim2.new(0, size, 0, size)
                })
            
                local connection
                connection = RunService.RenderStepped:Connect(function()
                    if not active then
                        connection:Disconnect()
            
                        local defaultTime = tweenTime/3
                        local timeRemaining = tweenTime - (os.time() - startedTimestamp)
                        local newTweenTime = not completed and timeRemaining > defaultTime and timeRemaining or defaultTime
            
                        local fadeOut = TweenService:Create(circle, TweenInfo.new(newTweenTime, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                            BackgroundTransparency = 1
                        })
            
                        fadeOut:Play()
                        fadeOut.Completed:Wait()
                        circle:Destroy()
                    end
                end)
            
                expand:Play()
                startedTimestamp = os.time()
                expand.Completed:Wait()
            
                completed = true
            end
            
            local function OnMouseButton1Up()
                active = false
            end
            
            local function OnMouseEnter()
                hovering = true
            
                local tweenTime = 0.125
                local tweenInfo =
                    TweenInfo.new(tweenTime,
                        Enum.EasingStyle.Linear,
                        Enum.EasingDirection.Out)
            
                local backgroundFadeIn = TweenService:Create(Container, tweenInfo, {
                    BackgroundTransparency = 0.95
                })
                backgroundFadeIn:Play()
                backgroundFadeIn.Completed:Wait()
            
                local backgroundFadeOut = TweenService:Create(Container, tweenInfo, {
                    BackgroundTransparency = 1
                })
                repeat wait() until not hovering
                backgroundFadeOut:Play()
            end
            
            local function OnMouseLeave()
                hovering = false
                active = false
            end
            
            Button_1.MouseButton1Down:Connect(OnMouseButton1Down)
            Button_1.MouseButton1Up:Connect(OnMouseButton1Up)
            
            Button_1.MouseEnter:Connect(OnMouseEnter)
            Button_1.MouseLeave:Connect(OnMouseLeave)

            -- // Functions
            function element_library:Call()
                if Callback ~= nil then
                    Callback()
                end
            end

            function element_library:SetText(Text: string)
                Label.Text = Text
            end

            function element_library:GetText()
                return Label.Text
            end

            function element_library:Destroy()
                Button:Destroy()
            end

            -- // Return the element's library
            return element_library
        end

        -- // Toggle
        function library:CreateCheckbox(Text: string, Callback)
            -- // Create the element's library
            local element_library = {}

            -- // Create the toggle
            local Toggle = Instance.new("Frame")
            Toggle.Name = "Toggle"
            Toggle.Parent = Frame
            Toggle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Toggle.BackgroundTransparency = 1.000
            Toggle.Size = UDim2.new(0, 496, 0, 42)

            local Toggle_1 = Instance.new("TextButton")
            Toggle_1.Parent = Toggle
            Toggle_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Toggle_1.BackgroundTransparency = 1.000
            Toggle_1.BorderSizePixel = 0
            Toggle_1.ClipsDescendants = true
            Toggle_1.Size = UDim2.new(1, 0, 1, 0)
            Toggle_1.Font = Enum.Font.SourceSans
            Toggle_1.Text = ""
            Toggle_1.TextColor3 = Color3.fromRGB(0, 0, 0)
            Toggle_1.TextSize = 14.000

            local Background = Instance.new("Frame")
            Background.Name = "Background"
            Background.Parent = Toggle_1
            Background.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
            Background.BackgroundTransparency = 0.800
            Background.BorderSizePixel = 0
            Background.Size = UDim2.new(1, 0, 1, 0)
            
            local Container = Instance.new("Frame")
            Container.Name = "Container"
            Container.Parent = Background
            Container.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
            Container.BackgroundTransparency = 0.800
            Container.BorderSizePixel = 0
            Container.Size = UDim2.new(1, 0, 1, 0)
            
            local Toggle_2 = Instance.new("Frame")
            Toggle_2.Name = "Checkbox"
            Toggle_2.Parent = Background
            Toggle_2.BackgroundColor3 = Color3.fromRGB(16, 244, 16)
            Toggle_2.BackgroundTransparency = 0.600
            Toggle_2.BorderSizePixel = 0
            Toggle_2.Position = UDim2.new(0.0141129028, 0, 0.238095239, 0)
            Toggle_2.Size = UDim2.new(0.125, 0, 0.5, 0)
            
            local Toggle_3 = Instance.new("TextButton")
            Toggle_3.Parent = Toggle_2
            Toggle_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Toggle_3.BackgroundTransparency = 0.600
            Toggle_3.BorderSizePixel = 0
            Toggle_3.Position = UDim2.new(0.0500000007, 0, -0.075000003, 0)
            Toggle_3.Size = UDim2.new(0.5, 0, 1.20000005, 0)
            Toggle_3.Font = Enum.Font.SourceSans
            Toggle_3.Text = ""
            Toggle_3.TextColor3 = Color3.fromRGB(0, 0, 0)
            Toggle_3.TextSize = 14.000
            
            local Label = Instance.new("TextLabel")
            Label.Parent = Toggle_1
            Label.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Label.BackgroundTransparency = 1.000
            Label.BorderSizePixel = 0
            Label.Size = UDim2.new(1, 0, 1, 0)
            Label.Font = Enum.Font.GothamMedium
            Label.Text = Text
            Label.TextColor3 = Color3.fromRGB(236, 236, 236)
            Label.TextSize = 18.000
            Label.TextWrapped = true

            Frame.CanvasSize = Frame.CanvasSize + UDim2.new(0, 0, 0, 42)

            -- // Run the script
            local active = false
            local hovering = false
            local toggled = false

            local circleColour = Color3.fromRGB(53, 53, 53)
            local red = Color3.fromRGB(244, 16, 16)
            local green = Color3.fromRGB(16, 244, 16)

            local function UpdateCheckbox()
                local position
                local colour
                
                if toggled then
                    position = UDim2.new(0.45, Toggle_2.TextButton.Position.X.Offset, Toggle_2.TextButton.Position.Y.Scale, Toggle_2.TextButton.Position.Y.Offset)
                    colour = green
                else
                    position = UDim2.new(0.05, Toggle_2.TextButton.Position.X.Offset, Toggle_2.TextButton.Position.Y.Scale, Toggle_2.TextButton.Position.Y.Offset)
                    colour = red
                end

                local tweenTime = 0.25
                local checkboxToggle = TweenService:Create(Toggle_2.TextButton, TweenInfo.new(tweenTime, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                    Position = position
                })
                local checkboxColour = TweenService:Create(Toggle_2, TweenInfo.new(tweenTime, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                    BackgroundColor3 = colour
                })
                checkboxToggle:Play()
                checkboxColour:Play()
            end

            local function CreateCircle()
                local circle = Instance.new("Frame")
                local cornerRadius = Instance.new("UICorner")

                circle.AnchorPoint = Vector2.new(0.5, 0.5)
                circle.BackgroundColor3 = circleColour
                circle.Size = UDim2.new(0, 0, 0, 0)

                cornerRadius.CornerRadius = UDim.new(0.5, 0)
                cornerRadius.Parent = circle

                return circle
            end

            local function CalculateDistance(pointA, pointB)
                return math.sqrt(((pointB.X - pointA.X) ^ 2) + ((pointB.Y - pointA.Y) ^ 2))
            end

            local function OnMouseButton1Down()
                active = true
                
                if toggled then
                    toggled = false
                else
                    toggled = true
                end
                
                UpdateCheckbox()
                if Callback ~= nil then
                    Callback(toggled)
                end

                local buttonAbsoluteSize = Toggle_1.AbsoluteSize
                local buttonAbsolutePosition = Toggle_1.AbsolutePosition

                local mouseAbsolutePosition = Vector2.new(Mouse.X, Mouse.Y)
                local mouseRelativePosition = (mouseAbsolutePosition - buttonAbsolutePosition)

                local circle = CreateCircle()
                circle.BackgroundTransparency = 0.84
                circle.Position = UDim2.new(0, mouseRelativePosition.X, 0, mouseRelativePosition.Y)
                circle.Parent = Container

                local topLeft = CalculateDistance(mouseRelativePosition, Vector2.new(0, 0))
                local topRight = CalculateDistance(mouseRelativePosition, Vector2.new(buttonAbsoluteSize.X, 0))
                local bottomRight = CalculateDistance(mouseRelativePosition, buttonAbsoluteSize)
                local bottomLeft = CalculateDistance(mouseRelativePosition, Vector2.new(0, buttonAbsoluteSize.Y))
                local size = math.max(topLeft, topRight, bottomRight, bottomLeft) * 2

                local tweenTime = 0.5
                local startedTimestamp
                local completed = false

                local expand = TweenService:Create(circle, TweenInfo.new(tweenTime, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                    Size = UDim2.new(0, size, 0, size)
                })

                local connection
                connection = RunService.RenderStepped:Connect(function()
                    if not active then
                        connection:Disconnect()

                        local defaultTime = tweenTime/3
                        local timeRemaining = tweenTime - (os.time() - startedTimestamp)
                        local newTweenTime = not completed and timeRemaining > defaultTime and timeRemaining or defaultTime

                        local fadeOut = TweenService:Create(circle, TweenInfo.new(newTweenTime, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                            BackgroundTransparency = 1
                        })

                        fadeOut:Play()
                        fadeOut.Completed:Wait()
                        circle:Destroy()
                    end
                end)

                expand:Play()
                startedTimestamp = os.time()
                expand.Completed:Wait()

                completed = true
            end

            local function OnMouseButton1Up()
                active = false
            end

            local function OnMouseEnter()
                hovering = true

                local tweenTime = 0.125
                local tweenInfo = TweenInfo.new(tweenTime, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)

                local backgroundFadeIn = TweenService:Create(Container, tweenInfo, {
                    BackgroundTransparency = 0.95
                })
                backgroundFadeIn:Play()
                backgroundFadeIn.Completed:Wait()

                local backgroundFadeOut = TweenService:Create(Container, tweenInfo, {
                    BackgroundTransparency = 1
                })
                repeat wait() until not hovering
                backgroundFadeOut:Play()
            end

            local function OnMouseLeave()
                hovering = false
                active = false
            end

            UpdateCheckbox()

            Toggle_2.TextButton.MouseButton1Down:Connect(OnMouseButton1Down)
            Toggle_2.TextButton.MouseButton1Up:Connect(OnMouseButton1Up)
            Toggle_1.MouseButton1Down:Connect(OnMouseButton1Down)
            Toggle_1.MouseButton1Up:Connect(OnMouseButton1Up)

            Toggle_2.TextButton.MouseEnter:Connect(OnMouseEnter)
            Toggle_2.TextButton.MouseLeave:Connect(OnMouseLeave)
            Toggle_1.MouseEnter:Connect(OnMouseEnter)
            Toggle_1.MouseLeave:Connect(OnMouseLeave)

            -- // Functions
            function element_library:Toggle()
                toggled = not toggled
                UpdateCheckbox()
                if Callback ~= nil then
                    Callback(toggled)
                end
            end

            function element_library:SetState(state)
                toggled = state
                UpdateCheckbox()
                if Callback ~= nil then
                    Callback(toggled)
                end
            end

            function element_library:GetState()
                return toggled
            end

            function element_library:SetText(Text: string)
                Label.Text = Text
            end

            function element_library:GetText()
                return Label.Text
            end

            function element_library:Destroy()
                Toggle:Destroy()
            end

            -- // Return the element's library
            return element_library
        end

        -- // Slider
        function library:CreateSlider(Text: string, From: number, To: number, Decimals: number, Callback)
            -- // Create the element's library
            local element_library = {}

            -- // Create the slider
            local Slider = Instance.new("Frame")
            Slider.Name = "Slider"
            Slider.Parent = Frame
            Slider.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Slider.BackgroundTransparency = 1.000
            Slider.Size = UDim2.new(0, 496, 0, 42)

            local Slider_1 = Instance.new("TextButton")
            Slider_1.Parent = Slider
            Slider_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Slider_1.BackgroundTransparency = 1.000
            Slider_1.BorderSizePixel = 0
            Slider_1.ClipsDescendants = true
            Slider_1.Size = UDim2.new(1, 0, 1, 0)
            Slider_1.Font = Enum.Font.SourceSans
            Slider_1.Text = ""
            Slider_1.TextColor3 = Color3.fromRGB(0, 0, 0)
            Slider_1.TextSize = 14.000

            local Background = Instance.new("Frame")
            Background.Name = "Background"
            Background.Parent = Slider_1
            Background.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
            Background.BackgroundTransparency = 0.800
            Background.BorderSizePixel = 0
            Background.Size = UDim2.new(1, 0, 1, 0)

            local Container = Instance.new("Frame")
            Container.Name = "Container"
            Container.Parent = Background
            Container.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
            Container.BackgroundTransparency = 0.800
            Container.BorderSizePixel = 0
            Container.Size = UDim2.new(1, 0, 1, 0)

            local Slider_2 = Instance.new("Frame")
            Slider_2.Name = "Slider"
            Slider_2.Parent = Background
            Slider_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Slider_2.BackgroundTransparency = 1.000
            Slider_2.Position = UDim2.new(0.0500000007, 0, 1, -2)
            Slider_2.Size = UDim2.new(0.899999976, 0, 0, 2)

            local Slider_3 = Instance.new("TextButton")
            Slider_3.Name = "Slider"
            Slider_3.Parent = Slider_2
            Slider_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Slider_3.Size = UDim2.new(1, 0, 1, 0)
            Slider_3.Font = Enum.Font.SourceSans
            Slider_3.Text = ""
            Slider_3.TextColor3 = Color3.fromRGB(0, 0, 0)
            Slider_3.TextSize = 14.000

            local UIGradient = Instance.new("UIGradient")
            UIGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(131, 131, 131)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(236, 236, 236))}
            UIGradient.Parent = Slider_3

            local Label = Instance.new("TextLabel")
            Label.Parent = Slider_1
            Label.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Label.BackgroundTransparency = 1.000
            Label.BorderSizePixel = 0
            Label.Size = UDim2.new(1, 0, 1, 0)
            Label.Font = Enum.Font.GothamMedium
            Label.Text = Text
            Label.TextColor3 = Color3.fromRGB(236, 236, 236)
            Label.TextSize = 18.000
            Label.TextWrapped = true

            local Values = Instance.new("Frame")
            Values.Name = "Values"
            Values.Parent = Slider_1
            Values.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Values.BackgroundTransparency = 1.000
            Values.BorderSizePixel = 0
            Values.Size = UDim2.new(1, 0, 1, 0)

            local Minimum = Instance.new("TextLabel")
            Minimum.Name = "Minimum"
            Minimum.Parent = Values
            Minimum.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Minimum.BackgroundTransparency = 1.000
            Minimum.BorderSizePixel = 0
            Minimum.Position = UDim2.new(0.0487902761, 0, 0.333333343, 0)
            Minimum.Size = UDim2.new(0.106451713, 0, 0.666666687, 0)
            Minimum.Font = Enum.Font.Gotham
            Minimum.Text = "0"
            Minimum.TextColor3 = Color3.fromRGB(236, 236, 236)
            Minimum.TextSize = 18.000
            Minimum.TextWrapped = true
            Minimum.TextXAlignment = Enum.TextXAlignment.Left

            local Current = Instance.new("TextLabel")
            Current.Name = "Current"
            Current.Parent = Values
            Current.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Current.BackgroundTransparency = 1.000
            Current.BorderSizePixel = 0
            Current.Position = UDim2.new(0.843145132, 0, 0.333333343, 0)
            Current.Size = UDim2.new(0.106451713, 0, 0.666666687, 0)
            Current.Font = Enum.Font.Gotham
            Current.Text = ""
            Current.TextColor3 = Color3.fromRGB(236, 236, 236)
            Current.TextSize = 18.000
            Current.TextWrapped = true
            Current.TextXAlignment = Enum.TextXAlignment.Right

            Frame.CanvasSize = Frame.CanvasSize + UDim2.new(0, 0, 0, 42)

            -- // Run the script
            local active = false
            local hovering = false
            
            local from = From
            local to = To
            local percentage = 0.5

            Current.Text = From + ((To - From) * percentage)
            
            local circleColour = Color3.fromRGB(53, 53, 53)
            
            local function UpdateSlider()
                if not active then
                    return
                end
            
                local mousePosition = GetMouseLocation()
                local relativePosition = mousePosition - Slider_3.AbsolutePosition
            
                percentage = math.clamp(relativePosition.X/Slider_1.AbsoluteSize.X, 0, 0.9) * (1/0.9)
                local size = UDim2.new(percentage, Slider_2.Size.X.Offset, Slider_2.Size.Y.Scale, Slider_2.Size.Y.Offset)
            
                local sizeTween = TweenService:Create(Slider_3, TweenInfo.new(0.15, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                    Size = size
                })
                sizeTween:Play()
                
                Slider_1.Values.Current.Text = from + ((to - from) * percentage)
            end
            
            local function CreateCircle()
                local circle = Instance.new("Frame")
                local cornerRadius = Instance.new("UICorner")
            
                circle.AnchorPoint = Vector2.new(0.5, 0.5)
                circle.BackgroundColor3 = circleColour
                circle.Size = UDim2.new(0, 0, 0, 0)
            
                cornerRadius.CornerRadius = UDim.new(0.5, 0)
                cornerRadius.Parent = circle
            
                return circle
            end
            
            local function CalculateDistance(pointA, pointB)
                return math.sqrt(((pointB.X - pointA.X) ^ 2) + ((pointB.Y - pointA.Y) ^ 2))
            end
            
            local function OnMouseButton1Down()
                active = true
                
                local buttonAbsoluteSize = Slider_1.AbsoluteSize
                local buttonAbsolutePosition = Slider_1.AbsolutePosition
            
                local mouseAbsolutePosition = Vector2.new(Mouse.X, Mouse.Y)
                local mouseRelativePosition = (mouseAbsolutePosition - buttonAbsolutePosition)
            
                local circle = CreateCircle()
                circle.BackgroundTransparency = 0.84
                circle.Position = UDim2.new(0, mouseRelativePosition.X, 0, mouseRelativePosition.Y)
                circle.Parent = Container
            
                local topLeft = CalculateDistance(mouseRelativePosition, Vector2.new(0, 0))
                local topRight = CalculateDistance(mouseRelativePosition, Vector2.new(buttonAbsoluteSize.X, 0))
                local bottomRight = CalculateDistance(mouseRelativePosition, buttonAbsoluteSize)
                local bottomLeft = CalculateDistance(mouseRelativePosition, Vector2.new(0, buttonAbsoluteSize.Y))
                local size = math.max(topLeft, topRight, bottomRight, bottomLeft) * 2
            
                local tweenTime = 0.5
                local startedTimestamp
                local completed = false
            
                UpdateSlider()
            
                local expand = TweenService:Create(circle, TweenInfo.new(tweenTime, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                    Size = UDim2.new(0, size, 0, size)
                })
            
                local connection
                connection = RunService.RenderStepped:Connect(function()
                    if not active then
                        connection:Disconnect()
            
                        local defaultTime = tweenTime/3
                        local timeRemaining = tweenTime - (os.time() - startedTimestamp)
                        local newTweenTime = not completed and timeRemaining > defaultTime and timeRemaining or defaultTime
            
                        local fadeOut = TweenService:Create(circle, TweenInfo.new(newTweenTime, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                            BackgroundTransparency = 1
                        })
            
                        fadeOut:Play()
                        fadeOut.Completed:Wait()
                        circle:Destroy()
                    end
                end)
            
                expand:Play()
                startedTimestamp = os.time()
                expand.Completed:Wait()
            
                completed = true
            end
            
            local function OnMouseButton1Up()
                active = false
                UpdateSlider()
            end
            
            local function OnMouseEnter()
                hovering = true
            
                local tweenTime = 0.125
                local tweenInfo = TweenInfo.new(tweenTime, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
            
                UpdateSlider()
                
                local backgroundFadeIn = TweenService:Create(Container, tweenInfo, {
                    BackgroundTransparency = 0.95
                })
                backgroundFadeIn:Play()
                backgroundFadeIn.Completed:Wait()
            
                local backgroundFadeOut = TweenService:Create(Container, tweenInfo, {
                    BackgroundTransparency = 1
                })
                
                repeat
                    wait()
                until not hovering
                backgroundFadeOut:Play()
            end
            
            local function OnMouseMove()
                UpdateSlider()
            end
            
            local function OnMouseLeave()
                if Callback ~= nil then
                    Callback(from + ((to - from) * percentage))
                end

                UpdateSlider()
                hovering = false
                active = false
            end
            
            Slider_1.MouseButton1Down:Connect(OnMouseButton1Down)
            Slider_1.MouseButton1Up:Connect(OnMouseButton1Up)
            
            Slider_1.MouseEnter:Connect(OnMouseEnter)
            
            UserInputService.InputChanged:Connect(OnMouseMove)
            UserInputService.InputEnded:Connect(OnMouseLeave)

            -- // Functions
            function element_library:SetPercentage(Percentage: number)
                percentage = math.clamp(Percentage, 0, 1)
                UpdateSlider()
            end

            function element_library:SetValue(Value: number)
                percentage = math.clamp((Value - from)/(to - from), 0, 1)
                UpdateSlider()
            end

            function element_library:SetFrom(From: number)
                from = From
                percentage = math.clamp((from + ((to - from) * percentage) - from)/(to - from), 0, 1)
                UpdateSlider()
            end

            function element_library:SetTo(To: number)
                to = To
                percentage = math.clamp((from + ((to - from) * percentage) - from)/(to - from), 0, 1)
                UpdateSlider()
            end

            function element_library:GetPercentage()
                return percentage
            end

            function element_library:GetValue()
                return from + ((to - from) * percentage)
            end

            function element_library:GetFrom()
                return from
            end

            function element_library:GetTo()
                return to
            end

            function element_library:Destroy()
                Slider:Destroy()
            end

            -- // Return the element's library
            return element_library
        end

        -- // Dropdown
        function library:CreateDropdown(Text: string, Options, Callback)
            -- // Create the element's library
            local element_library = {}

            -- // Create the dropdown
            local Dropdown = Instance.new("Frame")
            Dropdown.Name = "Dropdown"
            Dropdown.Parent = Frame
            Dropdown.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Dropdown.BackgroundTransparency = 1.000
            Dropdown.Size = UDim2.new(0, 496, 0, 42)
            Dropdown.ZIndex = 2 -- // Make sure it's on top of the other elements

            local Dropdown_1 = Instance.new("TextButton")
            Dropdown_1.Parent = Dropdown
            Dropdown_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Dropdown_1.BackgroundTransparency = 1.000
            Dropdown_1.BorderSizePixel = 0
            Dropdown_1.ClipsDescendants = true
            Dropdown_1.Size = UDim2.new(1, 0, 1, 0)
            Dropdown_1.Font = Enum.Font.SourceSans
            Dropdown_1.Text = ""
            Dropdown_1.TextColor3 = Color3.fromRGB(0, 0, 0)
            Dropdown_1.TextSize = 14.000
            
            local Background = Instance.new("Frame")
            Background.Name = "Background"
            Background.Parent = Dropdown_1
            Background.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
            Background.BackgroundTransparency = 0.800
            Background.BorderSizePixel = 0
            Background.Size = UDim2.new(1, 0, 1, 0)

            local Container = Instance.new("Frame")
            Container.Name = "Container"
            Container.Parent = Background
            Container.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
            Container.BackgroundTransparency = 0.800
            Container.BorderSizePixel = 0
            Container.Size = UDim2.new(1, 0, 1, 0)

            local Label = Instance.new("TextLabel")
            Label.Parent = Dropdown_1
            Label.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Label.BackgroundTransparency = 1.000
            Label.BorderSizePixel = 0
            Label.Size = UDim2.new(1, 0, 1, 0)
            Label.Font = Enum.Font.GothamMedium
            Label.Text = Text
            Label.TextColor3 = Color3.fromRGB(236, 236, 236)
            Label.TextSize = 18.000
            Label.TextWrapped = true

            local Extend = Instance.new("TextButton")
            Extend.Name = "Extend"
            Extend.Parent = Dropdown_1
            Extend.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Extend.BackgroundTransparency = 1.000
            Extend.BorderSizePixel = 0
            Extend.Position = UDim2.new(0.915322602, 0, 0, 0)
            Extend.Size = UDim2.new(0, 42, 0, 42)
            Extend.Font = Enum.Font.Code
            Extend.Text = ">"
            Extend.TextColor3 = Color3.fromRGB(255, 255, 255)
            Extend.TextSize = 20.000

            local Menu = Instance.new("ScrollingFrame")
            Menu.Name = "Menu"
            Menu.Parent = Dropdown
            Menu.Active = true
            Menu.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
            Menu.BackgroundTransparency = 0.400
            Menu.BorderSizePixel = 0
            Menu.Position = UDim2.new(0, 0, 1, 0)
            Menu.Size = UDim2.new(0, 496, 0, 36)
            Menu.ZIndex = 10
            Menu.Selectable = true
            Menu.SelectionOrder = 0
            Menu.CanvasSize = UDim2.new(0, 0, 0, 0)
            Menu.CanvasPosition = Vector2.new(0, 0)
            Menu.ScrollBarThickness = 0

            Frame.CanvasSize = Frame.CanvasSize + UDim2.new(0, 0, 0, 42)

            -- // Create the menu's UIListLayout
            local UIListLayout = Instance.new("UIListLayout")
            UIListLayout.Parent = Menu
            UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
            UIListLayout.Padding = UDim.new(0, 0)

            -- // Create the menu's UIPadding
            local UIPadding = Instance.new("UIPadding")
            UIPadding.Parent = Menu
            UIPadding.PaddingLeft = UDim.new(0, 5)
            UIPadding.PaddingRight = UDim.new(0, 5)
            UIPadding.PaddingTop = UDim.new(0, 0)
            UIPadding.PaddingBottom = UDim.new(0, 0)

            local CurrentOption = Options[1]

            -- // Create the options
            local function create_option(option: string)
                -- // Expand the menu's canvas size
                Menu.CanvasSize = Menu.CanvasSize + UDim2.new(0, 0, 0, 36)
                Menu.Size = Menu.Size + UDim2.new(0, 0, 0, 36)

                -- // Create the option
                local Option = Instance.new("TextButton")
                Option.Name = "Option"
                Option.Parent = Menu
                Option.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Option.BackgroundTransparency = 1.000
                Option.ClipsDescendants = true
                Option.Size = UDim2.new(0, 496, 0, 36)
                Option.Font = Enum.Font.Gotham
                Option.Text = ""
                Option.TextColor3 = Color3.fromRGB(186, 186, 186)
                Option.TextSize = 14.000

                local Background = Instance.new("Frame")
                Background.Name = "Background"
                Background.Parent = Option
                Background.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
                Background.BackgroundTransparency = 0.800
                Background.BorderSizePixel = 0
                Background.Size = UDim2.new(1, 0, 1, 0)

                local Container = Instance.new("Frame")
                Container.Name = "Container"
                Container.Parent = Background
                Container.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
                Container.BackgroundTransparency = 0.800
                Container.BorderSizePixel = 0
                Container.Size = UDim2.new(1, 0, 1, 0)
                
                local Label = Instance.new("TextLabel")
                Label.Parent = Option
                Label.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Label.BackgroundTransparency = 1.000
                Label.BorderSizePixel = 0
                Label.Size = UDim2.new(1, 0, 1, 0)
                Label.Font = Enum.Font.Gotham
                Label.Text = option
                Label.TextColor3 = Color3.fromRGB(236, 236, 236)
                Label.TextSize = 14.000
                Label.TextWrapped = true

                -- // Run the script
                local active = false
                local hovering = false
                
                local circleColour = Color3.fromRGB(53, 53, 53)
                
                local function CreateCircle()
                    local circle = Instance.new("Frame")
                    local cornerRadius = Instance.new("UICorner")
                
                    circle.AnchorPoint = Vector2.new(0.5, 0.5)
                    circle.BackgroundColor3 = circleColour
                    circle.Size = UDim2.new(0, 0, 0, 0)
                
                    cornerRadius.CornerRadius = UDim.new(0.5, 0)
                    cornerRadius.Parent = circle
                
                    return circle
                end
                
                local function CalculateDistance(pointA, pointB)
                    return math.sqrt(((pointB.X - pointA.X) ^ 2) + ((pointB.Y - pointA.Y) ^ 2))
                end
                
                local function OnMouseButton1Down()
                    active = true
                    CurrentOption = option
                    if Callback ~= nil then
                        Callback(option)
                    end

                    for i, v in pairs(Menu:GetChildren()) do
                        v.Label.TextColor3 = Color3.fromRGB(236, 236, 236)
                    end
                    Label.TextColor3 = Color3.fromRGB(16, 214, 16)
                
                    local buttonAbsoluteSize = Option.AbsoluteSize
                    local buttonAbsolutePosition = Option.AbsolutePosition
                
                    local mouseAbsolutePosition = Vector2.new(Mouse.X, Mouse.Y)
                    local mouseRelativePosition = (mouseAbsolutePosition - buttonAbsolutePosition)
                    
                    local circle = CreateCircle()
                    circle.BackgroundTransparency = 0.84
                    circle.Position = UDim2.new(0, mouseRelativePosition.X, 0, mouseRelativePosition.Y)
                    circle.Parent = Container
                
                    local topLeft = CalculateDistance(mouseRelativePosition, Vector2.new(0, 0))
                    local topRight = CalculateDistance(mouseRelativePosition, Vector2.new(buttonAbsoluteSize.X, 0))
                    local bottomRight = CalculateDistance(mouseRelativePosition, buttonAbsoluteSize)
                    local bottomLeft = CalculateDistance(mouseRelativePosition, Vector2.new(0, buttonAbsoluteSize.Y))
                    local size = math.max(topLeft, topRight, bottomRight, bottomLeft) * 2
                
                    local tweenTime = 0.5
                    local startedTimestamp
                    local completed = false
                
                    local expand = TweenService:Create(circle, TweenInfo.new(tweenTime, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                        Size = UDim2.new(0, size, 0, size)
                    })
                
                    local connection
                    connection = RunService.RenderStepped:Connect(function()
                        if not active then
                            connection:Disconnect()
                
                            local defaultTime = tweenTime/3
                            local timeRemaining = tweenTime - (os.time() - startedTimestamp)
                            local newTweenTime = not completed and timeRemaining > defaultTime and timeRemaining or defaultTime
                
                            local fadeOut = TweenService:Create(circle, TweenInfo.new(newTweenTime, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                                BackgroundTransparency = 1
                            })
                
                            fadeOut:Play()
                            fadeOut.Completed:Wait()
                            circle:Destroy()
                        end
                    end)
                
                    expand:Play()
                    startedTimestamp = os.time()
                    expand.Completed:Wait()
                
                    completed = true
                end
                
                local function OnMouseButton1Up()
                    active = false
                end
                
                local function OnMouseEnter()
                    hovering = true
                
                    local tweenTime = 0.125
                    local tweenInfo =
                        TweenInfo.new(tweenTime,
                            Enum.EasingStyle.Linear,
                            Enum.EasingDirection.Out)
                
                    local backgroundFadeIn = TweenService:Create(Container, tweenInfo, {
                        BackgroundTransparency = 0.95
                    })
                    backgroundFadeIn:Play()
                    backgroundFadeIn.Completed:Wait()
                
                    local backgroundFadeOut = TweenService:Create(Container, tweenInfo, {
                        BackgroundTransparency = 1
                    })
                    repeat wait() until not hovering
                    backgroundFadeOut:Play()
                end
                
                local function OnMouseLeave()
                    hovering = false
                    active = false
                end
                
                Option.MouseButton1Down:Connect(OnMouseButton1Down)
                Option.MouseButton1Up:Connect(OnMouseButton1Up)
                
                Option.MouseEnter:Connect(OnMouseEnter)
                Option.MouseLeave:Connect(OnMouseLeave)
            end

            for i, option in ipairs(Options) do
                create_option(option)
            end

            -- // Run the script
            local active = false
            local hovering = false
            local toggled = false
            
            local circleColour = Color3.fromRGB(53, 53, 53)
            local originalDropdownSize = Menu.Size
            Menu.Size = UDim2.new(1, 0, 0, 0)
            Menu.Visible = false
            
            local function UpdateDropdown()
                local extendTween
                local dropdownTween
                
                local tweenInfo = TweenInfo.new(1, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
                
                if toggled then
                    extendTween = TweenService:Create(Extend, tweenInfo, {
                        Rotation = 90
                    })
                    dropdownTween = TweenService:Create(Menu, tweenInfo, {
                        Size = originalDropdownSize
                    })
                else
                    extendTween = TweenService:Create(Extend, tweenInfo, {
                        Rotation = 0
                    })
                    dropdownTween = TweenService:Create(Menu, tweenInfo, {
                        Size = UDim2.new(1, 0, 0, 0)
                    })
                end
                
                extendTween:Play()
                dropdownTween:Play()
            end
            
            local function CreateCircle()
                local circle = Instance.new("Frame")
                local cornerRadius = Instance.new("UICorner")
            
                circle.AnchorPoint = Vector2.new(0.5, 0.5)
                circle.BackgroundColor3 = circleColour
                circle.Size = UDim2.new(0, 0, 0, 0)
            
                cornerRadius.CornerRadius = UDim.new(0.5, 0)
                cornerRadius.Parent = circle
            
                return circle
            end
            
            local function CalculateDistance(pointA, pointB)
                return math.sqrt(((pointB.X - pointA.X) ^ 2) + ((pointB.Y - pointA.Y) ^ 2))
            end
            
            local function OnMouseButton1Down()
                active = true
                
                if toggled then
                    toggled = false
                else
                    toggled = true
                end
                
                UpdateDropdown()
            
                local buttonAbsoluteSize = Dropdown_1.AbsoluteSize
                local buttonAbsolutePosition = Dropdown_1.AbsolutePosition
            
                local mouseAbsolutePosition = Vector2.new(Mouse.X, Mouse.Y)
                local mouseRelativePosition = (mouseAbsolutePosition - buttonAbsolutePosition)
            
                local circle = CreateCircle()
                circle.BackgroundTransparency = 0.84
                circle.Position = UDim2.new(0, mouseRelativePosition.X, 0, mouseRelativePosition.Y)
                circle.Parent = Container
            
                local topLeft = CalculateDistance(mouseRelativePosition, Vector2.new(0, 0))
                local topRight = CalculateDistance(mouseRelativePosition, Vector2.new(buttonAbsoluteSize.X, 0))
                local bottomRight = CalculateDistance(mouseRelativePosition, buttonAbsoluteSize)
                local bottomLeft = CalculateDistance(mouseRelativePosition, Vector2.new(0, buttonAbsoluteSize.Y))
                local size = math.max(topLeft, topRight, bottomRight, bottomLeft) * 2
            
                local tweenTime = 0.5
                local startedTimestamp
                local completed = false
            
                local expand = TweenService:Create(circle, TweenInfo.new(tweenTime, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                    Size = UDim2.new(0, size, 0, size)
                })
            
                local connection
                connection = RunService.RenderStepped:Connect(function()
                    if not active then
                        connection:Disconnect()
            
                        local defaultTime = tweenTime/3
                        local timeRemaining = tweenTime - (os.time() - startedTimestamp)
                        local newTweenTime = not completed and timeRemaining > defaultTime and timeRemaining or defaultTime
            
                        local fadeOut = TweenService:Create(circle, TweenInfo.new(newTweenTime, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                            BackgroundTransparency = 1
                        })
            
                        fadeOut:Play()
                        fadeOut.Completed:Wait()
                        circle:Destroy()
                    end
                end)
            
                expand:Play()
                startedTimestamp = os.time()
                expand.Completed:Wait()
            
                completed = true
            end
            
            local function OnMouseButton1Up()
                active = false
            end
            
            local function OnMouseEnter()
                hovering = true
            
                local tweenTime = 0.125
                local tweenInfo = TweenInfo.new(tweenTime, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
            
                local backgroundFadeIn = TweenService:Create(Container, tweenInfo, {
                    BackgroundTransparency = 0.95
                })
                backgroundFadeIn:Play()
                backgroundFadeIn.Completed:Wait()
            
                local backgroundFadeOut = TweenService:Create(Container, tweenInfo, {
                    BackgroundTransparency = 1
                })
                repeat wait() until not hovering
                backgroundFadeOut:Play()
            end
            
            local function OnMouseLeave()
                hovering = false
                active = false
            end
            
            UpdateDropdown()
            
            Dropdown_1.MouseButton1Down:Connect(OnMouseButton1Down)
            Dropdown_1.MouseButton1Up:Connect(OnMouseButton1Up)
            Extend.MouseButton1Down:Connect(OnMouseButton1Down)
            Extend.MouseButton1Up:Connect(OnMouseButton1Up)
            
            Dropdown_1.MouseEnter:Connect(OnMouseEnter)
            Dropdown_1.MouseLeave:Connect(OnMouseLeave)
            Extend.MouseEnter:Connect(OnMouseEnter)
            Extend.MouseLeave:Connect(OnMouseLeave)

            -- // Functions
            function element_library:AddOption(option)
                create_option(option)
            end

            function element_library:RemoveOption(option)
                for i, v in pairs(Menu:GetChildren()) do
                    if v.Name == option then
                        v:Destroy()
                    end
                end
            end

            function element_library:ClearOptions()
                for i, option in ipairs(Menu:GetChildren()) do
                    if option:IsA("TextButton") then
                        option:Destroy()
                    end
                end
            end

            function element_library:AddOptions(Options)
                for i, option in ipairs(Options) do
                    create_option(option)
                end
            end

            function element_library:GetOptions()
                return Options
            end

            function element_library:GetOption()
                return CurrentOption
            end

            function element_library:SetOption(option)
                for i, v in pairs(Menu:GetChildren()) do
                    if v.Name == option then
                        CurrentOption = option
                        v.Label.TextColor3 = Color3.fromRGB(16, 214, 16)
                    else
                        v.Label.TextColor3 = Color3.fromRGB(236, 236, 236)
                    end
                end
            end

            function element_library:Destroy()
                Dropdown:Destroy()
            end

            -- // Return the element's library
            return element_library
        end

        -- // Colour Picker
        function library:CreateColourPicker(Text: string, Colour: Color3, Callback)
            -- // Create the element's library
            local element_library = {}

            -- // Create the colour picker
            local ColourPicker = Instance.new("Frame")
            ColourPicker.Name = "ColourPicker"
            ColourPicker.Parent = Frame
            ColourPicker.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            ColourPicker.BackgroundTransparency = 1.000
            ColourPicker.Size = UDim2.new(0, 496, 0, 42)
            ColourPicker.ZIndex = 2 -- // Make sure it's on top of the other elements

            local ColourPicker_1 = Instance.new("TextButton")
            ColourPicker_1.Parent = ColourPicker
            ColourPicker_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            ColourPicker_1.BackgroundTransparency = 1.000
            ColourPicker_1.BorderSizePixel = 0
            ColourPicker_1.ClipsDescendants = true
            ColourPicker_1.Size = UDim2.new(1, 0, 1, 0)
            ColourPicker_1.Font = Enum.Font.SourceSans
            ColourPicker_1.Text = ""
            ColourPicker_1.TextColor3 = Color3.fromRGB(0, 0, 0)
            ColourPicker_1.TextSize = 14.000

            local Background = Instance.new("Frame")
            Background.Name = "Background"
            Background.Parent = ColourPicker_1
            Background.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
            Background.BackgroundTransparency = 0.800
            Background.BorderSizePixel = 0
            Background.Size = UDim2.new(1, 0, 1, 0)

            local Container = Instance.new("Frame")
            Container.Name = "Container"
            Container.Parent = Background
            Container.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
            Container.BackgroundTransparency = 0.800
            Container.BorderSizePixel = 0
            Container.Size = UDim2.new(1, 0, 1, 0)

            local Display = Instance.new("TextButton")
            Display.Name = "Display"
            Display.Parent = Background
            Display.BackgroundColor3 = Colour
            Display.BackgroundTransparency = 0.400
            Display.Position = UDim2.new(0.0140000004, 0, 0.238000005, 0)
            Display.Size = UDim2.new(0.125, 0, 0.5, 0)
            Display.Font = Enum.Font.SourceSans
            Display.Text = ""
            Display.TextColor3 = Color3.fromRGB(0, 0, 0)
            Display.TextSize = 14.000

            local Label = Instance.new("TextLabel")
            Label.Parent = ColourPicker_1
            Label.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Label.BackgroundTransparency = 1.000
            Label.BorderSizePixel = 0
            Label.Size = UDim2.new(1, 0, 1, 0)
            Label.Font = Enum.Font.GothamMedium
            Label.Text = Text
            Label.TextColor3 = Color3.fromRGB(236, 236, 236)
            Label.TextSize = 18.000
            Label.TextWrapped = true

            local Menu = Instance.new("Frame")
            Menu.Name = "Menu"
            Menu.Parent = ColourPicker
            Menu.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
            Menu.BackgroundTransparency = 0.650
            Menu.BorderSizePixel = 0
            Menu.ClipsDescendants = true
            Menu.Position = UDim2.new(0, 0, 1.00000072, 0)
            Menu.Selectable = true
            Menu.Size = UDim2.new(0, 496, 0, 135)
            Menu.ZIndex = 9e9 -- // Make sure it's on top of the other elements

            local A = Instance.new("Frame")
            A.Name = "A"
            A.Parent = Menu
            A.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            A.BorderSizePixel = 0
            A.ClipsDescendants = true
            A.Position = UDim2.new(0.900983751, 0, 0.0590001978, 0)
            A.Size = UDim2.new(0, 38, 0, 114)

            local UIGradient = Instance.new("UIGradient")
            UIGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(0, 0, 0))}
            UIGradient.Rotation = 90
            UIGradient.Parent = A

            local Marker = Instance.new("Frame")
            Marker.Name = "Marker"
            Marker.Parent = A
            Marker.AnchorPoint = Vector2.new(0.5, 0.5)
            Marker.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Marker.BorderSizePixel = 0
            Marker.Position = UDim2.new(0.5, 0, 0, 0)
            Marker.Size = UDim2.new(0, 6, 0, 6)

            local UICorner = Instance.new("UICorner")
            UICorner.CornerRadius = UDim.new(1, 0)
            UICorner.Parent = Marker

            local RGB = Instance.new("Frame")
            RGB.Name = "RGB"
            RGB.Parent = Menu
            RGB.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            RGB.BorderSizePixel = 0
            RGB.Position = UDim2.new(0.0199999996, 0, 0.0590000004, 0)
            RGB.Selectable = true
            RGB.Size = UDim2.new(0, 430, 0, 114)

            local Gradient = Instance.new("Frame")
            Gradient.Name = "Gradient"
            Gradient.Parent = RGB
            Gradient.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Gradient.BorderSizePixel = 0
            Gradient.ClipsDescendants = true
            Gradient.Size = UDim2.new(1, 0, 1, 0)

            local UIGradient_2 = Instance.new("UIGradient")
            UIGradient_2.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 0, 0)), ColorSequenceKeypoint.new(0.50, Color3.fromRGB(0, 255, 0)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(0, 0, 255))}
            UIGradient_2.Parent = Gradient

            local Marker_2 = Instance.new("Frame")
            Marker_2.Name = "Marker"
            Marker_2.Parent = Gradient
            Marker_2.AnchorPoint = Vector2.new(0.5, 0.5)
            Marker_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Marker_2.BorderSizePixel = 0
            Marker_2.Size = UDim2.new(0, 6, 0, 6)

            local UICorner_2 = Instance.new("UICorner")
            UICorner_2.CornerRadius = UDim.new(1, 0)
            UICorner_2.Parent = Marker_2

            local Fade = Instance.new("ImageLabel")
            Fade.Name = "Fade"
            Fade.Parent = RGB
            Fade.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Fade.BackgroundTransparency = 1.000
            Fade.BorderSizePixel = 0
            Fade.Size = UDim2.new(1, 0, 1, 0)
            Fade.Image = "http://www.roblox.com/asset/?id=10890905921"
            Fade.ImageTransparency = 0.250

            Frame.CanvasSize = Frame.CanvasSize + UDim2.new(0, 0, 0, 42)

            -- // Run the script
            local active = false
            local hovering = false
            local dragging = false
            local toggled = false

            local circle_colour = Color3.fromRGB(53, 53, 53)
            local colour = Colour
            local target
            local target_marker

            local h, s, v = Colour:ToHSV()
            local colour_data = {
                h, s, v 
            }

            local originalColourPickerSize = Menu.Size
            Menu.Size = UDim2.new(1, 0, 0, 0)
            
            local function SetColour(h, s, v)
                colour_data = {h or colour_data[1], s or colour_data[2], v or colour_data[3]}
                colour = Color3.fromHSV(colour_data[1], colour_data[2], colour_data[3])
            end

            local function UpdateColourPicker()
                local colourPickerTween
                local tweenInfo = TweenInfo.new(1, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
            
                if toggled then
                    colourPickerTween = TweenService:Create(Menu, tweenInfo, {
                        Size = originalColourPickerSize
                    })
                else
                    colourPickerTween = TweenService:Create(Menu, tweenInfo, {
                        Size = UDim2.new(1, 0, 0, 0)
                    })
                end
            
                colourPickerTween:Play()
            end

            local function UpdateColour()
                local X, Y = InBounds(target, Mouse.X, Mouse.Y)
                if InBounds(target, Mouse.X, Mouse.Y) == nil then return end

                X = math.clamp(X, 0, 1)
                Y = math.clamp(Y, 0, 1)
                
                if X and Y then
                    if target == A then
                        SetColour(nil, nil, 1 - Y)
                        target_marker.Position = UDim2.new(0.5, 0, Y, 0)
                    elseif target == RGB then
                        print(X, Y)
                        SetColour(1 - X, 1 - Y)
                        target_marker.Position = UDim2.new(X, 0, Y, 0)
                    end
                end

                local colourTween = TweenService:Create(Display, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                    BackgroundColor3 = colour
                })
                colourTween:Play()

                if Callback ~= nil then
                    Callback(colour)
                end
            end
	
            local function CreateCircle()
                local circle = Instance.new("Frame")
                local cornerRadius = Instance.new("UICorner")
            
                circle.AnchorPoint = Vector2.new(0.5, 0.5)
                circle.BackgroundColor3 = circle_colour
                circle.Size = UDim2.new(0, 0, 0, 0)
            
                cornerRadius.CornerRadius = UDim.new(0.5, 0)
                cornerRadius.Parent = circle
            
                return circle
            end
	
            local function CalculateDistance(pointA, pointB)
                return math.sqrt(((pointB.X - pointA.X) ^ 2) + ((pointB.Y - pointA.Y) ^ 2))
            end

            local function OnMouseButton1Down()
                active = true
            
                if toggled then
                    toggled = false
                else
                    toggled = true
                end
                
                UpdateColourPicker()
                
                local buttonAbsoluteSize = ColourPicker_1.AbsoluteSize
                local buttonAbsolutePosition = ColourPicker_1.AbsolutePosition
            
                local mouseAbsolutePosition = Vector2.new(Mouse.X, Mouse.Y)
                local mouseRelativePosition = (mouseAbsolutePosition - buttonAbsolutePosition)
            
                local circle = CreateCircle()
                circle.BackgroundTransparency = 0.84
                circle.Position = UDim2.new(0, mouseRelativePosition.X, 0, mouseRelativePosition.Y)
                circle.Parent = Container
            
                local topLeft = CalculateDistance(mouseRelativePosition, Vector2.new(0, 0))
                local topRight = CalculateDistance(mouseRelativePosition, Vector2.new(buttonAbsoluteSize.X, 0))
                local bottomRight = CalculateDistance(mouseRelativePosition, buttonAbsoluteSize)
                local bottomLeft = CalculateDistance(mouseRelativePosition, Vector2.new(0, buttonAbsoluteSize.Y))
                local size = math.max(topLeft, topRight, bottomRight, bottomLeft) * 2
            
                local tweenTime = 0.5
                local startedTimestamp
                local completed = false
            
                local expand = TweenService:Create(circle, TweenInfo.new(tweenTime, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                    Size = UDim2.new(0, size, 0, size)
                })
            
                local connection
                connection = RunService.RenderStepped:Connect(function()
                    if not active then
                        connection:Disconnect()
            
                        local defaultTime = tweenTime/3
                        local timeRemaining = tweenTime - (os.time() - startedTimestamp)
                        local newTweenTime = not completed and timeRemaining > defaultTime and timeRemaining or defaultTime
            
                        local fadeOut = TweenService:Create(circle, TweenInfo.new(newTweenTime, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                            BackgroundTransparency = 1
                        })
            
                        fadeOut:Play()
                        fadeOut.Completed:Wait()
                        circle:Destroy()
                    end
                end)
            
                expand:Play()
                startedTimestamp = os.time()
                expand.Completed:Wait()
            
                completed = true
            end
            
            local function OnMouseButton1Up()
                active = false
            end
	
            local function OnMouseBegin(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    local X = Mouse.X
                    local Y = Mouse.Y
            
                    if not IsInBounds(Menu, X, Y) then
                        dragging = false
                        return
                    end
            
                    if not toggled then
                        dragging = false
                        return
                    end
                    
                    if IsInBounds(A, X, Y) then
                        dragging = true
                        target = A
                        target_marker = Marker
                        
                        UpdateColour()
                    elseif IsInBounds(RGB, X, Y) then
                        dragging = true
                        target = RGB
                        target_marker = Marker_2
            
                        UpdateColour()
                    end
                end
            end

            local function OnMouseEnter()
                hovering = true
            
                local tweenTime = 0.125
                local tweenInfo = TweenInfo.new(tweenTime, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
            
                local backgroundFadeIn = TweenService:Create(Container, tweenInfo, {
                    BackgroundTransparency = 0.95
                })
                backgroundFadeIn:Play()
                backgroundFadeIn.Completed:Wait()
            
                local backgroundFadeOut = TweenService:Create(Container, tweenInfo, {
                    BackgroundTransparency = 1
                })
                repeat wait() until not hovering
                backgroundFadeOut:Play()
            end
            
            local function OnMouseMove(input)
                local X = Mouse.X
                local Y = Mouse.Y
                
                if dragging then
                    UpdateColour()
                end
            end
            
            local function OnMouseEnded(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    dragging = false
                    UpdateColourPicker()
                    UpdateColour()
                end
            end
            
            local function OnMouseLeave(input)
                active = false
            end
            
            UpdateColourPicker()
            
            ColourPicker_1.MouseButton1Down:Connect(OnMouseButton1Down)
            Display.MouseButton1Down:Connect(OnMouseButton1Down)
            ColourPicker_1.MouseButton1Up:Connect(OnMouseButton1Up)
            Display.MouseButton1Up:Connect(OnMouseButton1Up)
            
            ColourPicker_1.MouseEnter:Connect(OnMouseEnter)
            Display.MouseEnter:Connect(OnMouseEnter)
            ColourPicker_1.MouseLeave:Connect(OnMouseLeave)
            Display.MouseLeave:Connect(OnMouseLeave)
            
            UserInputService.InputBegan:Connect(OnMouseBegin)
            UserInputService.InputChanged:Connect(OnMouseMove)
            UserInputService.InputEnded:Connect(OnMouseEnded)

            -- // Functions
            function element_library:SetText(Text: string)
                Label.Text = Text
            end

            function element_library:GetText()
                return Label.Text
            end

            function element_library:SetColour(Colour: Color3)
                colour = Colour
                
                local h, s, v = Colour:ToHSV()
                local colour_data = {
                    h, s, v 
                }

                Marker.Position = UDim2.new(colour_data.S, 0, 1 - colour_data.V, 0)
                Marker_2.Position = UDim2.new(colour_data.H, 0, 0, 0)
                UpdateColourPicker()
            end

            function element_library:GetColour()
                return colour
            end

            function element_library:Destroy()
                ColourPicker:Destroy()
            end

            -- // Return the element's library
            return element_library
        end

        -- // TextBox
        function library:CreateTextBox(Text: string, Callback)
            -- // Create the textbox
            local TextBox = Instance.new("Frame")
            TextBox.Name = "Textbox"
            TextBox.Parent = Frame
            TextBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            TextBox.BackgroundTransparency = 1.000
            TextBox.Size = UDim2.new(0, 496, 0, 42)

            local TextBox_1 = Instance.new("TextBox")
            TextBox_1.Parent = TextBox
            TextBox_1.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
            TextBox_1.BackgroundTransparency = 0.800
            TextBox_1.BorderSizePixel = 0
            TextBox_1.Size = UDim2.new(1, 0, 1, 0)
            TextBox_1.Font = Enum.Font.Gotham
            TextBox_1.PlaceholderColor3 = Color3.fromRGB(178, 178, 178)
            TextBox_1.PlaceholderText = Text
            TextBox_1.Text = ""
            TextBox_1.TextColor3 = Color3.fromRGB(195, 195, 195)
            TextBox_1.TextSize = 14.000

            -- // Register the callback
            TextBox_1.FocusLost:Connect(function(EnterPressed)
                if Callback ~= nil then
                    Callback(TextBox_1.Text)
                end
            end)
        end

        -- // Bind the tab button to show
        -- // the tab panel when clicked
        Button.MouseButton1Down:Connect(function()
            -- // Hide all tabs
            for i, child in ipairs(Menu:GetChildren()) do
                child.Visible = false
            end

            -- // Show the tab
            Frame.Visible = true
        end)

        -- // NumberBox
        function library:CreateNumberBox(Text: string, Callback)
            -- // Create the textbox
            local NumberBox = Instance.new("Frame")
            NumberBox.Name = "Textbox"
            NumberBox.Parent = Frame
            NumberBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            NumberBox.BackgroundTransparency = 1.000
            NumberBox.Size = UDim2.new(0, 496, 0, 42)

            local NumberBox_1 = Instance.new("TextBox")
            NumberBox_1.Parent = NumberBox
            NumberBox_1.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
            NumberBox_1.BackgroundTransparency = 0.800
            NumberBox_1.BorderSizePixel = 0
            NumberBox_1.Size = UDim2.new(1, 0, 1, 0)
            NumberBox_1.Font = Enum.Font.Gotham
            NumberBox_1.PlaceholderColor3 = Color3.fromRGB(178, 178, 178)
            NumberBox_1.PlaceholderText = Text
            NumberBox_1.Text = ""
            NumberBox_1.TextColor3 = Color3.fromRGB(195, 195, 195)
            NumberBox_1.TextSize = 14.000

            Frame.CanvasSize = Frame.CanvasSize + UDim2.new(0, 0, 0, 42)

            -- // Script
            local function filter(str: string)
                for i = 1, #str do
                    local c = str:sub(i,i)
                    if not tonumber(c) then
                        str = str:gsub(c, "")
                    end
                end

                return str
            end

            NumberBox_1.InputChanged:Connect(function()
                NumberBox_1.Text = filter(NumberBox_1.Text)
            end)

            -- // Register the callback
            NumberBox_1.FocusLost:Connect(function()
                NumberBox_1.Text = filter(NumberBox_1.Text)
                if Callback ~= nil then
                    Callback(tonumber(NumberBox_1.Text))
                end
            end)
        end

        -- // Bind the tab button to show
        -- // the tab panel when clicked
        Button.MouseButton1Down:Connect(function()
            -- // Hide all tabs
            for i, child in ipairs(Menu:GetChildren()) do
                child.Visible = false
            end

            -- // Show the tab
            Frame.Visible = true
        end)

        --// Return the library
        return library
    end

    function library:CreateNotification(Title: string, Description: string, Length: number, Callback)
        -- // Set the default length to 5 seconds if none is provided
        Length = Length or 5

        -- // Use a coroutine to create the notification
        -- // as to not block the thread
        coroutine.resume(coroutine.create(function()
            -- // Create the notification
            local Notification = Instance.new("Frame")
            Notification.Name = "Notification"
            Notification.Parent = Notifications
            Notification.BackgroundColor3 = Color3.fromRGB(21, 21, 21)
            Notification.BorderSizePixel = 0
            Notification.ClipsDescendants = true
            Notification.Position = UDim2.new(0.861995757, 0, 0.912711024, 0)
            Notification.Size = UDim2.new(0, 285, 0, 100)
            Notification.Style = Enum.FrameStyle.RobloxRound

            local Title_Label = Instance.new("TextLabel")
            Title_Label.Name = "Title"
            Title_Label.Parent = Notification
            Title_Label.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Title_Label.BackgroundTransparency = 1.000
            Title_Label.Position = UDim2.new(0.028070176, 0, 0.0799999982, 0)
            Title_Label.Size = UDim2.new(0, 255, 0, 37)
            Title_Label.Font = Enum.Font.GothamBlack
            Title_Label.Text = Title
            Title_Label.TextColor3 = Color3.fromRGB(255, 255, 255)
            Title_Label.TextScaled = true
            Title_Label.TextSize = 14.000
            Title_Label.TextWrapped = true
            Title_Label.TextXAlignment = Enum.TextXAlignment.Left

            local Description_Label = Instance.new("TextLabel")
            Description_Label.Name = "Description"
            Description_Label.Parent = Notification
            Description_Label.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Description_Label.BackgroundTransparency = 1.000
            Description_Label.Position = UDim2.new(0.0545645729, 0, 0.5, 0)
            Description_Label.Size = UDim2.new(0, 254, 0, 37)
            Description_Label.Font = Enum.Font.GothamMedium
            Description_Label.Text = Description
            Description_Label.TextColor3 = Color3.fromRGB(255, 255, 255)
            Description_Label.TextSize = 16.000
            Description_Label.TextWrapped = true
            Description_Label.TextXAlignment = Enum.TextXAlignment.Left

            -- // Run the script
            local originalNotificationSize = Notification.Size
            Notification.Size = UDim2.new(0, 0, 0, 0)

            local notificationInTween = TweenService:Create(Notification, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Size = originalNotificationSize
            })

            local notificationOutTween = TweenService:Create(Notification, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Size = UDim2.new(0, 0, 0, 100)
            })

            notificationInTween:Play()
            wait(Length)
            notificationOutTween:Play()
            notificationOutTween.Completed:Wait()
            Notification:Destroy()      

            if Callback ~= nil then
                Callback()
            end
        end))
    end

    function library:Close()
        local tweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        local bodyScaleTween = TweenService:Create(UIScale, tweenInfo, {
            Scale = 0
        })
        local notificationsScaleTween = TweenService:Create(UIScale_1, tweenInfo, {
            Scale = 0
        })

        bodyScaleTween:Play()
        notificationsScaleTween:Play()
        bodyScaleTween.Completed:Wait()

        Body.Visible = false
        Notifications.Visible = false
        FestivalWare.Enabled = false

        Body:Destroy()
        Notifications:Destroy()
        FestivalWare:Destroy()
    end

    function library:Hide()
        local tweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        local bodyScaleTween = TweenService:Create(UIScale, tweenInfo, {
            Scale = 0
        })
        bodyScaleTween:Play()
        bodyScaleTween.Completed:Wait()

        Body.Visible = false
    end

    function library:Show()
        Body.Visible = true

        local tweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        local bodyScaleTween = TweenService:Create(UIScale, tweenInfo, {
            Scale = 1
        })
        bodyScaleTween:Play()
        bodyScaleTween.Completed:Wait()
    end

    function library:Toggle()
        if Body.Visible then
            library:Hide()
        else
            library:Show()
        end
    end
    
    UserInputService.InputBegan:Connect(function(input)
        if input.KeyCode == Enum.KeyCode.RightControl then
            library:Toggle()
        end
    end)

    -- // Make the window draggable
    draggable(Body, Menu)

    --// Return the library
    return library
end

return library