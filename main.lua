-- [[ LORFY & TPSScript v1 - FULL INTEGRATED ]] --

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local LocalPlayer = Players.LocalPlayer

--// STATES
local ReachEnabled = false
local ReachDistance = 3.2
local FpsBoostEnabled = false
local Ball

--// FUNCTIONS
local function findBall()
    for _, v in ipairs(workspace:GetDescendants()) do
        if v:IsA("Part") and v.Name == "TPS" then Ball = v break end
    end
end
findBall()
workspace.DescendantAdded:Connect(function(v)
    if v:IsA("Part") and v.Name == "TPS" then Ball = v end
end)

-- Reach Loop
RunService.Heartbeat:Connect(function()
    if not ReachEnabled or not Ball then return end
    local char = LocalPlayer.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    local foot = char and (char:FindFirstChild("RightFoot") or char:FindFirstChild("Right Leg"))
    if hrp and foot and (hrp.Position - Ball.Position).Magnitude <= ReachDistance then
        firetouchinterest(foot, Ball, 0)
        firetouchinterest(foot, Ball, 1)
    end
end)

-- FPS Boost Function
local function ApplyFpsBoost()
    settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
    game:GetService("Lighting").GlobalShadows = false
    for _, v in pairs(workspace:GetDescendants()) do
        if v:IsA("BasePart") then
            v.CastShadow = false
            if v.Material ~= Enum.Material.SmoothPlastic then v.Material = Enum.Material.Plastic end
        elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
            v.Enabled = false
        end
    end
end

--// GUI SETUP
local UI = Instance.new("ScreenGui")
UI.Name = "LorfyTPS_Final"
UI.Parent = CoreGui

local Main = Instance.new("Frame")
Main.Size = UDim2.new(0, 420, 0, 230)
Main.Position = UDim2.new(0.5, -210, 0.5, -115)
Main.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
Main.Parent = UI
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 10)

local Inner = Instance.new("Frame")
Inner.Size = UDim2.new(1, -10, 1, -45)
Inner.Position = UDim2.new(0, 5, 0, 40)
Inner.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Inner.BackgroundTransparency = 0.9
Inner.Parent = Main
Instance.new("UICorner", Inner).CornerRadius = UDim.new(0, 8)

-- Logo & Close
local Logo = Instance.new("TextLabel")
Logo.Text = "LORFY & TPSScript v1"
Logo.Size = UDim2.new(0, 200, 0, 35)
Logo.Position = UDim2.new(0, 15, 0, 2)
Logo.TextColor3 = Color3.fromRGB(255, 255, 255)
Logo.BackgroundTransparency = 1
Logo.Font = Enum.Font.GothamBold
Logo.TextSize = 14
Logo.TextXAlignment = Enum.TextXAlignment.Left
Logo.Parent = Main

local CloseBtn = Instance.new("TextButton")
CloseBtn.Text = "X"
CloseBtn.Size = UDim2.new(0, 24, 0, 24)
CloseBtn.Position = UDim2.new(1, -32, 0, 8)
CloseBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.Parent = Main
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 5)
CloseBtn.MouseButton1Click:Connect(function() UI:Destroy() end)

-- Menu & Content
local Menu = Instance.new("Frame")
Menu.Size = UDim2.new(0, 120, 1, -20)
Menu.Position = UDim2.new(0, 10, 0, 10)
Menu.BackgroundTransparency = 1
Menu.Parent = Inner
local Layout = Instance.new("UIListLayout", Menu)
Layout.Padding = UDim.new(0, 6)

local Content = Instance.new("Frame")
Content.Size = UDim2.new(1, -145, 1, -20)
Content.Position = UDim2.new(0, 135, 0, 10)
Content.BackgroundTransparency = 1
Content.Parent = Inner

local function CreateMenuBtn(name)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 35)
    btn.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    btn.Text = name
    btn.TextColor3 = Color3.fromRGB(200, 200, 200)
    btn.Font = Enum.Font.GothamMedium
    btn.Parent = Menu
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    return btn
end

local OwnerBtn = CreateMenuBtn("Owner")
local ReachBtn = CreateMenuBtn("Reach")
local FpsBtn = CreateMenuBtn("Fpsbooster")

-- SECTIONS
OwnerBtn.MouseButton1Click:Connect(function()
    Content:ClearAllChildren()
    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, 0, 1, 0)
    lbl.Text = "Developer : By LORFY\ndiscord - c1x4"
    lbl.TextColor3 = Color3.fromRGB(255, 255, 255)
    lbl.Font = Enum.Font.GothamBold
    lbl.TextSize = 16
    lbl.BackgroundTransparency = 1
    lbl.Parent = Content
end)

-- Siyah Kutu Switch Oluşturucu
local function CreateSwitch(titleText, state, callback)
    local label = Instance.new("TextLabel")
    label.Text = titleText
    label.Size = UDim2.new(1, 0, 0, 20)
    label.TextColor3 = Color3.fromRGB(200, 200, 200)
    label.BackgroundTransparency = 1
    label.Parent = Content

    local sw = Instance.new("TextButton")
    sw.Size = UDim2.new(0, 100, 0, 40)
    sw.Position = UDim2.new(0.5, -50, 0, 30)
    sw.BackgroundColor3 = Color3.fromRGB(5, 5, 5)
    sw.Text = state and "ON" or "OFF"
    sw.TextColor3 = state and Color3.fromRGB(0, 255, 150) or Color3.fromRGB(255, 50, 50)
    sw.Font = Enum.Font.GothamBold
    sw.Parent = Content
    Instance.new("UICorner", sw).CornerRadius = UDim.new(0, 8)
    
    sw.MouseButton1Click:Connect(function()
        state = not state
        sw.Text = state and "ON" or "OFF"
        sw.TextColor3 = state and Color3.fromRGB(0, 255, 150) or Color3.fromRGB(255, 50, 50)
        callback(state)
    end)
    return sw
end

ReachBtn.MouseButton1Click:Connect(function()
    Content:ClearAllChildren()
    CreateSwitch("REACH SYSTEM", ReachEnabled, function(s) ReachEnabled = s end)
    
    -- Slider for Reach
    local sTitle = Instance.new("TextLabel")
    sTitle.Text = "Distance: " .. ReachDistance
    sTitle.Position = UDim2.new(0, 0, 0, 80)
    sTitle.Size = UDim2.new(1, 0, 0, 20)
    sTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    sTitle.BackgroundTransparency = 1
    sTitle.Parent = Content

    local bar = Instance.new("Frame")
    bar.Size = UDim2.new(1, -20, 0, 6)
    bar.Position = UDim2.new(0, 10, 0, 110)
    bar.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    bar.Parent = Content

    local fill = Instance.new("Frame")
    fill.Size = UDim2.new((ReachDistance-1)/9, 0, 1, 0)
    fill.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    fill.Parent = bar

    local dot = Instance.new("TextButton")
    dot.Size = UDim2.new(0, 14, 0, 14)
    dot.Position = UDim2.new(1, -7, 0.5, -7)
    dot.Text = ""
    dot.Parent = fill
    Instance.new("UICorner", dot).CornerRadius = UDim.new(1, 0)

    local drag = false
    dot.MouseButton1Down:Connect(function() drag = true end)
    UserInputService.InputEnded:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 then drag = false end end)
    RunService.RenderStepped:Connect(function()
        if drag then
            local mouse = UserInputService:GetMouseLocation()
            local p = math.clamp((mouse.X - bar.AbsolutePosition.X) / bar.AbsoluteSize.X, 0, 1)
            fill.Size = UDim2.new(p, 0, 1, 0)
            ReachDistance = math.floor(1 + (9 * p))
            sTitle.Text = "Distance: " .. ReachDistance
        end
    end)
end)

FpsBtn.MouseButton1Click:Connect(function()
    Content:ClearAllChildren()
    CreateSwitch("FPS BOOSTER (Dengeli)", FpsBoostEnabled, function(s) 
        FpsBoostEnabled = s 
        if s then ApplyFpsBoost() end
    end)
end)

-- Dragging
local dS, sP
Main.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 then dS = i.Position sP = Main.Position end end)
UserInputService.InputChanged:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseMovement and dS then
    local d = i.Position - dS Main.Position = UDim2.new(sP.X.Scale, sP.X.Offset + d.X, sP.Y.Scale, sP.Y.Offset + d.Y) end end)
UserInputService.InputEnded:Connect(function(i) dS = nil end)
