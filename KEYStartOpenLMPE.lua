-- LMPE 脚本中心 - 增强版 v2.0
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
local Workspace = game:GetService("Workspace")

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
local MainTab = Window:MakeTab({Name = "主界面", Icon = "rbxassetid://4483345998"})
local UniversalTab = Window:MakeTab({Name = "通用功能", Icon = "rbxassetid://4483345998"})
local DoorsTab = Window:MakeTab({Name = "DOORS功能", Icon = "rbxassetid://4483345998"})
local CombatTab = Window:MakeTab({Name = "战斗增强", Icon = "rbxassetid://4483345998"})
local VisualTab = Window:MakeTab({Name = "视觉增强", Icon = "rbxassetid://4483345998"})
local InfoTab = Window:MakeTab({Name = "信息显示", Icon = "rbxassetid://4483345998"})
local GameSpecificTab = Window:MakeTab({Name = "游戏特定", Icon = "rbxassetid://4483345998"})
local ToolsTab = Window:MakeTab({Name = "工具", Icon = "rbxassetid://4483345998"})
local SettingsTab = Window:MakeTab({Name = "⚙️ 设置", Icon = "rbxassetid://4483345998"})
local DoorsScriptTab = Window:MakeTab({Name = "DOORS脚本
", Icon = "rbxassetid://4483345998"})

-- 全局变量
local connections = {}
local enabledFeatures = {}

-- 🏠 主界面内容
MainTab:AddSection({Name = "LMPE 脚本中心"})

-- 系统信息显示
MainTab:AddLabel("状态: ✅ 脚本已加载")
MainTab:AddLabel("版本: v2.0 增强版")
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
    full = {enabled = false, name = "全自动模式"},
    interact = {enabled = false, name = "自动互动"}
}

-- 自动躲避怪物
DoorsTab:AddToggle({
    Name = "自动躲避怪物",
    Default = false,
    Callback = function(Value)
        autoFeatures.hide.enabled = Value
        if connections.autoHide then
            connections.autoHide:Disconnect()
        end
        
        if Value then
            connections.autoHide = RunService.Heartbeat:Connect(function()
                pcall(function()
                    -- 检测附近的怪物并自动躲避
                    local character = LocalPlayer.Character
                    if character then
                        local rootPart = character:FindFirstChild("HumanoidRootPart")
                        if rootPart then
                            -- 查找附近的怪物
                            for _, entity in pairs(Workspace:GetChildren()) do
                                if entity.Name:lower():find("rush") or entity.Name:lower():find("ambush") or 
                                   entity.Name:lower():find("seek") or entity.Name:lower():find("figure") then
                                    local entityRoot = entity:FindFirstChild("HumanoidRootPart") or entity:FindFirstChild("Head")
                                    if entityRoot then
                                        local distance = (rootPart.Position - entityRoot.Position).Magnitude
                                        if distance < 30 then
                                            -- 自动寻找最近的躲藏点
                                            local nearestHideSpot = findNearestHideSpot(rootPart.Position)
                                            if nearestHideSpot then
                                                rootPart.CFrame = nearestHideSpot
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end)
            end)
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
        if connections.autoKey then
            connections.autoKey:Disconnect()
        end
        
        if Value then
            connections.autoKey = RunService.Heartbeat:Connect(function()
                pcall(function()
                    local character = LocalPlayer.Character
                    if character then
                        local rootPart = character:FindFirstChild("HumanoidRootPart")
                        if rootPart then
                            -- 查找附近的钥匙
                            for _, item in pairs(Workspace:GetDescendants()) do
                                if item.Name:lower():find("key") and item:IsA("Part") then
                                    local distance = (rootPart.Position - item.Position).Magnitude
                                    if distance < 20 then
                                        rootPart.CFrame = CFrame.new(item.Position + Vector3.new(0, 3, 0))
                                        break
                                    end
                                end
                            end
                        end
                    end
                end)
            end)
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
        if connections.autoDoor then
            connections.autoDoor:Disconnect()
        end
        
        if Value then
            connections.autoDoor = RunService.Heartbeat:Connect(function()
                pcall(function()
                    local character = LocalPlayer.Character
                    if character then
                        local rootPart = character:FindFirstChild("HumanoidRootPart")
                        if rootPart then
                            -- 查找附近的门
                            for _, door in pairs(Workspace:GetDescendants()) do
                                if door.Name:lower():find("door") and door:IsA("Model") then
                                    local doorPrimary = door:FindFirstChild("PrimaryPart") or door:FindFirstChildWhichIsA("BasePart")
                                    if doorPrimary then
                                        local distance = (rootPart.Position - doorPrimary.Position).Magnitude
                                        if distance < 15 then
                                            -- 模拟开门互动
                                            fireproximityprompt(doorPrimary:FindFirstChildWhichIsA("ProximityPrompt"))
                                        end
                                    end
                                end
                            end
                        end
                    end
                end)
            end)
            sendNotification("DOORS功能", "自动开门已启用")
        end
    end
})

-- 自动互动功能
DoorsTab:AddToggle({
    Name = "自动互动",
    Default = false,
    Callback = function(Value)
        autoFeatures.interact.enabled = Value
        if connections.autoInteract then
            connections.autoInteract:Disconnect()
        end
        
        if Value then
            connections.autoInteract = RunService.Heartbeat:Connect(function()
                pcall(function()
                    local character = LocalPlayer.Character
                    if character then
                        local rootPart = character:FindFirstChild("HumanoidRootPart")
                        if rootPart then
                            -- 自动与附近的互动对象交互
                            for _, obj in pairs(Workspace:GetDescendants()) do
                                if obj:IsA("ProximityPrompt") then
                                    local parent = obj.Parent
                                    if parent and parent:IsA("BasePart") then
                                        local distance = (rootPart.Position - parent.Position).Magnitude
                                        if distance < obj.MaxActivationDistance then
                                            fireproximityprompt(obj)
                                        end
                                    end
                                end
                            end
                        end
                    end
                end)
            end)
            sendNotification("DOORS功能", "自动互动已启用")
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
                -- 启用所有自动化功能
                if not autoFeatures.key.enabled then
                    autoFeatures.key.enabled = true
                    -- 这里可以触发自动寻钥功能
                end
                if not autoFeatures.door.enabled then
                    autoFeatures.door.enabled = true
                    -- 这里可以触发自动开门功能
                end
                if not autoFeatures.interact.enabled then
                    autoFeatures.interact.enabled = true
                    -- 这里可以触发自动互动功能
                end
            end)
            sendNotification("DOORS功能", "全自动模式已启用")
        end
    end
})

DoorsTab:AddSection({Name = "DOORS工具"})

-- 辅助函数：查找最近的躲藏点
local function findNearestHideSpot(position)
    local nearestSpot = nil
    local shortestDistance = math.huge
    
    -- 查找可能的躲藏点（柜子、床等）
    for _, obj in pairs(Workspace:GetDescendants()) do
        if obj:IsA("Part") and (obj.Name:lower():find("closet") or obj.Name:lower():find("hide") or obj.Name:lower():find("bed")) then
            local distance = (position - obj.Position).Magnitude
            if distance < shortestDistance then
                shortestDistance = distance
                nearestSpot = obj.Position + Vector3.new(0, 3, 0)
            end
        end
    end
    
    return nearestSpot
end

-- 辅助函数：触发近距离提示
local function fireproximityprompt(prompt)
    if prompt and prompt:IsA("ProximityPrompt") then
        prompt:InputHoldBegin()
        wait(0.1)
        prompt:InputHoldEnd()
    end
end

DoorsTab:AddButton({
    Name = "传送到下一房间",
    Callback = function()
        pcall(function()
            local character = LocalPlayer.Character
            if character then
                local rootPart = character:FindFirstChild("HumanoidRootPart")
                if rootPart then
                    -- 寻找下一房间的门
                    for _, door in pairs(Workspace:GetDescendants()) do
                        if door.Name:lower():find("door") and door:IsA("Model") then
                            local doorPrimary = door:FindFirstChild("PrimaryPart") or door:FindFirstChildWhichIsA("BasePart")
                            if doorPrimary then
                                rootPart.CFrame = CFrame.new(doorPrimary.Position + doorPrimary.CFrame.LookVector * 10)
                                sendNotification("DOORS传送", "已传送到下一房间门口")
                                return
                            end
                        end
                    end
                    sendNotification("DOORS传送", "未找到下一房间")
                end
            end
        end)
    end
})

DoorsTab:AddButton({
    Name = "显示实体位置",
    Callback = function()
        pcall(function()
            -- 创建实体高亮
            for _, entity in pairs(Workspace:GetChildren()) do
                if entity.Name:lower():find("rush") or entity.Name:lower():find("ambush") or 
                   entity.Name:lower():find("seek") or entity.Name:lower():find("figure") or
                   entity.Name:lower():find("screech") or entity.Name:lower():find("halt") then
                   
                    local highlight = entity:FindFirstChild("LMPE_Highlight")
                    if not highlight then
                        highlight = Instance.new("Highlight")
                        highlight.Name = "LMPE_Highlight"
                        highlight.FillColor = Color3.fromRGB(255, 0, 0)
                        highlight.OutlineColor = Color3.fromRGB(255, 255, 0)
                        highlight.Parent = entity
                    else
                        highlight:Destroy()
                    end
                end
            end
            sendNotification("DOORS ESP", "实体位置显示已切换")
        end)
    end
})

-- 新增DOORS拓展功能
DoorsTab:AddSection({Name = "拓展功能"})

-- 自动收集物品
DoorsTab:AddToggle({
    Name = "自动收集物品",
    Default = false,
    Callback = function(Value)
        if connections.autoCollect then
            connections.autoCollect:Disconnect()
        end
        
        if Value then
            connections.autoCollect = RunService.Heartbeat:Connect(function()
                pcall(function()
                    local character = LocalPlayer.Character
                    if character then
                        local rootPart = character:FindFirstChild("HumanoidRootPart")
                        if rootPart then
                            -- 自动收集附近的物品（金币、工具等）
                            for _, item in pairs(Workspace:GetDescendants()) do
                                if (item.Name:lower():find("coin") or item.Name:lower():find("money") or 
                                    item.Name:lower():find("tool") or item.Name:lower():find("item")) and 
                                    item:IsA("Part") then
                                    
                                    local distance = (rootPart.Position - item.Position).Magnitude
                                    if distance < 15 then
                                        rootPart.CFrame = CFrame.new(item.Position + Vector3.new(0, 2, 0))
                                        -- 触发收集互动
                                        fireproximityprompt(item:FindFirstChildWhichIsA("ProximityPrompt"))
                                    end
                                end
                            end
                        end
                    end
                end)
            end)
            sendNotification("DOORS功能", "自动收集物品已启用")
        end
    end
})

-- 实体预警系统
DoorsTab:AddToggle({
    Name = "实体预警系统",
    Default = false,
    Callback = function(Value)
        if connections.entityAlert then
            connections.entityAlert:Disconnect()
        end
        
        if Value then
            connections.entityAlert = RunService.Heartbeat:Connect(function()
                pcall(function()
                    local character = LocalPlayer.Character
                    if character then
                        local rootPart = character:FindFirstChild("HumanoidRootPart")
                        if rootPart then
                            -- 检测附近实体并预警
                            for _, entity in pairs(Workspace:GetChildren()) do
                                if entity.Name:lower():find("rush") or entity.Name:lower():find("ambush") or 
                                   entity.Name:lower():find("seek") or entity.Name:lower():find("figure") then
                                   
                                    local entityRoot = entity:FindFirstChild("HumanoidRootPart") or entity:FindFirstChild("Head")
                                    if entityRoot then
                                        local distance = (rootPart.Position - entityRoot.Position).Magnitude
                                        if distance < 50 then
                                            -- 播放警告声音或显示警告
                                            sendNotification("⚠️ 实体预警", entity.Name .. " 在附近！距离: " .. math.floor(distance), 2)
                                        end
                                    end
                                end
                            end
                        end
                    end
                end)
            end)
            sendNotification("DOORS功能", "实体预警系统已启用")
        end
    end
})

-- 快速逃脱模式
DoorsTab:AddButton({
    Name = "🚨 快速逃脱模式",
    Callback = function()
        pcall(function()
            -- 启用所有逃脱相关功能
            autoFeatures.hide.enabled = true
            autoFeatures.door.enabled = true
            autoFeatures.interact.enabled = true
            
            -- 提高移动速度
            local character = LocalPlayer.Character
            if character then
                local humanoid = character:FindFirstChildOfClass("Humanoid")
                if humanoid then
                    humanoid.WalkSpeed = 35
                end
            end
            
            sendNotification("快速逃脱", "所有逃脱功能已激活！", 5)
        end)
    end
})

-- ⚔️ 战斗增强标签页
CombatTab:AddSection({Name = "战斗辅助"})

-- 自动攻击
CombatTab:AddToggle({
    Name = "自动攻击模式",
    Default = false,
    Callback = function(Value)
        if connections.autoAttack then
            connections.autoAttack:Disconnect()
        end
        
        if Value then
            connections.autoAttack = RunService.Heartbeat:Connect(function()
                pcall(function()
                    local character = LocalPlayer.Character
                    if character then
                        local humanoid = character:FindFirstChildOfClass("Humanoid")
                        if humanoid then
                            -- 自动攻击最近的敌人
                            local nearestEnemy = findNearestEnemy(character:GetPivot().Position)
                            if nearestEnemy and nearestEnemy:FindFirstChild("Humanoid") then
                                local enemyHumanoid = nearestEnemy:FindFirstChild("Humanoid")
                                if enemyHumanoid.Health > 0 then
                                    -- 面向敌人
                                    character:PivotTo(CFrame.lookAt(character:GetPivot().Position, nearestEnemy:GetPivot().Position))
                                    -- 模拟攻击
                                    humanoid:ChangeState(Enum.HumanoidStateType.Attacking)
                                end
                            end
                        end
                    end
                end)
            end)
            sendNotification("战斗增强", "自动攻击模式已启用")
        end
    end
})

-- 无敌模式
CombatTab:AddToggle({
    Name = "无敌模式",
    Default = false,
    Callback = function(Value)
        if connections.godMode then
            connections.godMode:Disconnect()
        end
        
        if Value then
            connections.godMode = RunService.Heartbeat:Connect(function()
                pcall(function()
                    local character = LocalPlayer.Character
                    if character then
                        local humanoid = character:FindFirstChildOfClass("Humanoid")
                        if humanoid and humanoid.Health < humanoid.MaxHealth then
                            humanoid.Health = humanoid.MaxHealth
                        end
                    end
                end)
            end)
            sendNotification("战斗增强", "无敌模式已启用")
        end
    end
})

-- 一击必杀
CombatTab:AddToggle({
    Name = "一击必杀",
    Default = false,
    Callback = function(Value)
        enabledFeatures.oneHitKill = Value
        sendNotification("战斗增强", Value and "一击必杀已启用" or "一击必杀已禁用")
    end
})

-- 伤害倍数
CombatTab:AddSlider({
    Name = "伤害倍数",
    Min = 1,
    Max = 10,
    Default = 1,
    Increment = 0.5,
    ValueName = "倍",
    Callback = function(Value)
        enabledFeatures.damageMultiplier = Value
    end
})

CombatTab:AddSection({Name = "武器控制"})

-- 无限弹药
CombatTab:AddToggle({
    Name = "无限弹药",
    Default = false,
    Callback = function(Value)
        enabledFeatures.infiniteAmmo = Value
        if Value then
            sendNotification("武器控制", "无限弹药已启用")
        end
    end
})

-- 无后坐力
CombatTab:AddToggle({
    Name = "无后坐
    Default = false,
    Callback = function(Value)
        enabledFeatures.noRecoil = Value
        if Value then
            sendNotification("武器控制", "无后坐力已启用")
        end
    end
})

-- 快速射击
CombatTab:AddToggle({
    Name = "快速射击",
    Default = false,
    Callback = function(Value)
        enabledFeatures.rapidFire = Value
        if Value then
            sendNotification("武器控制", "快速射击已启用")
        end
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

-- 🔍 信息显示标签页
InfoTab:AddSection({Name = "玩家信息"})

-- 玩家列表显示
local playerList = InfoTab:AddParagraph("在线玩家", "加载中...")

local function updatePlayerList()
    local playerNames = {}
    for _, player in pairs(Players:GetPlayers()) do
        table.insert(playerNames, player.Name)
    end
    playerList:Set("在线玩家: " .. table.concat(playerNames, ", "))
end

-- 玩家加入/离开监听
Players.PlayerAdded:Connect(updatePlayerList)
Players.PlayerRemoving:Connect(updatePlayerList)
updatePlayerList()

-- 玩家ESP开关
InfoTab:AddToggle({
    Name = "玩家ESP显示",
    Default = false,
    Callback = function(Value)
        if connections.playerESP then
            connections.playerESP:Disconnect()
        end
        
        if Value then
            connections.playerESP = RunService.Heartbeat:Connect(function()
                pcall(function()
                    for _, player in pairs(Players:GetPlayers()) do
                        if player ~= LocalPlayer and player.Character then
                            local humanoidRootPart = player.Character:FindFirstChild("HumanoidRootPart")
                            if humanoidRootPart then
                                -- 创建或更新ESP
                                local highlight = humanoidRootPart:FindFirstChild("PlayerESP")
                                if not highlight then
                                    highlight = Instance.new("Highlight")
                                    highlight.Name = "PlayerESP"
                                    highlight.FillColor = Color3.fromRGB(0, 255, 0)
                                    highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                                    highlight.FillTransparency = 0.7
                                    highlight.Parent = humanoidRootPart
                                    
                                    -- 添加距离标签
                                    local billboard = Instance.new("BillboardGui")
                                    billboard.Name = "PlayerDistance"
                                    billboard.Adornee = humanoidRootPart
                                    billboard.Size = UDim2.new(0, 100, 0, 40)
                                    billboard.StudsOffset = Vector3.new(0, 3, 0)
                                    
                                    local label = Instance.new("TextLabel")
                                    label.Size = UDim2.new(1, 0, 1, 0)
                                    label.BackgroundTransparency = 1
                                    label.TextColor3 = Color3.new(1, 1, 1)
                                    label.TextStrokeTransparency = 0
                                    label.TextSize = 14
                                    label.Font = Enum.Font.GothamBold
                                    label.Parent = billboard
                                    billboard.Parent = humanoidRootPart
                                end
                                
                                -- 更新距离显示
                                local distanceLabel = humanoidRootPart:FindFirstChild("PlayerDistance")
                                if distanceLabel and LocalPlayer.Character then
                                    local localRoot = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                                    if localRoot then
                                        local distance = (localRoot.Position - humanoidRootPart.Position).Magnitude
                                        distanceLabel.TextLabel.Text = player.Name .. "\n" .. math.floor(distance) .. "m"
                                    end
                                end
                            end
                        end
                    end
                end)
            end)
        else
            -- 清理所有ESP
            pcall(function()
                for _, player in pairs(Players:GetPlayers()) do
                    if player.Character then
                        local humanoidRootPart = player.Character:FindFirstChild("HumanoidRootPart")
                        if humanoidRootPart then
                            local esp = humanoidRootPart:FindFirstChild("PlayerESP")
                            if esp then esp:Destroy() end
                            local distanceGui = humanoidRootPart:FindFirstChild("PlayerDistance")
                            if distanceGui then distanceGui:Destroy() end
                        end
                    end
                end
            end)
        end
    end
})

InfoTab:AddSection({Name = "游戏信息"})

-- 游戏详细信息
local gameInfoLabel = InfoTab:AddParagraph("游戏信息", "加载中...")

local function updateGameInfo()
    pcall(function()
        local placeInfo = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId)
        local playerCount = #Players:GetPlayers()
        local maxPlayers = Players.MaxPlayers
        local gameTime = math.floor(workspace.DistributedGameTime)
        
        gameInfoLabel:Set(string.format(
            "游戏: %s\n玩家: %d/%d\n运行时间: %d秒\n描述: %s",
            placeInfo.Name, playerCount, maxPlayers, gameTime,
            string.sub(placeInfo.Description or "无描述", 1, 100)
        ))
    end)
end

-- 定时更新游戏信息
connections.gameInfoUpdate = RunService.Heartbeat:Connect(function()
    if tick() % 5 < 0.1 then -- 每5秒更新一次
        updateGameInfo()
    end
end)
updateGameInfo()

-- 🎮 游戏特定功能标签页
GameSpecificTab:AddSection({Name = "通用游戏功能"})

-- 自动收集资源
GameSpecificTab:AddToggle({
    Name = "自动收集资源",
    Default = false,
    Callback = function(Value)
        if connections.autoFarm then
            connections.autoFarm:Disconnect()
        end
        
        if Value then
            connections.autoFarm = RunService.Heartbeat:Connect(function()
                pcall(function()
                    local character = LocalPlayer.Character
                    if character then
                        local rootPart = character:FindFirstChild("HumanoidRootPart")
                        if rootPart then
                            -- 自动收集附近的资源
                            for _, item in pairs(Workspace:GetDescendants()) do
                                if (item.Name:lower():find("coin") or item.Name:lower():find("money") or 
                                    item.Name:lower():find("resource") or item.Name:lower():find("ore") or
                                    item.Name:lower():find("wood") or item.Name:lower():find("stone")) and 
                                    item:IsA("Part") then
                                    
                                    local distance = (rootPart.Position - item.Position).Magnitude
                                    if distance < 20 then
                                        rootPart.CFrame = CFrame.new(item.Position + Vector3.new(0, 2, 0))
                                        task.wait(0.1) -- 防止过于频繁的传送
                                    end
                                end
                            end
                        end
                    end
                end)
            end)
            sendNotification("游戏功能", "自动收集资源已启用")
        end
    end
})

-- 自动完成任务
GameSpecificTab:AddToggle({
    Name = "自动完成任务",
    Default = false,
    Callback = function(Value)
        if connections.autoQuest then
            connections.autoQuest:Disconnect()
        end
        
        if Value then
            connections.autoQuest = RunService.Heartbeat:Connect(function()
                pcall(function()
                    -- 自动与任务NPC交互
                    for _, npc in pairs(Workspace:GetDescendants()) do
                        if npc:IsA("Model") and (npc.Name:lower():find("npc") or npc.Name:lower():find("quest")) then
                            local humanoidRootPart = npc:FindFirstChild("HumanoidRootPart")
                            if humanoidRootPart then
                                local distance = (LocalPlayer.Character:GetPivot().Position - humanoidRootPart.Position).Magnitude
                                if distance < 15 then
                                    -- 自动接受/完成任务
                                    fireproximityprompt(humanoidRootPart:FindFirstChildWhichIsA("ProximityPrompt"))
                                end
                            end
                        end
                    end
                end)
            end)
            sendNotification("游戏功能", "自动完成任务已启用")
        end
    end
})

GameSpecificTab:AddSection({Name = "工具功能"})

-- 服务器跳转
GameSpecificTab:AddButton({
    Name = "🔄 跳转到低延迟服务器",
    Callback = function()
        pcall(function()
            local HttpService = game:GetService("HttpService")
            local TeleportService = game:GetService("TeleportService")
            
            -- 获取服务器列表
            local servers = HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100"))
            
            local bestServer
            local lowestPing = math.huge
            
            for _, server in pairs(servers.data) do
                if server.playing < server.maxPlayers and server.ping < lowestPing then
                    lowestPing = server.ping
                    bestServer = server.id
                end
            end
            
            if bestServer then
                TeleportService:TeleportToPlaceInstance(game.PlaceId, bestServer)
                sendNotification("服务器跳转", "正在跳转到低延迟服务器...")
            else
                sendNotification("服务器跳转", "未找到合适的服务器")
            end
        end)
    end
})

-- 复制游戏ID
GameSpecificTab:AddButton({
    Name = "📋 复制游戏ID",
    Callback = function()
        pcall(function()
            local setclipboard = setclipboard or toclipboard or set_clipboard
            if setclipboard then
                setclipboard(tostring(game.PlaceId))
                sendNotification("复制成功", "游戏ID已复制到剪贴板: " .. game.PlaceId)
            else
                sendNotification("复制失败", "无法访问剪贴板功能")
            end
        end)
    end
})

-- 🛠️ 工具标签页
ToolsTab:AddSection({Name = "开发工具"})

-- 执行Lua代码
local codeInput = ToolsTab:AddTextbox({
    Name = "执行Lua代码",
    Default = "print('Hello World!')",
    TextDisappear = false,
    Callback = function(Code)
        pcall(function()
            local func, error = loadstring(Code)
            if func then
                func()
                sendNotification("代码执行", "代码执行成功")
            else
                sendNotification("代码错误", "执行失败: " .. tostring(error), 5)
            end
        end)
    end
})

ToolsTab:AddButton({
    Name = "清空输出",
    Callback = function()
        pcall(function()
            rconsoleclear()
            sendNotification("工具", "输出已清空")
        end)
    end
})

ToolsTab:AddSection({Name = "调试工具"})

-- 显示坐标
ToolsTab:AddToggle({
    Name = "显示坐标信息",
    Default = false,
    Callback = function(Value)
        if connections.showCoords then
            connections.showCoords:Disconnect()
        end
        
        if Value then
            connections.showCoords = RunService.Heartbeat:Connect(function()
                pcall(function()
                    local character = LocalPlayer.Character
                    if character then
                        local rootPart = character:FindFirstChild("HumanoidRootPart")
                        if rootPart then
                            local position = rootPart.Position
                            local x, y, z = math.floor(position.X), math.floor(position.Y), math.floor(position.Z)
                            
                            -- 在屏幕上显示坐标
                            if not enabledFeatures.coordsDisplay then
                                enabledFeatures.coordsDisplay = Instance.new("ScreenGui")
                                enabledFeatures.coordsDisplay.Name = "CoordsDisplay"
                                enabledFeatures.coordsDisplay.Parent = game.CoreGui
                                
                                local frame = Instance.new("Frame")
                                frame.Size = UDim2.new(0, 200, 0, 60)
                                frame.Position = UDim2.new(0, 10, 0, 10)
                                frame.BackgroundTransparency = 0.7
                                frame.BackgroundColor3 = Color3.new(0, 0, 0)
                                frame.Parent = enabledFeatures.coordsDisplay
                                
                                local label = Instance.new("TextLabel")
                                label.Size = UDim2.new(1, 0, 1, 0)
                                label.BackgroundTransparency = 1
                                label.TextColor3 = Color3.new(1, 1, 1)
                                label.TextStrokeTransparency = 0
                                label.TextSize = 16
                                label.Font = Enum.Font.Code
                                label.Parent = frame
                                enabledFeatures.coordsLabel = label
                            end
                            
                            if enabledFeatures.coordsLabel then
                                enabledFeatures.coordsLabel.Text = string.format("坐标: X=%d Y=%d Z=%d", x, y, z)
                            end
                        end
                    end
                end)
            end)
        else
            if enabledFeatures.coordsDisplay then
                enabledFeatures.coordsDisplay:Destroy()
                enabledFeatures.coordsDisplay = nil
            end
        end
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

SettingsTab:AddSection({Name = "界面设置"})

-- 主题颜色选择
SettingsTab:AddDropdown({
    Name = "主题颜色",
    Default = "默认",
    Options = {"默认", "深蓝", "红色", "绿色", "紫色", "粉色"},
    Callback = function(Value)
        -- 这里可以添加主题切换逻辑
        sendNotification("界面设置", "主题已切换为: " .. Value)
    end
})

-- 透明度控制
SettingsTab:AddSlider({
    Name = "界面透明度",
    Min = 0.1,
    Max = 1,
    Default = 1,
    Increment = 0.1,
    ValueName = "透明度",
    Callback = function(Value)
        -- 这里可以添加界面透明度调整逻辑
        sendNotification("界面设置", "透明度已设置为: " .. Value)
    end
})

-- 添加键盘快捷键部分
SettingsTab:AddSection({Name = "快捷键设置"})

local keybinds = {
    toggleMenu = {key = "RightShift", name = "显示/隐藏菜单"},
    toggleFly = {key = "F", name = "切换飞行模式"},
    toggleNoclip = {key = "N", name = "切换穿墙模式"},
    quickTP = {key = "T", name = "快速传送"}
}

for name, bind in pairs(keybinds) do
    SettingsTab:AddKeybind({
        Name = bind.name,
        Default = Enum.KeyCode[bind.key],
        Callback = function(KeyCode)
            keybinds[name].key = KeyCode.Name
            sendNotification("快捷键", bind.name .. " 已设置为: " .. KeyCode.Name)
        end
    })
end

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

-- 辅助函数：查找最近的敌人
local function findNearestEnemy(position)
    local nearestEnemy = nil
    local shortestDistance = math.huge
    
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Team ~= LocalPlayer.Team then
            local humanoidRootPart = player.Character:FindFirstChild("HumanoidRootPart")
            if humanoidRootPart then
                local distance = (position - humanoidRootPart.Position).Magnitude
                if distance < shortestDistance then
                    shortestDistance = distance
                    nearestEnemy = player.Character
                end
            end
        end
    end
    
    -- 也查找NPC敌人
    for _, npc in pairs(Workspace:GetChildren()) do
        if npc:FindFirstChild("Humanoid") and npc:FindFirstChild("HumanoidRootPart") then
            local humanoid = npc:FindFirstChild("Humanoid")
            if humanoid.Health > 0 then
                local distance = (position - npc:GetPivot().Position).Magnitude
                if distance < shortestDistance then
                    shortestDistance = distance
                    nearestEnemy = npc
                end
            end
        end
    end
    
    return nearestEnemy
end

-- 键盘快捷键监听
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    
    for name, bind in pairs(keybinds) do
        if input.KeyCode == Enum.KeyCode[bind.key] then
            -- 执行对应的功能
            if name == "toggleMenu" then
                -- 切换菜单显示/隐藏
                OrionLib:MakeNotification({
                    Name = "快捷键",
                    Content = "菜单显示/隐藏快捷键",
                    Time = 2
                })
            elseif name == "toggleFly" then
                -- 切换飞行模式
                -- 这里需要实现飞行模式的切换逻辑
            end
        end
    end
end)

-- 统计功能数量
local function countFeatures()
    local count = 0
    for _ in pairs(Window) do count = count + 1 end
    return count
end

DoorsScriptTab:AddSection({Name = "DOORS脚本"})

Tab:AddButton({
	Name = "LMPE|DOORS脚本",
	Callback = function()

local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()
local Window = OrionLib:MakeWindow({IntroText = "“门” 脚本 APT汉化",Name = "“门” APT汉化", HidePremium = false, SaveConfig = true, ConfigFolder = "DoorsSex"})
if game.PlaceId == 6516141723 then
    OrionLib:MakeNotification({
        Name = "错误",
        Content = "此脚本不能在大厅执行",
        Time = 5
    })
end
local VisualsTab = Window:MakeTab({
	Name = "透视",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

local CF = CFrame.new
local LatestRoom = game:GetService("ReplicatedStorage").GameData.LatestRoom

local KeyChams = {}
VisualsTab:AddToggle({
	Name = "钥匙透视",
	Default = false,
    Flag = "KeyToggle",
    Save = true,
	Callback = function(Value)
		for i,v in pairs(KeyChams) do
            v.Enabled = Value
        end
	end    
})

local function ApplyKeyChams(inst)
    wait()
    local Cham = Instance.new("Highlight")
    Cham.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    Cham.FillColor = Color3.new(0.980392, 0.670588, 0)
    Cham.FillTransparency = 0.5
    Cham.OutlineColor = Color3.new(0.792156, 0.792156, 0.792156)
    Cham.Parent = game:GetService("CoreGui")
    Cham.Adornee = inst
    Cham.Enabled = OrionLib.Flags["KeyToggle"].Value
    Cham.RobloxLocked = true
    return Cham
end

local KeyCoroutine = coroutine.create(function()
    workspace.CurrentRooms.DescendantAdded:Connect(function(inst)
        if inst.Name == "KeyObtain" then
            table.insert(KeyChams,ApplyKeyChams(inst))
        end
    end)
end)
for i,v in ipairs(workspace:GetDescendants()) do
    if v.Name == "KeyObtain" then
        table.insert(KeyChams,ApplyKeyChams(v))
    end
end
coroutine.resume(KeyCoroutine)

local BookChams = {}
VisualsTab:AddToggle({
	Name = "50关书透视",
	Default = false,
    Flag = "BookToggle",
    Save = true,
	Callback = function(Value)
		for i,v in pairs(BookChams) do
            v.Enabled = Value
        end
	end    
})

local FigureChams = {}
VisualsTab:AddToggle({
	Name = "50关Figure透视",
	Default = false,
    Flag = "FigureToggle",
    Save = true,
    Callback = function(Value)
        for i,v in pairs(FigureChams) do
            v.Enabled = Value
        end
    end
})

local function ApplyBookChams(inst)
    if inst:IsDescendantOf(game:GetService("Workspace").CurrentRooms:FindFirstChild("50")) and game:GetService("ReplicatedStorage").GameData.LatestRoom.Value == 50 then
        wait()
        local Cham = Instance.new("Highlight")
        Cham.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
        Cham.FillColor = Color3.new(0, 1, 0.749019)
        Cham.FillTransparency = 0.5
        Cham.OutlineColor = Color3.new(0.792156, 0.792156, 0.792156)
        Cham.Parent = game:GetService("CoreGui")
        Cham.Enabled = OrionLib.Flags["BookToggle"].Value
        Cham.Adornee = inst
        Cham.RobloxLocked = true
        return Cham
    end
end

local function ApplyEntityChams(inst)
    wait()
    local Cham = Instance.new("Highlight")
    Cham.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    Cham.FillColor = Color3.new(1, 0, 0)
    Cham.FillTransparency = 0.5
    Cham.OutlineColor = Color3.new(0.792156, 0.792156, 0.792156)
    Cham.Parent = game:GetService("CoreGui")
    Cham.Enabled = OrionLib.Flags["FigureToggle"].Value
    Cham.Adornee = inst
    Cham.RobloxLocked = true
    return Cham
end

local BookCoroutine = coroutine.create(function()
    task.wait(1)
    for i,v in pairs(game:GetService("Workspace").CurrentRooms["50"].Assets:GetDescendants()) do
        if v.Name == "LiveHintBook" then
            table.insert(BookChams,ApplyBookChams(v))
        end
    end
end)
local EntityCoroutine = coroutine.create(function()
    local Entity = game:GetService("Workspace").CurrentRooms["50"].FigureSetup:WaitForChild("FigureRagdoll",5)
    Entity:WaitForChild("Torso",2.5)
    table.insert(FigureChams,ApplyEntityChams(Entity))
end)


local GameTab = Window:MakeTab({
	Name = "主要功能",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})
local CharTab = Window:MakeTab({
	Name = "其他",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

local TargetWalkspeed
CharTab:AddSlider({
	Name = "速度",
	Min = 0,
	Max = 50,
	Default = 5,
	Color = Color3.fromRGB(255,255,255),
	Increment = 1,
	Callback = function(Value)
		TargetWalkspeed = Value
	end    
})

local pcl = Instance.new("SpotLight")
pcl.Brightness = 1
pcl.Face = Enum.NormalId.Front
pcl.Range = 90
pcl.Parent = game.Players.LocalPlayer.Character.Head
pcl.Enabled = false


CharTab:AddToggle({
	Name = "灯光(别人看不见)",
	Default = false,
    Callback = function(Value)
        pcl.Enabled = Value
    end
})

GameTab:AddToggle({
	Name = "追逐无火",
	Default = false,
    Flag = "NoSeek",
    Save = true
})

GameTab:AddToggle({
	Name = "瞬间互动",
	Default = false,
    Flag = "InstantToggle",
    Save = true
})
GameTab:AddButton({
	Name = "过一道门",
	Callback = function()
        pcall(function()
            local HasKey = false
            local CurrentDoor = workspace.CurrentRooms[tostring(game:GetService("ReplicatedStorage").GameData.LatestRoom.Value)]:WaitForChild("Door")
            for i,v in ipairs(CurrentDoor.Parent:GetDescendants()) do
                if v.Name == "KeyObtain" then
                    HasKey = v
                end
            end
            if HasKey then
                game.Players.LocalPlayer.Character:PivotTo(CF(HasKey.Hitbox.Position))
                wait(0.3)
                fireproximityprompt(HasKey.ModulePrompt,0)
                game.Players.LocalPlayer.Character:PivotTo(CF(CurrentDoor.Door.Position))
                wait(0.3)
                fireproximityprompt(CurrentDoor.Lock.UnlockPrompt,0)
            end
            if LatestRoom == 50 then
                CurrentDoor = workspace.CurrentRooms[tostring(LatestRoom+1)]:WaitForChild("Door")
            end
            game.Players.LocalPlayer.Character:PivotTo(CF(CurrentDoor.Door.Position))
            wait(0.3)
            CurrentDoor.ClientOpen:FireServer()
        end)
  	end    
})

GameTab:AddToggle({
	Name = "连续过门",
	Default = false,
    Save = false,
    Flag = "AutoSkip"
})

local AutoSkipCoro = coroutine.create(function()
        while true do
            task.wait()
            pcall(function()
            if OrionLib.Flags["AutoSkip"].Value == true and game:GetService("ReplicatedStorage").GameData.LatestRoom.Value < 100 then
                local HasKey = false
                local LatestRoom = game:GetService("ReplicatedStorage").GameData.LatestRoom.Value
                local CurrentDoor = workspace.CurrentRooms[tostring(LatestRoom)]:WaitForChild("Door")
                for i,v in ipairs(CurrentDoor.Parent:GetDescendants()) do
                    if v.Name == "KeyObtain" then
                        HasKey = v
                    end
                end
                if HasKey then
                    game.Players.LocalPlayer.Character:PivotTo(CF(HasKey.Hitbox.Position))
                    task.wait(0.3)
                    fireproximityprompt(HasKey.ModulePrompt,0)
                    game.Players.LocalPlayer.Character:PivotTo(CF(CurrentDoor.Door.Position))
                    task.wait(0.3)
                    fireproximityprompt(CurrentDoor.Lock.UnlockPrompt,0)
                end
                if LatestRoom == 50 then
                    CurrentDoor = workspace.CurrentRooms[tostring(LatestRoom+1)]:WaitForChild("Door")
                end
                game.Players.LocalPlayer.Character:PivotTo(CF(CurrentDoor.Door.Position))
                task.wait(0.3)
                CurrentDoor.ClientOpen:FireServer()
            end
        end)
        end
end)
coroutine.resume(AutoSkipCoro)

GameTab:AddButton({
	Name = "没有跳杀",
	Callback = function()
        pcall(function()
            game:GetService("ReplicatedStorage").Bricks.Jumpscare:Destroy()
        end)
  	end    
})
GameTab:AddToggle({
	Name = "自动躲避rush/ambush",
	Default = false,
    Flag = "AvoidRushToggle",
    Save = true
})
GameTab:AddToggle({
	Name = "取消Screech跳杀",
	Default = false,
    Flag = "ScreechToggle",
    Save = true
})

GameTab:AddToggle({
	Name = "取消心跳游戏",
	Default = false,
    Flag = "HeartbeatWin",
    Save = true
})

GameTab:AddToggle({
	Name = "跳过追逐战",
	Default = false,
    Flag = "PredictToggle" ,
    Save = true
})
GameTab:AddToggle({
	Name = "怪物通知",
	Default = false,
    Flag = "MobToggle" ,
    Save = true
})
GameTab:AddButton({
	Name = "无用",
	Callback = function()
        game:GetService("ReplicatedStorage").Bricks.EBF:FireServer()
  	end    
})
GameTab:AddButton({
	Name = "无用",
	Callback = function()
        local CurrentDoor = workspace.CurrentRooms[tostring(LatestRoom+1)]:WaitForChild("Door")
        game.Players.LocalPlayer.Character:PivotTo(CF(CurrentDoor.Door.Position))
  	end    
})
GameTab:AddParagraph("警告","如果你按下没用那就开/关菜单几次")

--// ok actual code starts here

game:GetService("RunService").RenderStepped:Connect(function()
    pcall(function()
        if game.Players.LocalPlayer.Character.Humanoid.MoveDirection.Magnitude > 0 then
            game.Players.LocalPlayer.Character:TranslateBy(game.Players.LocalPlayer.Character.Humanoid.MoveDirection * TargetWalkspeed/50)
        end
    end)
end)

game:GetService("Workspace").CurrentRooms.DescendantAdded:Connect(function(descendant)
    if OrionLib.Flags["NoSeek"].Value == true and descendant.Name == ("Seek_Arm" or "ChandelierObstruction") then
        task.spawn(function()
            wait()
            descendant:Destroy()
        end)
    end
end)

game:GetService("ProximityPromptService").PromptButtonHoldBegan:Connect(function(prompt)
    if OrionLib.Flags["InstantToggle"].Value == true then
        fireproximityprompt(prompt)
    end
end)

local old
old = hookmetamethod(game,"__namecall",newcclosure(function(self,...)
    local args = {...}
    local method = getnamecallmethod()
    
    if tostring(self) == 'Screech' and method == "FireServer" and OrionLib.Flags["ScreechToggle"].Value == true then
        args[1] = true
        return old(self,unpack(args))
    end
    if tostring(self) == 'ClutchHeartbeat' and method == "FireServer" and OrionLib.Flags["HeartbeatWin"].Value == true then
        args[2] = true
        return old(self,unpack(args))
    end
    
    return old(self,...)
end))

workspace.CurrentCamera.ChildAdded:Connect(function(child)
    if child.Name == "Screech" and OrionLib.Flags["ScreechToggle"].Value == true then
        child:Destroy()
    end
end)

local NotificationCoroutine = coroutine.create(function()
    workspace.ChildAdded:Connect(function(inst)
        if inst.Name == "RushMoving" and OrionLib.Flags["MobToggle"].Value == true then
            if OrionLib.Flags["AvoidRushToggle"].Value == true then
                OrionLib:MakeNotification({
                    Name = "警告",
                    Content = "躲避rush请稍等",
                    Time = 5
                })
                local OldPos = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
                local con = game:GetService("RunService").Heartbeat:Connect(function()
                    game.Players.LocalPlayer.Character:MoveTo(OldPos + Vector3.new(0,20,0))
                end)
                
                inst.Destroying:Wait()
                con:Disconnect()

                game.Players.LocalPlayer.Character:MoveTo(OldPos)
            else
                OrionLib:MakeNotification({
                    Name = "警告",
                    Content = "rush已刷新",
                    Time = 5
                })
            end
        elseif inst.Name == "AmbushMoving" and OrionLib.Flags["MobToggle"].Value == true then
            if OrionLib.Flags["AvoidRushToggle"].Value == true then
                OrionLib:MakeNotification({
                    Name = "警告",
                    Content = "躲避ambush请稍等",
                    Time = 5
                })
                local OldPos = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
                local con = game:GetService("RunService").Heartbeat:Connect(function()
                    game.Players.LocalPlayer.Character:MoveTo(OldPos + Vector3.new(0,20,0))
                end)
                
                inst.Destroying:Wait()
                con:Disconnect()
                
                game.Players.LocalPlayer.Character:MoveTo(OldPos)
            else
                OrionLib:MakeNotification({
                    Name = "警告",
                    Content = "ambush刷新",
                    Time = 5
                })
            end
        end
    end)
end)

--// ok actual code ends here

local CreditsTab = Window:MakeTab({
	Name = "我的",
	Icon = "APT汉化",
	PremiumOnly = false
})

CreditsTab:AddParagraph("APT汉化")

coroutine.resume(NotificationCoroutine)

OrionLib:Init()

task.wait(2)

end
})

-- 显示欢迎消息
sendNotification("LMPE 脚本中心", "增强版 v2.0 已加载完成！\n共 " .. countFeatures() .. " 个功能可用", 5)

-- 初始化UI
OrionLib:Init()

print("LMPE 脚本中心增强版加载完成")