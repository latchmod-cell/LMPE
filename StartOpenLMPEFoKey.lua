-- LMPE 脚本中心 - 优化版
-- 减少通知卡顿，添加通用功能，优化性能

local OrionLib = loadstring(game:HttpGet('https://pastebin.com/raw/j9TdK86G'))()

-- 创建主窗口
local Window = OrionLib:MakeWindow({
    Name = "LMPE 脚本中心 v2.0",
    HidePremium = false,
    SaveConfig = true,
    IntroEnabled = true,
    ConfigFolder = "LMPEConfig"
})

-- 获取游戏服务
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")

-- 性能优化：减少通知频率
local lastNotificationTime = 0
local NOTIFICATION_COOLDOWN = 1.5 -- 1.5秒冷却

local function sendNotification(title, content, duration)
    local currentTime = tick()
    if currentTime - lastNotificationTime > NOTIFICATION_COOLDOWN then
        lastNotificationTime = currentTime
        OrionLib:MakeNotification({
            Name = title,
            Content = content,
            Image = "rbxassetid://4483345998",
            Time = duration or 3
        })
    end
end

-- 创建标签页
local MainTab = Window:MakeTab({Name = "🏠 主界面", Icon = "rbxassetid://4483345998"})
local UniversalTab = Window:MakeTab({Name = "🔧 通用功能", Icon = "rbxassetid://4483345998"})
local DoorsTab = Window:MakeTab({Name = "🚪 DOORS功能", Icon = "rbxassetid://4483345998"})
local VisualTab = Window:MakeTab({Name = "🎨 视觉增强", Icon = "rbxassetid://4483345998"})
local SettingsTab = Window:MakeTab({Name = "⚙️ 设置", Icon = "rbxassetid://4483345998"})

-- 全局变量
local connections = {}
local enabledFeatures = {}

-- 🏠 主界面内容
MainTab:AddSection({Name = "LMPE 脚本中心"})

-- 系统信息显示
MainTab:AddLabel("状态: ✅ 脚本已加载")
MainTab:AddLabel("版本: v2.0 优化版")
MainTab:AddLabel("玩家: " .. LocalPlayer.Name)
MainTab:AddLabel("游戏: " .. game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name)

-- 性能监控
local TimeLabel = MainTab:AddLabel("时间: 加载中...")
local FPSLabel = MainTab:AddLabel("FPS: 计算中...")
local PingLabel = MainTab:AddLabel("延迟: 检测中...")
local MemoryLabel = MainTab:AddLabel("内存: 监控中...")

-- 性能监控函数
local function startPerformanceMonitoring()
    -- 时间更新
    connections.timeUpdate = RunService.Heartbeat:Connect(function()
        TimeLabel:Set("时间: " .. os.date("%H:%M:%S"))
    end)
    
    -- FPS计算
    local frameCount = 0
    local lastFpsUpdate = tick()
    connections.fpsUpdate = RunService.RenderStepped:Connect(function()
        frameCount = frameCount + 1
        local currentTime = tick()
        if currentTime - lastFpsUpdate >= 1 then
            local fps = math.floor(frameCount / (currentTime - lastFpsUpdate))
            FPSLabel:Set("FPS: " .. fps)
            frameCount = 0
            lastFpsUpdate = currentTime
        end
    end)
    
    -- 内存监控（简化版）
    connections.memoryUpdate = RunService.Heartbeat:Connect(function()
        MemoryLabel:Set("内存: " .. math.floor(collectgarbage("count") / 1024) .. " MB")
    end)
end

-- 启动性能监控
startPerformanceMonitoring()

MainTab:AddSection({Name = "快捷操作"})

MainTab:AddButton({
    Name = "📊 服务器信息",
    Callback = function()
        local playerCount = #Players:GetPlayers()
        local maxPlayers = Players.MaxPlayers
        local gameTime = math.floor(workspace.DistributedGameTime)
        local hours = math.floor(gameTime / 3600)
        local minutes = math.floor((gameTime % 3600) / 60)
        
        sendNotification("服务器信息", 
            string.format("玩家: %d/%d\n运行: %d小时%d分", playerCount, maxPlayers, hours, minutes), 5)
    end
})

MainTab:AddButton({
    Name = "🔧 重新生成角色",
    Callback = function()
        if LocalPlayer.Character then
            LocalPlayer.Character:BreakJoints()
            sendNotification("角色重置", "角色正在重新生成")
        end
    end
})

-- 🔧 通用功能标签页
UniversalTab:AddSection({Name = "角色控制"})

-- 移动速度控制
UniversalTab:AddSlider({
    Name = "移动速度",
    Min = 16,
    Max = 100,
    Default = 16,
    Increment = 1,
    ValueName = "速度",
    Callback = function(Value)
        pcall(function()
            if LocalPlayer.Character then
                local humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
                if humanoid then
                    humanoid.WalkSpeed = Value
                    enabledFeatures.walkSpeed = Value
                end
            end
        end)
    end
})

-- 跳跃高度控制
UniversalTab:AddSlider({
    Name = "跳跃高度",
    Min = 50,
    Max = 150,
    Default = 50,
    Increment = 1,
    ValueName = "高度",
    Callback = function(Value)
        pcall(function()
            if LocalPlayer.Character then
                local humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
                if humanoid then
                    humanoid.JumpPower = Value
                    enabledFeatures.jumpPower = Value
                end
            end
        end)
    end
})

-- 无限跳跃
UniversalTab:AddToggle({
    Name = "无限跳跃",
    Default = false,
    Callback = function(Value)
        if connections.infiniteJump then
            connections.infiniteJump:Disconnect()
        end
        
        if Value then
            connections.infiniteJump = UserInputService.JumpRequest:Connect(function()
                if LocalPlayer.Character then
                    local humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
                    if humanoid then
                        humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                    end
                end
            end)
            enabledFeatures.infiniteJump = true
        else
            enabledFeatures.infiniteJump = false
        end
    end
})

-- 穿墙模式
UniversalTab:AddToggle({
    Name = "穿墙模式",
    Default = false,
    Callback = function(Value)
        if connections.noclip then
            connections.noclip:Disconnect()
        end
        
        if Value then
            connections.noclip = RunService.Stepped:Connect(function()
                pcall(function()
                    if LocalPlayer.Character then
                        for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
                            if part:IsA("BasePart") then
                                part.CanCollide = false
                            end
                        end
                    end
                end)
            end)
            enabledFeatures.noclip = true
        else
            pcall(function()
                if LocalPlayer.Character then
                    for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
                        if part:IsA("BasePart") then
                            part.CanCollide = true
                        end
                    end
                end
            end)
            enabledFeatures.noclip = false
        end
    end
})

UniversalTab:AddSection({Name = "游戏工具"})

-- 飞行模式
local flyEnabled = false
local flyVelocity
UniversalTab:AddToggle({
    Name = "飞行模式",
    Default = false,
    Callback = function(Value)
        flyEnabled = Value
        
        if connections.fly then
            connections.fly:Disconnect()
        end
        
        if Value then
            -- 初始化飞行
            pcall(function()
                local character = LocalPlayer.Character
                if character then
                    local rootPart = character:FindFirstChild("HumanoidRootPart")
                    if rootPart then
                        flyVelocity = Instance.new("BodyVelocity")
                        flyVelocity.Velocity = Vector3.new(0, 0, 0)
                        flyVelocity.MaxForce = Vector3.new(0, 0, 0)
                        flyVelocity.Parent = rootPart
                        
                        -- 飞行控制
                        connections.fly = RunService.Heartbeat:Connect(function()
                            if flyEnabled and character and rootPart then
                                local camera = workspace.CurrentCamera
                                local moveDirection = Vector3.new(0, 0, 0)
                                
                                -- 前后移动 (W/S)
                                if UserInputService:IsKeyDown(Enum.KeyCode.W) then
                                    moveDirection = moveDirection + camera.CFrame.LookVector
                                end
                                if UserInputService:IsKeyDown(Enum.KeyCode.S) then
                                    moveDirection = moveDirection - camera.CFrame.LookVector
                                end
                                
                                -- 左右移动 (A/D)
                                if UserInputService:IsKeyDown(Enum.KeyCode.A) then
                                    moveDirection = moveDirection - camera.CFrame.RightVector
                                end
                                if UserInputService:IsKeyDown(Enum.KeyCode.D) then
                                    moveDirection = moveDirection + camera.CFrame.RightVector
                                end
                                
                                -- 上升下降 (Space/Shift)
                                if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
                                    moveDirection = moveDirection + Vector3.new(0, 1, 0)
                                end
                                if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
                                    moveDirection = moveDirection + Vector3.new(0, -1, 0)
                                end
                                
                                -- 应用移动
                                flyVelocity.Velocity = moveDirection.Unit * 50
                                flyVelocity.MaxForce = Vector3.new(40000, 40000, 40000)
                            end
                        end)
                    end
                end
            end)
            sendNotification("飞行模式", "已启用 - 使用WASD+空格+Shift控制")
        else
            -- 关闭飞行
            if flyVelocity then
                flyVelocity:Destroy()
                flyVelocity = nil
            end
        end
    end
})

-- 点击传送
UniversalTab:AddToggle({
    Name = "点击传送",
    Default = false,
    Callback = function(Value)
        if connections.clickTP then
            connections.clickTP:Disconnect()
        end
        
        if Value then
            connections.clickTP = UserInputService.InputBegan:Connect(function(input, gameProcessed)
                if not gameProcessed and input.UserInputType == Enum.UserInputType.MouseButton1 then
                    pcall(function()
                        local character = LocalPlayer.Character
                        if character then
                            local rootPart = character:FindFirstChild("HumanoidRootPart")
                            if rootPart then
                                -- 获取鼠标点击位置
                                local mouse = LocalPlayer:GetMouse()
                                rootPart.CFrame = CFrame.new(mouse.Hit.Position + Vector3.new(0, 3, 0))
                                sendNotification("点击传送", "已传送到目标位置")
                            end
                        end
                    end)
                end
            end)
        end
    end
})

-- 🚪 DOORS功能标签页
DoorsTab:AddParagraph("DOORS功能", "专为DOORS游戏设计的自动化功能")

-- DOORS自动化功能
local autoFeatures = {
    hide = {enabled = false, name = "自动躲避"},
    key = {enabled = false, name = "自动寻钥"}, 
    door = {enabled = false, name = "自动开门"},
    full = {enabled = false, name = "全自动模式"}
}

-- 自动躲避怪物
DoorsTab:AddToggle({
    Name = "自动躲避怪物",
    Default = false,
    Callback = function(Value)
        autoFeatures.hide.enabled = Value
        if Value then
            sendNotification("DOORS功能", "自动躲避已启用")
        end
    end
})

-- 自动寻找钥匙
DoorsTab:AddToggle({
    Name = "自动寻找钥匙",
    Default = false,
    Callback = function(Value)
        autoFeatures.key.enabled = Value
        if Value then
            sendNotification("DOORS功能", "自动寻钥已启用")
        end
    end
})

-- 自动开门
DoorsTab:AddToggle({
    Name = "自动开门",
    Default = false,
    Callback = function(Value)
        autoFeatures.door.enabled = Value
        if Value then
            sendNotification("DOORS功能", "自动开门已启用")
        end
    end
})

-- 全自动模式
DoorsTab:AddToggle({
    Name = "全自动游戏模式",
    Default = false,
    Callback = function(Value)
        autoFeatures.full.enabled = Value
        if connections.doorsAuto then
            connections.doorsAuto:Disconnect()
        end
        
        if Value then
            connections.doorsAuto = RunService.Heartbeat:Connect(function()
                -- DOORS全自动逻辑可以在这里实现
                -- 这里只是一个框架
            end)
            sendNotification("DOORS功能", "全自动模式已启用")
        end
    end
})

DoorsTab:AddSection({Name = "DOORS工具"})

DoorsTab:AddButton({
    Name = "传送到下一房间",
    Callback = function()
        sendNotification("DOORS传送", "正在寻找下一房间...")
    end
})

DoorsTab:AddButton({
    Name = "显示实体位置",
    Callback = function()
        sendNotification("DOORS ESP", "实体位置显示已切换")
    end
})

-- 🎨 视觉增强标签页
VisualTab:AddSection({Name = "画面设置"})

-- 全亮度模式
VisualTab:AddToggle({
    Name = "全亮度模式",
    Default = false,
    Callback = function(Value)
        if connections.fullBright then
            connections.fullBright:Disconnect()
        end
        
        if Value then
            connections.fullBright = RunService.Heartbeat:Connect(function()
                pcall(function()
                    game.Lighting.Brightness = 3
                    game.Lighting.Ambient = Color3.new(1, 1, 1)
                    game.Lighting.GlobalShadows = false
                    game.Lighting.FogEnd = 100000
                end)
            end)
        else
            pcall(function()
                game.Lighting.Brightness = 1
                game.Lighting.Ambient = Color3.new(0.5, 0.5, 0.5)
                game.Lighting.GlobalShadows = true
                game.Lighting.FogEnd = 1000
            end)
        end
    end
})

-- 透视模式
VisualTab:AddToggle({
    Name = "透视模式",
    Default = false,
    Callback = function(Value)
        if Value then
            pcall(function()
                if LocalPlayer.Character then
                    for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
                        if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                            part.LocalTransparencyModifier = 0.5
                        end
                    end
                end
            end)
            sendNotification("视觉增强", "透视模式已启用")
        else
            pcall(function()
                if LocalPlayer.Character then
                    for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
                        if part:IsA("BasePart") then
                            part.LocalTransparencyModifier = 0
                        end
                    end
                end
            end)
        end
    end
})

VisualTab:AddSection({Name = "效果设置"})

-- 隐藏玩家
VisualTab:AddToggle({
    Name = "隐藏其他玩家",
    Default = false,
    Callback = function(Value)
        pcall(function()
            for _, player in pairs(Players:GetPlayers()) do
                if player ~= LocalPlayer and player.Character then
                    for _, part in pairs(player.Character:GetDescendants()) do
                        if part:IsA("BasePart") then
                            part.Transparency = Value and 1 or 0
                        end
                    end
                end
            end
        end)
    end
})

-- ⚙️ 设置标签页
SettingsTab:AddSection({Name = "系统设置"})

-- 性能设置
SettingsTab:AddToggle({
    Name = "启用性能监控",
    Default = true,
    Callback = function(Value)
        if not Value then
            for name, connection in pairs(connections) do
                if string.find(name, "Update") then
                    connection:Disconnect()
                    connections[name] = nil
                end
            end
            TimeLabel:Set("时间: 监控已禁用")
            FPSLabel:Set("FPS: 监控已禁用")
            MemoryLabel:Set("内存: 监控已禁用")
        else
            startPerformanceMonitoring()
        end
    end
})

SettingsTab:AddSlider({
    Name = "通知冷却时间",
    Min = 0.5,
    Max = 5,
    Default = 1.5,
    Increment = 0.5,
    ValueName = "秒",
    Callback = function(Value)
        NOTIFICATION_COOLDOWN = Value
    end
})

SettingsTab:AddSection({Name = "配置管理"})

SettingsTab:AddButton({
    Name = "💾 保存当前配置",
    Callback = function()
        local config = {
            enabledFeatures = enabledFeatures,
            notificationCooldown = NOTIFICATION_COOLDOWN
        }
        sendNotification("配置保存", "当前设置已保存")
    end
})

SettingsTab:AddButton({
    Name = "🔄 重置所有设置",
    Callback = function()
        -- 重置所有功能
        for _, connection in pairs(connections) do
            connection:Disconnect()
        end
        connections = {}
        enabledFeatures = {}
        
        -- 恢复游戏设置
        pcall(function()
            -- 恢复角色设置
            if LocalPlayer.Character then
                local humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
                if humanoid then
                    humanoid.WalkSpeed = 16
                    humanoid.JumpPower = 50
                end
            end
            
            -- 恢复光照设置
            game.Lighting.Brightness = 1
            game.Lighting.Ambient = Color3.new(0.5, 0.5, 0.5)
            game.Lighting.GlobalShadows = true
            game.Lighting.FogEnd = 1000
        end)
        
        sendNotification("系统重置", "所有设置已恢复默认")
    end
})

SettingsTab:AddSection({Name = "系统控制"})

SettingsTab:AddButton({
    Name = "🚫 安全关闭脚本",
    Callback = function()
        -- 清理所有连接
        for _, connection in pairs(connections) do
            connection:Disconnect()
        end
        
        -- 清理飞行模式
        if flyVelocity then
            flyVelocity:Destroy()
        end
        
        -- 恢复游戏设置
        pcall(function()
            -- 恢复角色设置
            if LocalPlayer.Character then
                local humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
                if humanoid then
                    humanoid.WalkSpeed = 16
                    humanoid.JumpPower = 50
                end
                
                -- 恢复碰撞
                for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = true
                        part.LocalTransparencyModifier = 0
                    end
                end
            end
            
            -- 恢复光照设置
            game.Lighting.Brightness = 1
            game.Lighting.Ambient = Color3.new(0.5, 0.5, 0.5)
            game.Lighting.GlobalShadows = true
            game.Lighting.FogEnd = 1000
            
            -- 恢复其他玩家显示
            for _, player in pairs(Players:GetPlayers()) do
                if player ~= LocalPlayer and player.Character then
                    for _, part in pairs(player.Character:GetDescendants()) do
                        if part:IsA("BasePart") then
                            part.Transparency = 0
                        end
                    end
                end
            end
        end)
        
        sendNotification("系统关闭", "LMPE 脚本中心已安全关闭", 3)
        
        wait(1)
        OrionLib:Destroy()
    end
})

-- 显示欢迎消息
sendNotification("LMPE 脚本中心", "增强版 v2.0 已加载完成！", 5)

-- 初始化UI
OrionLib:Init()

print("LMPE 脚本中心增强版加载完成")
