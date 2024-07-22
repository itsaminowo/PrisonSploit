-- Create the GUI
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("ScrollingFrame")
local UICorner = Instance.new("UICorner")
local TitleLabel = Instance.new("TextLabel")
local KillAuraButton = Instance.new("TextButton")
local DeactivateKillAuraButton = Instance.new("TextButton")
local SpeedSlider = Instance.new("TextBox")
local JumpPowerSlider = Instance.new("TextBox")
local CloseButton = Instance.new("TextButton")
local CriminalsButton = Instance.new("TextButton")
local GuardsButton = Instance.new("TextButton")
local InmatesButton = Instance.new("TextButton")
local ArrestAllButton = Instance.new("TextButton")
local RemoveDoorsButton = Instance.new("TextButton")
local NoclipButton = Instance.new("TextButton") -- New Noclip Button

-- Properties
ScreenGui.Parent = game.CoreGui

MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(255, 105, 180) -- Dark Pink
MainFrame.BackgroundTransparency = 0.5 -- Transparency level
MainFrame.Position = UDim2.new(0.5, -160, 0.5, -300) -- Centered position
MainFrame.Size = UDim2.new(0, 320, 0, 600) -- Increased size to accommodate new buttons
MainFrame.BorderSizePixel = 2
MainFrame.BorderColor3 = Color3.fromRGB(255, 182, 193) -- Light Pink Border
MainFrame.CanvasSize = UDim2.new(0, 0, 2, 0) -- Adjusted canvas size to fit content
MainFrame.ScrollBarThickness = 4
-- UICorner for MainFrame
local mainFrameCorner = Instance.new("UICorner")
mainFrameCorner.CornerRadius = UDim.new(0, 15)
mainFrameCorner.Parent = MainFrame

-- Title Label Properties
TitleLabel.Name = "TitleLabel"
TitleLabel.Parent = MainFrame
TitleLabel.BackgroundColor3 = Color3.fromRGB(255, 105, 180) -- Dark Pink
TitleLabel.BackgroundTransparency = 0
TitleLabel.BorderColor3 = Color3.fromRGB(255, 182, 193) -- Light Pink 
TitleLabel.Size = UDim2.new(1, 0, 0, 45)
TitleLabel.Position = UDim2.new(0, 0, 0, 0)
TitleLabel.Text = "PrisonSploit :3"
TitleLabel.TextColor3 = Color3.fromRGB(255, 182, 193) -- Light Pink 
TitleLabel.TextScaled = true
TitleLabel.TextStrokeColor3 = Color3.fromRGB(255, 255, 255) -- White text stroke
TitleLabel.TextStrokeTransparency = 0.5

-- Button Properties
local function createButton(name, position, text, callback)
    local button = Instance.new("TextButton")
    button.Name = name
    button.Parent = MainFrame
    button.BackgroundColor3 = Color3.fromRGB(255, 105, 180) -- Dark Pink
    button.Size = UDim2.new(0, 280, 0, 30)
    button.Position = position
    button.Text = text
    button.TextColor3 = Color3.fromRGB(255, 255, 255) -- White text color
    button.TextScaled = true
    local buttonUICorner = Instance.new("UICorner")
    buttonUICorner.CornerRadius = UDim.new(0, 10)
    buttonUICorner.Parent = button
    button.MouseButton1Click:Connect(callback)
    return button
end

-- Input Box Properties
local function createInputBox(name, position, placeholderText)
    local inputBox = Instance.new("TextBox")
    inputBox.Name = name
    inputBox.Parent = MainFrame
    inputBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    inputBox.Size = UDim2.new(0, 280, 0, 30)
    inputBox.Position = position
    inputBox.PlaceholderText = placeholderText
    inputBox.PlaceholderColor3 = Color3.fromRGB(255, 182, 193) -- Light Pink Placeholder Text
    inputBox.TextColor3 = Color3.fromRGB(255, 105, 180) -- Dark Pink Text Color
    inputBox.TextScaled = true
    local inputBoxUICorner = Instance.new("UICorner")
    inputBoxUICorner.CornerRadius = UDim.new(0, 10)
    inputBoxUICorner.Parent = inputBox
    return inputBox
end

-- Centering Buttons
local buttonWidth = 280
local buttonSpacing = 10
local buttonHeight = 30
local verticalPosition = 50 -- Adjusted for title label height

SpeedSlider = createInputBox("SpeedSlider", UDim2.new(0.5, -buttonWidth/2, 0, verticalPosition), "Set Speed")
JumpPowerSlider = createInputBox("JumpPowerSlider", UDim2.new(0.5, -buttonWidth/2, 0, verticalPosition + 40), "Set Jump Power")
verticalPosition = verticalPosition + 80 -- Update vertical position for buttons

KillAuraButton = createButton("KillAuraButton", UDim2.new(0.5, -buttonWidth/2, 0, verticalPosition), "Activate Kill Aura", function()
    if killAuraActive then return end
    killAuraActive = true
    killAuraConnection = game:GetService("RunService").Heartbeat:Connect(function()
        for _, e in pairs(game.Players:GetChildren()) do
            if e ~= game.Players.LocalPlayer then
                local meleeEvent = game:GetService("ReplicatedStorage").meleeEvent
                meleeEvent:FireServer(e)
            end
        end
    end)
end)

DeactivateKillAuraButton = createButton("DeactivateKillAuraButton", UDim2.new(0.5, -buttonWidth/2, 0, verticalPosition + buttonHeight + buttonSpacing), "Deactivate Kill Aura", function()
    if not killAuraActive then return end
    killAuraActive = false
    if killAuraConnection then
        killAuraConnection:Disconnect()
    end
end)

-- Add Team Change Buttons
CriminalsButton = createButton("CriminalsButton", UDim2.new(0.5, -buttonWidth/2, 0, verticalPosition + 2*(buttonHeight + buttonSpacing)), "Become Criminal", function()
    local player = game.Players.LocalPlayer
    local team = game:GetService("Teams"):FindFirstChild("Criminals")
    if team then
        player.Team = team
    end
end)

GuardsButton = createButton("GuardsButton", UDim2.new(0.5, -buttonWidth/2, 0, verticalPosition + 3*(buttonHeight + buttonSpacing)), "Become Guard", function()
    local player = game.Players.LocalPlayer
    local team = game:GetService("Teams"):FindFirstChild("Guards")
    if team then
        player.Team = team
    end
end)

InmatesButton = createButton("InmatesButton", UDim2.new(0.5, -buttonWidth/2, 0, verticalPosition + 4*(buttonHeight + buttonSpacing)), "Become Inmate", function()
    local player = game.Players.LocalPlayer
    local team = game:GetService("Teams"):FindFirstChild("Inmates")
    if team then
        player.Team = team
    end
end)

-- Arrest All Button
ArrestAllButton = createButton("ArrestAllButton", UDim2.new(0.5, -buttonWidth/2, 0, verticalPosition + 5*(buttonHeight + buttonSpacing)), "Arrest All", function()
    for i, v in pairs(game.Teams.Criminals:GetPlayers()) do
        if v.Name ~= game.Players.LocalPlayer.Name then
            local inp = 10
            repeat
                wait()
                inp = inp - 1
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 1)
                game.Workspace.Remote.arrest:InvokeServer(v.Character.HumanoidRootPart)
            until inp == 0
        end
    end
end)

-- Remove Doors Button
RemoveDoorsButton = createButton("RemoveDoorsButton", UDim2.new(0.5, -buttonWidth/2, 0, verticalPosition + 6*(buttonHeight + buttonSpacing)), "Remove Doors", function()
    for _, door in pairs(game:GetService("Workspace"):FindPartsInRegion3(workspace.CurrentCamera.CFrame:PointToWorldSpace(Vector3.new(0, 0, -50)), workspace.CurrentCamera.CFrame:PointToWorldSpace(Vector3.new(100, 100, 50)), nil)) do
        if door.Name == "Door" then
            door:Destroy()
        end
    end
end)

-- Noclip Button
NoclipButton = createButton("NoclipButton", UDim2.new(0.5, -buttonWidth/2, 0, verticalPosition + 7*(buttonHeight + buttonSpacing)), "Noclip Menu", function()
    local Workspace = game:GetService("Workspace")
    local CoreGui = game:GetService("CoreGui")
    local Players = game:GetService("Players")
    local Plr = Players.LocalPlayer
    local Clipon = false

    local Noclip = Instance.new("ScreenGui")
    local BG = Instance.new("Frame")
    local Title = Instance.new("TextLabel")
    local Toggle = Instance.new("TextButton")
    local StatusPF = Instance.new("TextLabel")
    local Status = Instance.new("TextLabel")
    local Credit = Instance.new("TextLabel")

    Noclip.Name = "Noclip"
    Noclip.Parent = CoreGui

    BG.Name = "BG"
    BG.Parent = Noclip
    BG.BackgroundColor3 = Color3.new(1, 0.412, 0.706)
    BG.BackgroundTransparency = 0.5 
    BG.BorderColor3 = Color3.new(1, 1, 1)
    BG.BorderSizePixel = 2
    BG.Position = UDim2.new(0.149479166, 0, 0.82087779, 0)
    BG.Size = UDim2.new(0, 210, 0, 127)
    BG.Active = true
    BG.Draggable = true

    Title.Name = "Title"
    Title.Parent = BG
    Title.BackgroundColor3 = Color3.new(1, 0.412, 0.706)
    Title.BorderColor3 = Color3.new(1, 0.714, 0.757)
    Title.BorderSizePixel = 2
    Title.Size = UDim2.new(0, 210, 0, 33)
    Title.Font = Enum.Font.SourceSans
    Title.Text = "Noclip Menu"
    Title.TextColor3 = Color3.new(1, 0.714, 0.757)
    Title.FontSize = Enum.FontSize.Size32
    Title.TextSize = 30
    Title.TextStrokeColor3 = Color3.new(1, 1, 1)
    Title.TextStrokeTransparency = 0.5

    Toggle.Parent = BG
    Toggle.BackgroundColor3 = Color3.new(1, 0.412, 0.706)
   
    Toggle.BorderColor3 = Color3.new(1, 0.714, 0.757)
    Toggle.BorderSizePixel = 2
    Toggle.Position = UDim2.new(0.152380958, 0, 0.374192119, 0)
    Toggle.Size = UDim2.new(0, 146, 0, 36)
    Toggle.Font = Enum.Font.SourceSans
    Toggle.FontSize = Enum.FontSize.Size28
    Toggle.Text = "Toggle"
    Toggle.TextColor3 = Color3.new(1, 1, 1)
    Toggle.TextSize = 25
    Toggle.TextStrokeColor3 = Color3.new(255,105,180)
    Toggle.TextStrokeTransparency = 1

    StatusPF.Name = "StatusPF"
    StatusPF.Parent = BG
    StatusPF.BackgroundColor3 = Color3.new(1, 1, 1)
    StatusPF.BackgroundTransparency = 1
    StatusPF.Position = UDim2.new(0.314285725, 0, 0.708661377, 0)
    StatusPF.Size = UDim2.new(0, 56, 0, 20)
    StatusPF.Font = Enum.Font.SourceSans
    StatusPF.FontSize = Enum.FontSize.Size24
    StatusPF.Text = "Status:"
    StatusPF.TextColor3 = Color3.new(1, 0.714, 0.757)
    StatusPF.TextSize = 20
    StatusPF.TextStrokeColor3 = Color3.new(0.333333, 0.333333, 0.333333)
    StatusPF.TextStrokeTransparency = 1
    StatusPF.TextWrapped = false

    Status.Name = "Status"
    Status.Parent = BG
    Status.BackgroundColor3 = Color3.new(1, 1, 1)
    Status.BackgroundTransparency = 1
    Status.Position = UDim2.new(0.580952346, 0, 0.708661377, 0)
    Status.Size = UDim2.new(0, 56, 0, 20)
    Status.Font = Enum.Font.SourceSans
    Status.FontSize = Enum.FontSize.Size14
    Status.Text = "Off"
    Status.TextColor3 = Color3.new(255, 182, 193)
    Status.TextScaled = true
    Status.TextSize = 14
    Status.TextStrokeColor3 = Color3.new(0.180392, 0, 0.431373)
    Status.TextWrapped = true
    Status.TextXAlignment = Enum.TextXAlignment.Left

    Credit.Name = "Credit"
    Credit.Parent = BG
    Credit.BackgroundColor3 = Color3.new(1, 1, 1)
    Credit.BackgroundTransparency = 1
    Credit.Position = UDim2.new(0.195238099, 0, 0.866141737, 0)
    Credit.Size = UDim2.new(0, 128, 0, 17)
    Credit.Font = Enum.Font.SourceSans
    Credit.FontSize = Enum.FontSize.Size18
    Credit.Text = "Designed by LM Prod."
    Credit.TextColor3 = Color3.new(1, 0.714, 0.757)
    Credit.TextSize = 16
    Credit.TextStrokeColor3 = Color3.new(1, 0.412, 0.706)
    Credit.TextStrokeTransparency = 1
    Credit.TextWrapped = true

    Toggle.MouseButton1Click:Connect(function()
        if Status.Text == "Off" then
            Clipon = true
            Status.Text = "On"
            Status.TextColor3 = Color3.new(255, 105, 180)
            Stepped = game:GetService("RunService").Stepped:Connect(function()
                if Clipon then
                    for _, v in pairs(Workspace:GetChildren()) do
                        if v.Name == Plr.Name then
                            for _, part in pairs(Workspace[Plr.Name]:GetChildren()) do
                                if part:IsA("BasePart") then
                                    part.CanCollide = false
                                end
                            end
                        end
                    end
                else
                    Stepped:Disconnect()
                end
            end)
        elseif Status.Text == "On" then
            Clipon = false
            Status.Text = "Off"
            Status.TextColor3 = Color3.new(255, 182, 193)
        end
    end)
end)

-- Connect Slider and Button functionality
SpeedSlider.FocusLost:Connect(function()
    local speed = tonumber(SpeedSlider.Text) or 0
    local player = game.Players.LocalPlayer
    if player and player.Character and player.Character:FindFirstChild("Humanoid") then
        player.Character.Humanoid.WalkSpeed = speed
    end
end)

JumpPowerSlider.FocusLost:Connect(function()
    local jumpPower = tonumber(JumpPowerSlider.Text) or 0
    local player = game.Players.LocalPlayer
    if player and player.Character and player.Character:FindFirstChild("Humanoid") then
        player.Character.Humanoid.JumpPower = jumpPower
    end
end)


-- Close Button Properties
CloseButton.Name = "CloseButton"
CloseButton.Parent = MainFrame
CloseButton.BackgroundColor3 = Color3.fromRGB(255, 255, 2555) -- White
CloseButton.Size = UDim2.new(0, 30, 0, 30)
CloseButton.Position = UDim2.new(-25, -45, 0, 0)
CloseButton.Text = "ⓧ"
CloseButton.TextColor3 = Color3.fromRGB(255, 105, 180) -- Dark pink text color
CloseButton.TextScaled = true
local closeButtonUICorner = Instance.new("UICorner")
closeButtonUICorner.CornerRadius = UDim.new(0, 10)
closeButtonUICorner.Parent = CloseButton
CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- Function to make the GUI draggable
local UIS = game:GetService("UserInputService")
local gui = MainFrame
local dragging, dragInput, dragStart, startPos

local function update(input)
    local delta = input.Position - dragStart
    gui.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

gui.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = gui.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

gui.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UIS.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        update(input)
    end
end)

print("PrisonSploit Loaded! :3")
-- Copyright 2024, LM Productions