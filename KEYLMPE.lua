local Players = game:GetService("Players")
local player = Players.LocalPlayer
local TweenService = game:GetService("TweenService")

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "LMPEKeyAuth"
ScreenGui.Parent = player.PlayerGui

local Background = Instance.new("Frame")
Background.Size = UDim2.new(1, 0, 1, 0)
Background.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Background.BackgroundTransparency = 0.3
Background.BorderSizePixel = 0
Background.Parent = ScreenGui

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 400, 0, 300)
MainFrame.Position = UDim2.new(0.5, -200, 0.5, -150)
MainFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
MainFrame.BackgroundTransparency = 0.2
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 60)
Title.Position = UDim2.new(0, 0, 0, 0)
Title.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Title.BackgroundTransparency = 0.2
Title.Text = "LMPE 脚本中心 - 身份验证"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 20
Title.Font = Enum.Font.GothamBold
Title.Parent = MainFrame

local InfoLabel = Instance.new("TextLabel")
InfoLabel.Size = UDim2.new(1, -40, 0, 40)
InfoLabel.Position = UDim2.new(0, 20, 0, 70)
InfoLabel.BackgroundTransparency = 1
InfoLabel.Text = "请输入您的卡密以使用LMPE脚本中心"
InfoLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
InfoLabel.TextSize = 14
InfoLabel.Font = Enum.Font.Gotham
InfoLabel.Parent = MainFrame

local KeyInput = Instance.new("TextBox")
KeyInput.Size = UDim2.new(1, -40, 0, 40)
KeyInput.Position = UDim2.new(0, 20, 0, 120)
KeyInput.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
KeyInput.BackgroundTransparency = 0.1
KeyInput.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyInput.TextSize = 16
KeyInput.PlaceholderText = "在此输入卡密..."
KeyInput.PlaceholderColor3 = Color3.fromRGB(200, 200, 200)
KeyInput.ClearTextOnFocus = false
KeyInput.Parent = MainFrame

local VerifyButton = Instance.new("TextButton")
VerifyButton.Size = UDim2.new(1, -40, 0, 40)
VerifyButton.Position = UDim2.new(0, 20, 0, 180)
VerifyButton.BackgroundColor3 = Color3.fromRGB(76, 175, 80)
VerifyButton.BackgroundTransparency = 0.1
VerifyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
VerifyButton.Text = "🔑 验证卡密"
VerifyButton.TextSize = 16
VerifyButton.Font = Enum.Font.GothamBold
VerifyButton.Parent = MainFrame

local StatusLabel = Instance.new("TextLabel")
StatusLabel.Size = UDim2.new(1, -40, 0, 30)
StatusLabel.Position = UDim2.new(0, 20, 0, 235)
StatusLabel.BackgroundTransparency = 1
StatusLabel.Text = "状态: 等待输入"
StatusLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
StatusLabel.TextSize = 14
StatusLabel.Font = Enum.Font.Gotham
StatusLabel.Parent = MainFrame

VerifyButton.MouseButton1Click:Connect(function()
    local key = KeyInput.Text
    
    if key == "" then
        StatusLabel.Text = "状态: ❌ 请输入卡密"
        StatusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
        
        local tweenInfo = TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 5, true)
        local tween = TweenService:Create(KeyInput, tweenInfo, {Position = UDim2.new(0, 15, 0, 120)})
        tween:Play()
        return
    end
    
    if key == "LMPE114514" then
        StatusLabel.Text = "状态: ✅ 验证成功！"
        StatusLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
        
        VerifyButton.Text = "✅ 验证成功"
        VerifyButton.BackgroundColor3 = Color3.fromRGB(56, 142, 60)
        
        wait(1)
        
        local tweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        local tween = TweenService:Create(MainFrame, tweenInfo, {BackgroundTransparency = 1})
        tween:Play()
        
        local bgTween = TweenService:Create(Background, tweenInfo, {BackgroundTransparency = 1})
        bgTween:Play()
        
        wait(0.5)
        
        ScreenGui:Destroy()
        
        loadstring(game:HttpGet("https://raw.githubusercontent.com/latchmod-cell/LMPE/refs/heads/main/KEYVERIFYLMPE.lua"))()
    else
        StatusLabel.Text = "状态: ❌ 卡密错误"
        StatusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
        
        local tweenInfo = TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 3, true)
        local tween = TweenService:Create(KeyInput, tweenInfo, {Position = UDim2.new(0, 15, 0, 120)})
        tween:Play()
    end
end)

VerifyButton.MouseEnter:Connect(function()
    local tweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    local tween = TweenService:Create(VerifyButton, tweenInfo, {BackgroundColor3 = Color3.fromRGB(102, 187, 106)})
    tween:Play()
end)

VerifyButton.MouseLeave:Connect(function()
    local tweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    local tween = TweenService:Create(VerifyButton, tweenInfo, {BackgroundColor3 = Color3.fromRGB(76, 175, 80)})
    tween:Play()
end)

KeyInput.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        VerifyButton.MouseButton1Click:Fire()
    end
end)

print("LMPE验证系统已加载")
