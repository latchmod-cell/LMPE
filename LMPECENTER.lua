local LBLG = Instance.new("ScreenGui")
local LBL = Instance.new("TextLabel")
local PlayerLabel = Instance.new("TextLabel")
local player = game.Players.LocalPlayer

LBLG.Name = "LBLG"
LBLG.Parent = game.CoreGui
LBLG.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
LBLG.Enabled = true

LBL.Name = "LBL"
LBL.Parent = LBLG
LBL.BackgroundColor3 = Color3.new(1, 1, 1)
LBL.BackgroundTransparency = 1
LBL.BorderColor3 = Color3.new(0, 0, 0)
LBL.Position = UDim2.new(0, 5, 0, 10)
LBL.Size = UDim2.new(0, 250, 0, 35)
LBL.Font = Enum.Font.GothamSemibold
LBL.Text = "时间:加载中..."
LBL.TextColor3 = Color3.new(1, 1, 1)
LBL.TextScaled = false
LBL.TextSize = 22
LBL.TextWrapped = false
LBL.Visible = true
LBL.TextXAlignment = Enum.TextXAlignment.Left
LBL.TextYAlignment = Enum.TextYAlignment.Top
LBL.ZIndex = 10

LBL.TextSize = 18
LBL.Size = UDim2.new(0, 250, 0, 30)
LBL.Position = UDim2.new(1, -255, 0, 10)
LBL.TextXAlignment = Enum.TextXAlignment.Right

local Heartbeat = game:GetService("RunService").Heartbeat
local LastIteration, Start
local FrameUpdateTable = { }

local function HeartbeatUpdate()
    LastIteration = tick()
    for Index = #FrameUpdateTable, 1, -1 do
        FrameUpdateTable[Index + 1] = (FrameUpdateTable[Index] >= LastIteration - 1) and FrameUpdateTable[Index] or nil
    end
    FrameUpdateTable[1] = LastIteration
    local CurrentFPS = (tick() - Start >= 1 and #FrameUpdateTable) or (#FrameUpdateTable / (tick() - Start))
    CurrentFPS = CurrentFPS - CurrentFPS % 1
    
    local hue = tick() % 5 / 5
    local r = math.sin(hue * 6.28 + 0) * 127 + 128
    local g = math.sin(hue * 6.28 + 2) * 127 + 128
    local b = math.sin(hue * 6.28 + 4) * 127 + 128
    local color = Color3.fromRGB(r, g, b)
    
    LBL.Text = ("时间:"..os.date("%H").."时"..os.date("%M").."分"..os.date("%S"))
    LBL.TextColor3 = color
    PlayerLabel.TextColor3 = color
end
 
Start = tick()
Heartbeat:Connect(HeartbeatUpdate)

local success, ui = pcall(function()
return loadstring(game:HttpGet("https://pastebin.com/raw/3vQbADjh"))()
end)
if not success then
game:GetService("StarterGui"):SetCore("SendNotification",{Title="LMPE脚本中心";Text="UI库加载失败";Icon="rbxassetid://114514";Duration=5;})
return
end
local win = ui:new("LMPE脚本中心")
local function RainbowColor()
local hue=0
while true do
hue=(hue+1)%360
wait(0.05)
local color=Color3.fromHSV(hue/360,0.8,0.9)
coroutine.wrap(function()
for _,tab in pairs({UITab1,UITab2,UITab3,UITab4,UITab5,UITab6,UITab7,UITab8,UITab9,UITab10,UITab11})do
pcall(function()
tab.TabButton.BackgroundColor3=color
tab.TabButton.TextColor3=Color3.new(1,1,1)
end)
end
end)()
end
end
coroutine.wrap(RainbowColor)()
 
local UITab1 = win:Tab("『公告』",'114514')
local UITab2 = win:Tab("『通用』",'114514')
local UITab3 = win:Tab("『DOORS』",'114514')
 
local about = UITab1:section("『公告』",true)
local function RainbowFont(label)
local hue = 0
spawn(function()
while true do
hue = (hue + 1) % 360
wait(0.1)
pcall(function()
label.TextColor3 = Color3.fromHSV(hue/360, 0.8, 0.9)
end)
end
end)
end
local versionLabel = about:Label("LMPEv1.0.2")
 
local about = UITab1:section("『关于』",true)
local function safeIdentify()
local success, res = pcall(identifyexecutor)
return success and res or "未知"
end
about:Label("你的注入器:"..safeIdentify())
about:Label("服务器名称:"..game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name)
about:Label("当前服务器ID:" .. game.GameId)
about:Label("你的用户名:" .. game.Players.LocalPlayer.DisplayName)
about:Label("你的账号年龄:"..game.Players.LocalPlayer.AccountAge.."天")
local player = game.Players.LocalPlayer
if player.MembershipType == Enum.MembershipType.Premium then
about:Label("会员状态： 有会员")
else
about:Label("会员状态： 没有会员")
end
about:Label("语言： "..game.Players.LocalPlayer.LocaleId)
 
local UserInputService = game:GetService("UserInputService")
local deviceType = "未知设备"
if UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled and not UserInputService.MouseEnabled then
deviceType = "移动设备"
elseif not UserInputService.TouchEnabled and UserInputService.KeyboardEnabled and UserInputService.MouseEnabled then
deviceType = "电脑"
elseif UserInputService.TouchEnabled and UserInputService.KeyboardEnabled and UserInputService.MouseEnabled then
deviceType = "带触摸屏的电脑"
end
about:Label("设备类型："..deviceType)
 
about:Label("客户端ID:"..game:GetService("RbxAnalyticsService"):GetClientId())
 
local player = game.Players.LocalPlayer
if player.MembershipType == Enum.MembershipType.Premium then
print("会员状态： 是")
else
print("会员状态： 否")
end

local about = UITab1:section("『其他』", true)

about:Toggle("缩小UI", "UIScale", false, function(state)
    local scale = state and 0.965 or 1
    local coreGui = game:GetService("CoreGui")
    local targetGui = coreGui:FindFirstChild("frosty")
    if not targetGui then return end
    local mainWindow = targetGui:FindFirstChild("Main")
    if not mainWindow then return end
    if not mainWindow:FindFirstChild("OriginalSize") then
        local originalSize = Instance.new("Vector3Value")
        originalSize.Name = "OriginalSize"
        originalSize.Value = Vector3.new(mainWindow.Size.X.Offset, mainWindow.Size.Y.Offset, 0)
        originalSize.Parent = mainWindow
    end
    mainWindow.Size = UDim2.new(0, mainWindow.OriginalSize.Value.X * scale, 0, mainWindow.OriginalSize.Value.Y * scale)
end)

local function adaptVisualStyle()
    local coreGui = game:GetService("CoreGui")
    local targetGui = coreGui:FindFirstChild("frosty")
    if not targetGui then return end
    local otherSection = targetGui:FindFirstChild("『其他』")
    if otherSection then
        local buttons = otherSection:GetDescendants()
        for _, btn in ipairs(buttons) do
            if btn:IsA("TextButton") then
                if btn.Name == "关闭UI" or (btn.Parent and btn.Parent.Name == "ToggleModule" and btn.Parent.Parent == otherSection) then
                    btn.BackgroundColor3 = Color3.fromRGB(139, 0, 255)
                    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
                    btn.CornerRadius = UDim.new(0, 6)
                    btn.BackgroundTransparency = 0.75
                end
            end
        end
    end
end
adaptVisualStyle()

about:Button("重新加入服务器", function()
    local TeleportService = game:GetService("TeleportService")
    local success, err = pcall(function()
        TeleportService:Teleport(game.PlaceId, game.Players.LocalPlayer)
    end)
    if not success then
        game:GetService("StarterGui"):SetCore("SendNotification",{ Title = "重进失败"; Icon = "rbxassetid://114514"; Text ="null："..err; Duration = 4; })
    end
end)

about:Button("关闭UI", function()
    local coreGui = game:GetService("CoreGui")
    local targetGui = coreGui:FindFirstChild("frosty")
    if targetGui then
        targetGui:Destroy()
    end
end)

local about = UITab1:section("『复制』",true)
about:Button("复制服务器名称", function()
    local serverName = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name
    setclipboard(serverName)
    game:GetService("StarterGui"):SetCore("SendNotification",{Title="LMPE脚本中心";Icon="rbxassetid://114514";Text="服务器名称已复制";Duration=3;})
end)

about:Button("复制脚本学习+制作交流群", function()
    setclipboard("574149379")
    game:GetService("StarterGui"):SetCore("SendNotification",{ Title = "LMPE脚本中心"; Icon = "rbxassetid://114514"; Text ="群号已复制"; Duration = 3; })
end)

local about = UITab2:section("『玩家属性』",true)

about:Slider("视野", "FieldOfView", Workspace.CurrentCamera.FieldOfView, 10, 180, false, function(FOV)
    spawn(function() 
        while task.wait() do 
            Workspace.CurrentCamera.FieldOfView = FOV
        end 
    end)
end)

about:Slider("视角缩放距离", "CameraZoom", 100, 0.5, 1000000, false, function(Distance)
    local player = game.Players.LocalPlayer
    if player then
        player.CameraMaxZoomDistance = Distance
        player.CameraMinZoomDistance = 0.5
    end
end)

about:Slider("步行速度", "WalkSpeed", game.Players.LocalPlayer.Character.Humanoid.WalkSpeed, 1, 400, false, function(Speed)
  spawn(function() while task.wait() do game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Speed end end)
end)

about:Slider("跳跃高度", "JumpPower", game.Players.LocalPlayer.Character.Humanoid.JumpPower, 0, 2000, false, function(Jump)
    local plr = game.Players.LocalPlayer
    local originalJump = 50
    
    local function updateJump()
        if plr.Character and plr.Character:FindFirstChildOfClass("Humanoid") then
            local humanoid = plr.Character:FindFirstChildOfClass("Humanoid")
            humanoid.JumpPower = Jump
            humanoid.JumpHeight = Jump / 7  
        end
    end
    
    local function resetJump()
        if plr.Character and plr.Character:FindFirstChildOfClass("Humanoid") then
            local humanoid = plr.Character:FindFirstChildOfClass("Humanoid")
            humanoid.JumpPower = originalJump
            humanoid.JumpHeight = originalJump / 7
        end
    end
    
    updateJump()
    
    if plr.Character and plr.Character:FindFirstChildOfClass("Humanoid") then
        local humanoid = plr.Character:FindFirstChildOfClass("Humanoid")
        humanoid.StateChanged:Connect(function(oldState, newState)
            if newState == Enum.HumanoidStateType.Landed then
                wait(0.1)
                updateJump()
            end
        end)
    end
    
    plr.CharacterAdded:Connect(function(char)
        char:WaitForChild("Humanoid")
        updateJump()
        
        local humanoid = char:FindFirstChildOfClass("Humanoid")
        humanoid.StateChanged:Connect(function(oldState, newState)
            if newState == Enum.HumanoidStateType.Landed then
                wait(0.1)
                updateJump()
            end
        end)
    end)
end)

about:Slider("重力设置（默认196.2 高起不了身）", "Gravity", game.Workspace.Gravity, 1, 2000, false, function(GravityValue)
    game.Workspace.Gravity = GravityValue
end)

game.Players.LocalPlayer.CharacterAdded:Connect(function(char)
    wait(1)
    if _G.MaxHealthValue then
        char:WaitForChild("Humanoid").MaxHealth = _G.MaxHealthValue
    end
    if _G.HealthValue then
        char:WaitForChild("Humanoid").Health = _G.HealthValue
    end
end)

about:Button("重置重力",function()
local p=game.Players.LocalPlayer
local h=p.Character and p.Character:FindFirstChild("Humanoid")
if h then game:GetService("Workspace").Gravity=196.2 end
end)

local about = UITab2:section("『功能』",true)

about:Button("飞行v3",function()
    loadstring(game:HttpGet('https://raw.githubusercontent.com/XxwanhexxX/321/refs/heads/main/fly'))()
end)

about:Button("FPS显示",function()
    local RunService = game:GetService("RunService")
    local CoreGui = game:GetService("CoreGui")

    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "FPSDisplay"
    screenGui.Parent = CoreGui
    screenGui.ResetOnSpawn = false

    local textLabel = Instance.new("TextLabel")
    textLabel.Text = "FPS: 0"
    textLabel.TextSize = 22
    textLabel.Font = Enum.Font.GothamBold
    textLabel.BackgroundTransparency = 1
    textLabel.TextXAlignment = Enum.TextXAlignment.Left
    textLabel.TextYAlignment = Enum.TextYAlignment.Top
    textLabel.Size = UDim2.new(0, 200, 0, 35)
    textLabel.Position = UDim2.new(0, 10, 0, 10)
    textLabel.AnchorPoint = Vector2.new(0, 0)
    textLabel.ZIndex = 10
    textLabel.Parent = screenGui

    local frameCount = 0
    local lastUpdate = tick()

    RunService.RenderStepped:Connect(function()
        frameCount = frameCount + 1
        
        local currentTime = tick()
        if currentTime - lastUpdate >= 0.15 then
            local fps = math.floor(frameCount / (currentTime - lastUpdate))
            local color = Color3.new(1, 1, 1)
            
            textLabel.Text = "FPS: " .. fps
            textLabel.TextColor3 = color
            
            frameCount = 0
            lastUpdate = currentTime
        end
    end)
end)

about:Button("动态模糊", function()
    local Lighting = game:GetService("Lighting")
    
    local motionBlur = Instance.new("BlurEffect")
    motionBlur.Name = "DynamicMotionBlur"
    motionBlur.Size = 10
    motionBlur.Parent = Lighting
    
    game:GetService("RunService").RenderStepped:Connect(function(deltaTime)
        local player = game:GetService("Players").LocalPlayer
        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local velocity = player.Character.HumanoidRootPart.Velocity.Magnitude
            motionBlur.Size = math.clamp(velocity / 20, 0, 15)
        end
    end)
end)

about:Button("玩家加入游戏提示",function()
loadstring(game:HttpGet('https://raw.githubusercontent.com/boyscp/scriscriptsc/main/bbn.lua'))()
end)

about:Button("反挂机",function()
loadstring(game:HttpGet("https://pastebin.com/raw/9fFu43FF"))()
end)

about:Toggle("通用防摔伤", "Toggle", false, function(Value)
end)

about:Toggle("悬空锁高度", "Toggle", false, function(Value)
end)

local godModeEnabled = false
local connection

about:Toggle("无敌", "Toggle", false, function(Value)
end)

about:Toggle("夜视","Toggle",false,function(Value)
if Value then

		    game.Lighting.Ambient = Color3.new(1, 1, 1)

		else

		    game.Lighting.Ambient = Color3.new(0, 0, 0)

		end
end)

about:Toggle("自动互动", "Auto Interact", false, function(state)
        if state then
            autoInteract = true
            while autoInteract do
                for _, descendant in pairs(workspace:GetDescendants()) do
                    if descendant:IsA("ProximityPrompt") then
                        fireproximityprompt(descendant)
                    end
                end
                task.wait(0.25)
            end
        else
            autoInteract = false
        end
    end)

about:Toggle("无限跳","Toggle",false,function(Value)
        Jump = Value
        game.UserInputService.JumpRequest:Connect(function()
            if Jump then
                game.Players.LocalPlayer.Character.Humanoid:ChangeState("Jumping")
            end
        end)
    end)
    
    about:Toggle("循环恢复血量","Toggle",false,function(Value)
    AutoHeal = Value
    while AutoHeal do
        wait(0.01) 
        
        local player = game.Players.LocalPlayer
        local character = player.Character
        if character and character:FindFirstChild("Humanoid") then
            local humanoid = character.Humanoid
            humanoid.Health = humanoid.MaxHealth
        end
    end
end)

about:Button("汉化穿墙",function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/TtmScripter/OtherScript/main/Noclip"))()
end)

about:Button("踏空ui", function()
    loadstring(game:HttpGet('https://raw.githubusercontent.com/GhostPlayer352/Test4/main/Float', true))()
end)

about:Button("强制杀死玩家", function()
    if game.Players.LocalPlayer.Character then
        game.Players.LocalPlayer.Character:BreakJoints()
    end
end)

about:Button("飞车", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/dingding123hhh/vb/main/%E9%A3%9E%E8%BD%A6.lua", true))()
end)

about:Button("旋转", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/dingding123hhh/tt/main/%E6%97%8B%E8%BD%AC.lua", true))()
end)

about:Label("境头")

about:Button("第一人称", function()
    game.Players.LocalPlayer.CameraMaxZoomDistance = 0.5
    game.Players.LocalPlayer.CameraMode = Enum.CameraMode.LockFirstPerson
    
    local function setFirstPerson()
        game.Players.LocalPlayer.CameraMaxZoomDistance = 0.5
        game.Players.LocalPlayer.CameraMode = Enum.CameraMode.LockFirstPerson
    end
    
    setFirstPerson()
    
    game.Players.LocalPlayer.CharacterAdded:Connect(function()
        wait(1)
        setFirstPerson()
    end)
end)

about:Button("第三人称", function()
    game.Players.LocalPlayer.CameraMaxZoomDistance = 50
    game.Players.LocalPlayer.CameraMode = Enum.CameraMode.Classic
    
    local function setThirdPerson()
        game.Players.LocalPlayer.CameraMaxZoomDistance = 50
        game.Players.LocalPlayer.CameraMode = Enum.CameraMode.Classic
    end
    
    setThirdPerson()
    
    game.Players.LocalPlayer.CharacterAdded:Connect(function()
        wait(1)
        setThirdPerson()
    end)
end)

local about = UITab2:section("『工具』",true)

about:Button("点击传送", function()
    local mouse = game.Players.LocalPlayer:GetMouse()
    local tool = Instance.new("Tool")
    tool.RequiresHandle = false
    tool.Name = "LMPE脚本中心点击传送"
    tool.Activated:Connect(function()
        if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            local pos = mouse.Hit + Vector3.new(0, 2.5, 0)
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(pos.X, pos.Y, pos.Z)
        end
    end)
    tool.Parent = game.Players.LocalPlayer.Backpack
end)

about:Button("控制台",function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/3345179204-sudo/-/refs/heads/main/%E6%8E%A7%E5%88%B6tai"))()
end)

about:Button("汉化dex",function()
loadstring(game:HttpGet("https://gitee.com/cmbhbh/cmbh/raw/master/Bex.lua"))()
end)

about:Button("工具挂", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Bebo-Mods/BeboScripts/main/StandAwekening.lua", true))()
end)

about:Button("iw指令", function()
    loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source', true))()
end)

about:Button("电脑键盘", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/advxzivhsjjdhxhsidifvsh/mobkeyboard/main/main.txt", true))()
end)

local about = UITab2:section("『光影』",true)

about:Button("普通光影", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/MZEEN2424/Graphics/main/Graphics.xml"))()
end)

about:Button("光影滤镜", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/MZEEN2424/Graphics/main/Graphics.xml"))()
end)

about:Button("超高画质",function()
loadstring(game:HttpGet("https://pastebin.com/raw/jHBfJYmS"))()
end)

about:Button("光影V4",function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/MZEEN2424/Graphics/main/Graphics.xml"))()
end)

about:Button("RTX高仿",function()
loadstring(game:HttpGet('https://pastebin.com/raw/Bkf0BJb3'))()
end)

about:Button("光影深", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/MZEEN2424/Graphics/main/Graphics.xml"))()
end)
about:Button("光影浅", function()
    loadstring(game:HttpGet("https://pastebin.com/raw/jHBfJYmS"))()
end)

local about = UITab3:section("『LMPE-DOORS』",true)

about:Button("LMPE-LMPE脚本", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/latchmod-cell/LMPE/refs/heads/main/LMPE-DOORS.lua"))()
end)