-- SEFAv1 & TPSscript Final (Reach Integrated)
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

--// Reach Değişkenleri (GUI ile kontrol edilecek)
local ReachEnabled = false -- Başlangıçta kapalı
local ReachDistance = 4.0   -- Varsayılan orta değer
local BallName = "TPS"
local Ball

-- GUI Tasarımı
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local UIStroke = Instance.new("UIStroke")
local Title = Instance.new("TextLabel")
local ReachMainBtn = Instance.new("TextButton")
local MinusBtn = Instance.new("TextButton")
local PlusBtn = Instance.new("TextButton")
local ReactLabel = Instance.new("TextLabel")
local AbzzyButton = Instance.new("TextButton")
local LorfyButton = Instance.new("TextButton")
local CloseButton = Instance.new("TextButton")

-- GUI Ayarları
ScreenGui.Parent = game.CoreGui
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
MainFrame.BackgroundTransparency = 0.3 -- %70 Opaklık
MainFrame.Position = UDim2.new(0.5, -100, 0.5, -140)
MainFrame.Size = UDim2.new(0, 200, 0, 280)
MainFrame.Active = true
MainFrame.Draggable = true

UIStroke.Parent = MainFrame
UIStroke.Thickness = 2
UIStroke.Color = Color3.fromRGB(0, 0, 0)

-- Başlık
Title.Parent = MainFrame
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Text = "SEFAv1 & TPSscript"
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 18
Title.BackgroundTransparency = 1

-- Reach On/Off Butonu
ReachMainBtn.Parent = MainFrame
ReachMainBtn.Position = UDim2.new(0.1, 0, 0.18, 0)
ReachMainBtn.Size = UDim2.new(0.8, 0, 0, 35)
ReachMainBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
ReachMainBtn.Text = "Reach: OFF"
ReachMainBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ReachMainBtn.Font = Enum.Font.SourceSansBold

-- Plus/Minus Butonları
MinusBtn.Parent = MainFrame
MinusBtn.Position = UDim2.new(0.1, 0, 0.32, 0)
MinusBtn.Size = UDim2.new(0.35, 0, 0, 25)
MinusBtn.Text = "-"
MinusBtn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
MinusBtn.TextColor3 = Color3.fromRGB(255, 255, 255)

PlusBtn.Parent = MainFrame
PlusBtn.Position = UDim2.new(0.55, 0, 0.32, 0)
PlusBtn.Size = UDim2.new(0.35, 0, 0, 25)
PlusBtn.Text = "+"
PlusBtn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
PlusBtn.TextColor3 = Color3.fromRGB(255, 255, 255)

-- Süs Butonları (İşlevsiz)
ReactLabel.Parent = MainFrame
ReactLabel.Position = UDim2.new(0, 0, 0.45, 0)
ReactLabel.Size = UDim2.new(1, 0, 0, 20)
ReactLabel.Text = "React"
ReactLabel.Font = Enum.Font.SourceSansBold
ReactLabel.BackgroundTransparency = 1

AbzzyButton.Parent = MainFrame
AbzzyButton.Position = UDim2.new(0.1, 0, 0.55, 0)
AbzzyButton.Size = UDim2.new(0.8, 0, 0, 25)
AbzzyButton.Text = "Abzzy React"
AbzzyButton.BackgroundColor3 = Color3.fromRGB(230, 230, 230)

LorfyButton.Parent = MainFrame
LorfyButton.Position = UDim2.new(0.1, 0, 0.7, 0)
LorfyButton.Size = UDim2.new(0.8, 0, 0, 25)
LorfyButton.Text = "Lorfy React"
LorfyButton.BackgroundColor3 = Color3.fromRGB(230, 230, 230)

CloseButton.Parent = MainFrame
CloseButton.Position = UDim2.new(0.1, 0, 0.85, 0)
CloseButton.Size = UDim2.new(0.8, 0, 0, 25)
CloseButton.Text = "CLOSE"
CloseButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)

-----------------------------------------------------------
-- REACH MANTIĞI (SENİN KODUNUN ENTEGRESİ)
-----------------------------------------------------------

local function findBall()
    for _, v in ipairs(workspace:GetDescendants()) do
        if v:IsA("Part") and v.Name == BallName then Ball = v break end
    end
end
findBall()

workspace.DescendantAdded:Connect(function(v)
    if v:IsA("Part") and v.Name == BallName then Ball = v end
end)

-- Ana Döngü
RunService.Heartbeat:Connect(function()
    if not ReachEnabled or not Ball then return end
    
    local char = LocalPlayer.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    local foot = char and (char:FindFirstChild("RightFoot") or char:FindFirstChild("Right Leg"))
    
    if hrp and foot then
        local distance = (hrp.Position - Ball.Position).Magnitude
        if distance <= ReachDistance then
            firetouchinterest(foot, Ball, 0)
            firetouchinterest(foot, Ball, 1)
        end
    end
end)

-----------------------------------------------------------
-- GUI KONTROLLERİ
-----------------------------------------------------------

local function UpdateUI()
    ReachMainBtn.Text = "Reach: " .. (ReachEnabled and "ON" or "OFF") .. " (" .. string.format("%.1f", ReachDistance) .. ")"
    ReachMainBtn.BackgroundColor3 = ReachEnabled and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(200, 0, 0)
end

ReachMainBtn.MouseButton1Click:Connect(function()
    ReachEnabled = not ReachEnabled
    UpdateUI()
end)

PlusBtn.MouseButton1Click:Connect(function()
    if ReachDistance < 5.0 then ReachDistance = ReachDistance + 0.5 end
    UpdateUI()
end)

MinusBtn.MouseButton1Click:Connect(function()
    if ReachDistance > 3.0 then ReachDistance = ReachDistance - 0.5 end
    UpdateUI()
end)

-- Basma Efektleri
local function btnEffect(btn)
    btn.MouseButton1Click:Connect(function()
        btn.BackgroundTransparency = 0.6
        task.wait(0.1)
        btn.BackgroundTransparency = 0
    end)
end

btnEffect(AbzzyButton)
btnEffect(LorfyButton)
btnEffect(PlusBtn)
btnEffect(MinusBtn)

CloseButton.MouseButton1Click:Connect(function() ScreenGui:Destroy() ReachEnabled = false end)
