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
 
local OrionLib = loadstring(game:HttpGet("https://pastebin.com/raw/j9TdK86G"))()

print("初始化成功✅")
print("脚本已运行")
print("版本号为0.3.1")

OrionLib:MakeNotification({
                    Name = "StartOpenLMPE", 
                    Content = "UI正在加载",
                    Time = 3 -- 持续时间
                })    
                local sound = Instance.new("Sound", workspace)
sound.SoundId = "rbxassetid://4590662766"
sound:Play()
wait(1)

print("UI加载成功✅")
print("弹出(StartOpenLMPE-UI正在加载)")

OrionLib:MakeNotification({
                    Name = "StartOpenLMPE", 
                    Content = "UI加载成功",
                    Time = 3 -- 持续时间
                })    
                local sound = Instance.new("Sound", workspace)
sound.SoundId = "rbxassetid://4590662766"
sound:Play()
wait(1)

print("弹出(StartOpenLMPE-UI加载成功)")

OrionLib:MakeNotification({
                    Name = "LMPE", 
                    Content = "防反挂机已自动启动",
                    Time = 3 -- 持续时间
                })    
                local sound = Instance.new("Sound", workspace)
sound.SoundId = "rbxassetid://4590662766"
sound:Play()
wait(1)
print("防反挂机✅")

print("弹出(LMPE-防反挂机已自动启动)")

local vu = game:GetService("VirtualUser")
game:GetService("Players").LocalPlayer.Idled:connect(function()
    vu:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
    wait(1)
    vu:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
end)

print("执行(防反挂机)")

OrionLib:MakeNotification({
                    Name = "LMPE", 
                    Content = "你的注入器是:"..identifyexecutor(),
                    Time = 3 -- 持续时间
                })    
                local sound = Instance.new("Sound", workspace)
sound.SoundId = "rbxassetid://4590662766"
sound:Play()
wait(1)

print("弹出(LMPE-你的注入器是)"..identifyexecutor())

OrionLib:MakeNotification({
                    Name = "LMPE", 
                    Content = "你的用户名是:"..game.Players.LocalPlayer.Character.Name,
                    Time = 3 -- 持续时间
                })    
                local sound = Instance.new("Sound", workspace)
sound.SoundId = "rbxassetid://117280523234960"
sound:Play()

print("弹出(LMPE-你的用户名是)"..game.Players.LocalPlayer.Character.Name)

local Window = OrionLib:MakeWindow({Name = "LMPE", HidePremium = false, SaveConfig = true,IntroText = "欢迎使用LMPE", ConfigFolder = "123"})

print("脚本加载成功✅")
print("创建主UI(LMPE-LMPE-123)")

local announcement = Window:MakeTab({
    Name = "主页",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})
announcement:AddParagraph("作者","LMPE")
announcement:AddLabel("你的注入器:"..identifyexecutor())
announcement:AddLabel("你的用户名:"..game.Players.LocalPlayer.Character.Name)
announcement:AddLabel("你的客户端ID:"..game:GetService("RbxAnalyticsService"):GetClientId())
announcement:AddLabel("当前服务器ID:"..game.GameId)
announcement:AddLabel("你的账号年龄:"..game.Players.LocalPlayer.AccountAge)
announcement:AddLabel("你的账号ID:"..game.Players.LocalPlayer.UserId)

print("创建分类(announcement-主页)")

local currency = Window:MakeTab({
    Name = "通用",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})
currency:AddTextbox({
	Name = "移动速度",
	Default = "", -- 默认值
	TextDisappear = true,
	Callback = function(Value)
print("执行(修改移动速度)")
game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
end
})
currency:AddTextbox({
	Name = "跳跃高度",
	Default = "", -- 默认值
	TextDisappear = true,
	Callback = function(Value)
print("执行(修改跳跃高度)")
game.Players.LocalPlayer.Character.Humanoid.JumpPower = Value
end
})
currency:AddTextbox({
	Name = "重力",
	Default = "", -- 默认值
	TextDisappear = true,
	Callback = function(Value)
print("执行(修改重力)")
game.Workspace.Gravity = Value
end
})
currency:AddToggle({
	Name = "夜视",
	Default = false,
	Callback = function(Value)
    if Value then
	    game.Lighting.Ambient = Color3.new(1, 1, 1)
    else
	    game.Lighting.Ambient = Color3.new(0, 0, 0)
    end
    print("执行切换/预加载(夜视)")
	end
})   
currency:AddButton({
	Name = "飞行V3",
	Callback = function()
print("执行(飞行V3)")
loadstring(game:HttpGet("https://pastebin.com/raw/nkhg0q5K"))()
end
})   
currency:AddButton({
    Name = "建筑工具",
    Callback = function()
        Hammer = Instance.new("HopperBin")
        Hammer.Name = "锤子"
        Hammer.BinType = 4
        Hammer.Parent = game.Players.LocalPlayer.Backpack
        Clone = Instance.new("HopperBin")
        Clone.Name = "克隆"
        Clone.BinType = 3
        Clone.Parent = game.Players.LocalPlayer.Backpack
        Grab = Instance.new("HopperBin")
        Grab.Name = "抓取"
        Grab.BinType = 2
        print("执行(建筑工具)")
    end
})
currency:AddButton({
  Name = "光影-1",
  Default = false,
  Callback = function()
print("执行(光影)")
loadstring(game:HttpGet("https://raw.githubusercontent.com/MZEEN2424/Graphics/main/Graphics.xml"))()
  end
})

print("创建分类(currency-通用)")

local DOORS = Window:MakeTab({
    Name = "DOORS",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
}) 
DOORS:AddButton({
	Name = "LMPE|DOORS",
	Callback = function()

local OrionLib = loadstring(game:HttpGet(("https://pastebin.com/raw/j9TdK86G")))()
local Window = OrionLib:MakeWindow({IntroText = "LMPEDOORS脚本",Name = "LMPEDOORS", HidePremium = false, SaveConfig = true, ConfigFolder = "DoorsSex"})
if game.PlaceId == 6516141723 then
    OrionLib:MakeNotification({
        Name = "错误",
        Content = "此脚本不能在大厅执行",
        Time = 5
    })
end
local VisualsTab = Window:MakeTab({
	Name = "ESP",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

local CF = CFrame.new
local LatestRoom = game:GetService("ReplicatedStorage").GameData.LatestRoom

local KeyChams = {}
VisualsTab:AddToggle({
	Name = "钥匙ESP",
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
	Name = "50关书ESPBUG",
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
	Name = "50关FigureESP",
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
CharTab:AddTextbox({
	Name = "移动速度[Rooms建议调成21]",
	Default = "", -- 默认值
	TextDisappear = true,
	Callback = function(Value)
print("执行(修改移动速度[Rooms建议调成21])")
game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
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
	Name = "自动过门",
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

GameTab:AddToggle({
	Name = "没有跳杀",
	Callback = function()
        pcall(function()
            game:GetService("ReplicatedStorage").Bricks.Jumpscare:Destroy()
        end)
  	end    
})
GameTab:AddToggle({
	Name = "自动躲避Rush/Ambush",
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
GameTab:AddToggle({
	Name = "过100门铁盒子Hotel-有用",
	Callback = function()
        game:GetService("ReplicatedStorage").Bricks.EBF:FireServer()
  	end    
})
GameTab:AddToggle({
	Name = "过50门",
	Callback = function()
        local CurrentDoor = workspace.CurrentRooms[tostring(LatestRoom+1)]:WaitForChild("Door")
        game.Players.LocalPlayer.Character:PivotTo(CF(CurrentDoor.Door.Position))
  	end    
})
GameTab:AddParagraph("警告","没有警告🤫")

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
                    Name = "自动躲避",
                    Content = "正在自动躲避Rush请稍等",
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
                    Name = "通知",
                    Content = "Rush已刷新",
                    Time = 5
                })
            end
        elseif inst.Name == "AmbushMoving" and OrionLib.Flags["MobToggle"].Value == true then
            if OrionLib.Flags["AvoidRushToggle"].Value == true then
                OrionLib:MakeNotification({
                    Name = "自动躲避",
                    Content = "正在自动躲避Ambush请稍等",
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
                    Name = "通知",
                    Content = "Ambush刷新",
                    Time = 5
                })
            end
        end
    end)
end)

--// ok actual code ends here

local CreditsTab = Window:MakeTab({
	Name = "我的",
	Icon = "LMPE",
	PremiumOnly = false
})

CreditsTab:AddParagraph("LMPE")

coroutine.resume(NotificationCoroutine)

OrionLib:Init()

task.wait(2)

end
})
DOORS:AddButton({
	Name = "传送到Rooms无法使用",
	Callback = function()

local game_id = 2440500124
        local game_url = "https://www.roblox.com/games/"..game_id
        game:GetService("TeleportService"):Teleport(game_id, game.Players.LocalPlayer)

end
})


print("创建分类(DOORS-DOORS)")








