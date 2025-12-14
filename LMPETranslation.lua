    local CONFIG = {
    TRANSLATE_DELAY = 0.2, -- 进一步减少延迟
    NOTIFICATION_DURATION = 3,
    GUI_SCAN_DELAY = 0.02, -- 大幅减少GUI扫描延迟
    BATCH_PROCESS_SIZE = 50 -- 批量处理大小，避免卡顿
}

-- 缓存常用服务
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")
local RunService = game:GetService("RunService")

-- 本地玩家引用
local LocalPlayer = Players.LocalPlayer

-- 翻译字典 (保持原有翻译字典)
local Translations = {
    ["General"] = "主页",
    ["Player"] = "玩家",
    ["Lock"] = "锁定",
    ["unlock"] = "解锁",
    ["Exploits"] = "漏洞",
    ["Visuals"] = "视觉",
    ["Floor"] = "楼层",
    ["Fun"] = "娱乐",
    ["Auto Rooms"] = "自动rooms",
    ["Play Walking"] = "行走路径",
    ["Notify Anchor Code"] = "通知锚点代码",
    ["Remove Figure (FE)"] = "移除Figure(FE)",
    ["Anti Bridge Fall"] = "防止桥梁坠落",
    ["Show Seek Path"] = "显示Seek路径", 
    ["Anticheat Bypass"] = "绕过反作弊",
    ["Fuse"] = "保险丝",
    ["Recommended Speed 45-50，No Enable"] = "推荐速度在45-40，不要启用",
    ["Configuration"] = "配置",
    ["Addons"] = "插件",
    ["Keybinds"] = "按键",
    ["Anti Features"] = "反制功能",
    ["Anti-AFK"] = "反挂机检测",
    ["Anti-Lag"] = "低画质模式",
    ["Anti-Cutscenes"] = "跳过过场动画",
    ["Door Reach Range"] = "开门范围调节",
    ["Anti-Heartbeat-Minigame"] = "跳过心跳小游戏",
    ["Anti-Dread"] = "反Dread实体",
    ["Anti-Screech"] = "反Screech实体",
    ["Anti-A90"] = "反A-90实体",
    ["Anti-Eyes"] = "反Eyes实体",
    ["Anti-Snare"] = "反地刺实体",
    ["Anti-Blur"] = "反模糊效果",
    ["Anti-Dupe"] = "反假门",
    ["Anti-Figure-Hearing"] = "反Figure听觉",
    ["Anti-Halt"] = "反Halt实体",
    ["Infinite Items"] = "无限物品",
    ["Infinite Crucifixs"] = "无限十字架",
    ["Infinite Lockpicks / SkeletonKey"] = "无限开锁工具/骷髅钥匙",
    ["Infinite Shears"] = "无限剪刀",
    ["Bypass"] = "绕过",
    ["Speed Bypass Method"] = "速度绕过方法",
    ["Method 1"] = "方法1",
    ["Method 2"] = "方法2",
    ["Speed Bypass"] = "速度绕过",
    ["Speed Bypass Interval"] = "速度绕过间隔",
    ["Godmode Dropdown"] = "上帝模式菜单",
    ["Toggle"] = "切换",
    ["Godmode Range"] = "无敌启用范围",
    ["God Mode"] = "无敌模式",
    ["Anti Cheat Manipulation Speed"] = "无拉回穿墙速度",
    ["Anti Cheat Manipulation"] = "无拉回穿墙",
    ["Use Tools Anywhere"] = "随处使用工具",
    ["Troll"] = "恶搞",
    ["Remove Doors (FE)"] = "移除门(FE)",
    ["Notify"] = "通知",
    ["Notify Oxygen"] = "氧气通知",
    ["Client Sided Entities"] = "生成实体（无伤害）",
    ["Spawn Dread"] = "生成恐惧实体",
    ["Spawn A90"] = "生成A-90实体",
    ["Spawn Screech"] = "生成Screech实体",
    ["Spawn Giltch"] = "生成Glitch实体",
    ["Get Items"] = "获取物品",
    ["Crucifix Made By PenguinManiack"] = "十字架由PenguinManiack制作",
    ["Press Q To Activate the Crucifix"] = "按Q激活十字架",
    ["Crucifix Fails"] = "十字架失效",
    ["Crucifix Uses"] = "十字架使用",
    ["spawn Glitch"] = "生成Glitch",
    ["Crucifix Range"] = "十字架范围",
    ["Crucifix Anything"] = "封印任何物品",
    ["Crucifix Falls"] = "十字架掉落",
    ["Get Crucifix"] = "获取十字架",
    ["Get Keyboard Script"] = "启用键盘脚本",
    ["Themes"] = "主题",
    ["Background color"] = "背景颜色",
    ["Main color"] = "主颜色",
    ["Accent color"] = "强调色",
    ["Outline color"] = "轮廓颜色",
    ["Font color"] = "字体颜色",
    ["Font Face"] = "字体",
    ["Theme list"] = "主题列表",
    ["Default"] = "默认",
    ["Set as default"] = "设为默认",
    ["Custom theme name"] = "自定义主题名称",
    ["Create theme"] = "创建主题",
    ["Custom themes"] = "自定义主题",
    ["Load theme"] = "加载主题",
    ["Overwrite theme"] = "覆盖主题",
    ["Delete theme"] = "删除主题",
    ["Refresh list"] = "刷新列表",
    ["Reset default"] = "重置默认",
    ["Config name"] = "配置名称",
    ["Create config"] = "创建配置",
    ["Config list"] = "配置列表",
    ["Load config"] = "加载配置",
    ["Overwrite config"] = "覆盖配置",
    ["Delete config"] = "删除配置",
    ["Set as autoload"] = "设为自动加载",
    ["Reset autoload"] = "重置自动加载",
    ["Current autoload config"] = "当前自动加载配置",
    ["Speed Boost Slider"] = "速度增强滑块",
    ["Speed Boost"] = "速度增强",
    ["No clip"] = "穿墙模式",
    ["Enable Jump"] = "启用跳跃",
    ["Infinite Jump"] = "无限跳跃",
    ["Instant Interacts"] = "瞬间互动",
    ["No Acceleration"] = "无加速度",
    ["No Closet Exit Delay"] = "无柜子退出延迟",
    ["Fly Speed"] = "飞行速度",
    ["Fly"] = "飞行",
    ["Buttons"] = "按钮",
    ["Reset"] = "自我了结",
    ["Play again"] = "再玩一次",
    ["Lobby"] = "返回大厅",
    ["Revive"] = "使用复活",
    ["No Footer"] = "Qcumber100汉化",
    ["Automation"] = "自动化",
    ["Auto Interact"] = "自动互动",
    ["Ignore List"] = "忽略列表",
    ["Jeff Items"] = "Jeff物品",
    ["Auto Interact Interval"] = "自动互动间隔",
    ["Auto Painting"] = "自动画房",
    ["Auto Get Glitch Fragment"] = "自动获取故障碎片",
    ["Unlock Padlock Distance"] = "解锁挂锁距离",
    ["Auto Library Code"] = "自动图书馆代码",
    ["Notify Library Code"] = "通知图书馆代码",
    ["Bruteforce Library Code"] = "暴力破解图书馆代码",
    ["Works with only 3 digits or less"] = "暴力解锁仅适用于3位或更少数字",
    ["Ignore Candys"] = "忽略糖果",
    ["Auto Eat Candys"] = "自动吃糖果",
    ["Auto Breaker Box"] = "自动断路器箱",
    ["Auto Closet"] = "自动躲柜子",
    ["Auto Spam Jack"] = "自动刷Jack",
    ["Prompt Clip"] = "隔墙互动",
    ["Prompt Reach"] = "互动范围",
    ["Menu"] = "菜单",
    ["Open Keybind Menu"] = "打开按键绑定菜单",
    ["Play Sound"] = "播放声音",
    ["Notification Side"] = "通知位置",
    ["Right"] = "右侧",
    ["you don't have enough"] = "你没有足够的",
    ["Custom Cursor"] = "自定义光标",
    ["DPI Scale"] = "DPI缩放",
    ["Menu bind"] = "菜单绑定",
    ["Unload GUI"] = "卸载GUI",
    ["Upload GUI"] = "上传GUI",
    ["Settings"] = "设置",
    ["Enable Show Distances"] = "启用显示距离",
    ["Enable Tracers"] = "启用追踪器",
    ["Transparent"] = "透明度",
    ["Transparency Slider"] = "透明度滑块",
    ["Transparency Closet"] = "储物柜透明度",
    ["Transparency Cart"] = "手推车透明度",
    ["Entities"] = "实体",
    ["Entity Notifys"] = "实体通知",
    ["Key"] = "钥匙",
    ["Closet"] = "储物柜",
    ["Gate Lever"] = "门闸杠杆",
    ["Players"] = "玩家",
    ["Books"] = "书籍",
    ["Breaker"] = "断路器",
    ["Items"] = "物品",
    ["Gold"] = "黄金",
    ["Camera"] = "相机",
    ["No Camera Shake"] = "无相机抖动",
    ["Witnessed's Offset"] = "观察者偏移",
    ["Viewmodel Offset"] = "视图模型偏移",
    ["Third Person"] = "第三人称",
    ["Spectate Entity"] = "观察实体",
    ["FOV Slider"] = "视野滑块",
    ["FOV"] = "视野",
    ["Ambient"] = "环境光",
    ["Fullbright"] = "全亮",
    ["Anti Fog"] = "反雾效",
    ["Entites Bypass"] = "实体绕过",
    ["Anti Nanner Banana"] = "防止踩香蕉",
    ["Anti Seek-Obstructions"] = "反Seek障碍物",
    ["Modifiers"] = "修改器",
    ["Death Farm"] = "死亡农场",
    ["Anti Lookman"] = "反Lookman",
    ["Anti Giggle"] = "反Giggle",
    ["Anti Jamming"] = "反Jamming",
    ["Anti Gloom Egg"] = "反Gloom蛋",
    ["Anti Vacuum"] = "反真空门",
    ["ESP"] = "增强视觉",
    ["Timer Lever"] = "计时器杠杆",
    ["Search"] = "搜索",
    ["Programmer"] = "程序员",
    ["Join msdoors Discord"] = "加入msdoors Discord",
    ["Legend"] = "图例",
    ["Notes"] = "备注",
    ["Less Value More Freeze when opening door but faster processing things"] = "数值越小开门时冻结越多但处理速度更快",
    ["Join Discord"] = "加入Discord",
    ["Godmode Dropdown"] = "上帝模式下拉菜单",
    ["Chest"] = "箱子",
    ["Vine"] = "藤蔓",
    ["Lighter"] = "打火机",
    ["Flashlight"] = "手电筒",
    ["Vitamins"] = "维他命",
    ["Crucifix"] = "十字架",
    ["Skeleton Key"] = "骷髅钥匙",
    ["Gummy Flashlight"] = "手摇手电筒",
    ["Candle"] = "蜡烛",
    ["Moonlight Candle"] = "月光蜡烛",
    ["Star Vial"] = "星光小瓶",
    ["Star Bottle"] = "星光瓶",
    ["Star Jug"] = "星光桶",
    ["Laser Pointer"] = "激光笔",
    ["Battery Pack"] = "电池包",
    ["Bandage Pack"] = "绷带包",
    ["Shears"] = "剪刀",
    ["Toolshed"] = "工具棚",
    ["Glowstick"] = "荧光棒",
    ["Spotlight"] = "大灯",
    ["Straplight"] = "肩灯",
    ["Dumpster"] = "垃圾桶",
    ["Alarm Clock"] = "闹钟",
    ["Smoohie"] = "啤酒",
    ["Moonlight Smoohie"] = "月光啤酒",
    ["Gween Soda"] = "绿色汽水",
    ["Bread"] = "面包",
    ["Cheese"] = "奶酪",
    ["Donut"] = "甜甜圈",
    ["Aloe"] = "芦荟",
    ["Compass"] = "罗盘",
    ["Lantern"] = "灯笼",
    ["Lotus Petal"] = "莲花",
    ["Iron Key"] = "铁钥匙",
    ["Multi Tool"] = "多功能工具",
    ["Tip Jar"] = "小费罐",
    ["Rift Jar"] = "裂隙罐",
    ["Puzzle Painting"] = "拼图画",
    ["Library Paper"] = "密码纸",
    ["Breaker"] = "断路器",
    ["Generator Fuse"] = "保险丝",
    ["Lotus Petal"] = "花瓣",
    ["Battery"] = "电池",
    ["Bandage"] = "绷带",
    ["Glitch Fragment"] = "故障碎片",
    ["Lever"] = "拉杆",
    ["Time Lever"] = "计时器杆",
    ["Star Dust"] = "星尘",
    ["Generator"] = "发电机",
    ["Door Key"] = "门钥匙",
    ["Anchor"] = "锚点",
    ["Book"] = "书",
    ["Electrical Key"] = "配电室钥匙",
    ["Gate"] = "大门",
    ["Button"] = "按钮",
    ["Water Pump"] = "水阀",
    ["Pipe"] = "水管",
    ["Bed"] = "床",
    ["Double Bed"] = "双人床",
    ["Closet"] = "衣柜",
    ["Locker"] = "铁柜",
    ["Mouse Hole"] = "老鼠洞",
    ["Item Locker"] = "物品柜",
    ["Herb of Viridis"] = "药草",
    ["Gold"] = "黄金",
    ["Stardust Pile"] = "星尘",
    ["Vacuum"] = "虚空",
    ["THE EVIL KEY"] = "邪恶的钥匙",
    ["Hole"] = "洞",
    ["Snare"] = "陷阱",
    ["Ladder"] = "梯子",
    ["Toolbox"] = "工具箱",
    ["Fridge Locker"] = "冰箱柜",
    ["Vine Lever"] = "藤蔓断头台",
    ["Vial of Starlight"] = "星光小瓶",
    ["Bottle of Starlight"] = "星光瓶",
    ["Barrel of Starlight"] = "星光桶",
    ["Win Shield"] = "胜利护盾",
    ["Big Shield Potion"] = "大护盾药水",
    ["Small Shield Potion"] = "小护盾药水",
    ["Holy Hand Grenade"] = "神圣手雷",
    ["Max Players"] = "最大玩家数量",
    ["Modifiers"] = "修饰符",
    ["Destination"] = "目的地",
    ["Friends Only"] = "仅限好友",
    ["Create Elevator"] = "创建电梯",
    ["Import from Game UI"] = "从游戏UI导入",
    ["Damage"] = "伤害",
    ["Elevator name"] = "电梯名称",
    ["Create elevator"] = "创建电梯",
    ["Saved elevators"] = "已保存的电梯",
    ["Load elevator"] = "载入电梯",
    ["Overwrite elevator"] = "覆盖电梯",
    ["Delete elevator"] = "删除电梯",
    ["Auto Join Elevator"] = "自动加入电梯",
    ["Redeem all Codes"] = "兑换所有代码",
    ["Rejoin Server"] = "重新加入服务器",
    ["Cycle Delay"] = "周期延迟",
    ["Cycle Achievements"] = "循环成就",
    ["Pivot"] = "鬼步法",
    ["Velocity"] = "直穿法",
    ["Infinite"] = "无限",
    ["Item List"] = "物品列表",
    ["Lockpick"] = "撬锁器",
    ["Skeleton Key"] = "骷髅钥匙",
    ["Shears"] = "剪刀",
    ["Toolbox"] = "工具箱",
    ["Toolshed"] = "工具棚",
    ["Multitool"] = "多功能工具",
    ["Door"] = "门",
    ["Doors"] = "门",
    ["Noclip"] = "启用穿墙",
    ["has spawned"] = "已生成",
    ["Automatically Enabled Anti-Figure Hearing Needs to enable for godmode to work"] = "启用“反Figure听觉”才能使上帝模式生效！",
    ["side"] = "尺寸",
    ["This painting is titled"] = "这幅画标题为",
    ["avoid looking at it"] = "避免直视它",
    ["Creation on an Android 6 USB and app"] = "在Android 6 USB和设备上创建",
    ["Failed to load autoload config"] = "加载自动配置失败",
    ["Delay added"] = "添加延迟",
    ["Loaded in"] = "耗时",
    ["Door Reach"] = "开门范围",
    ["Are you sure"] = "你确定",
    ["Oxygen GUI Side Position"] = "氧气通知位置大小",
    ["CONFIRM"] = "继续",
    ["PRE-RUN SHOP"] = "准备商店",
    ["skip the key"] = "我，无“锁”不能！",
    ["temporarily boosts speed"] = "话说为什么一瓶药只能吃一口",
    ["Batteries included"] = "照亮你的美。",
    ["Basic temporary light source"] = "普通打火机，貌似可以点燃些东西",
    ["5X KNOBS BOOST"] = "5X 门把手（真有人买吗）",
    ["LASTS ONE FLOOR. ADDS 500% MULTIPLIER TO KNOBS"] = "不要99，不要88，只要49，五倍门把手带回家！",
    ["Shortcuts & easy loot"] = "剪！剪！剪！",
    ["It works here!"] = "十字架，横扫户外，做回自己！",
    ["HOLD"] = "长按",
    ["Reach"] = "互动",
    ["Ignore"] = "忽略",
    ["This is what a notification will look like."] = "通知就长这样。",
    ["LMPE"] = "LMPE",
    ["LMHUB"] = "LMHUB",
}

-- 缓存已翻译的对象
local TranslatedObjects = setmetatable({}, {__mode = "k"})

-- 优化的通知系统
local function showNotification(message)
    local success, result = pcall(function()
        local ScreenGui = Instance.new("ScreenGui")
        ScreenGui.Name = "TranslationNotification"
        ScreenGui.Parent = CoreGui
        ScreenGui.ResetOnSpawn = false

        local Frame = Instance.new("Frame")
        Frame.Size = UDim2.new(0, 300, 0, 100)
        Frame.Position = UDim2.new(0.5, -150, 0.5, -50)
        Frame.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
        Frame.BorderColor3 = Color3.new(0.3, 0.3, 0.3)
        Frame.BorderSizePixel = 2
        Frame.Active = true
        Frame.Draggable = true
        Frame.Parent = ScreenGui

        local TextLabel = Instance.new("TextLabel")
        TextLabel.Size = UDim2.new(1, 0, 0.8, 0)
        TextLabel.Position = UDim2.new(0, 0, 0, 0)
        TextLabel.BackgroundTransparency = 1
        TextLabel.Text = message
        TextLabel.TextColor3 = Color3.new(1, 1, 1)
        TextLabel.TextScaled = true
        TextLabel.Parent = Frame

        local CloseButton = Instance.new("TextButton")
        CloseButton.Size = UDim2.new(1, 0, 0.2, 0)
        CloseButton.Position = UDim2.new(0, 0, 0.8, 0)
        CloseButton.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
        CloseButton.Text = "关闭"
        CloseButton.TextColor3 = Color3.new(1, 1, 1)
        CloseButton.Parent = Frame
        
        CloseButton.MouseButton1Click:Connect(function()
            ScreenGui:Destroy()
        end)

        task.delay(CONFIG.NOTIFICATION_DURATION, function()
            if ScreenGui and ScreenGui.Parent then
                ScreenGui:Destroy()
            end
        end)
        
        return ScreenGui
    end)
    
    if not success then
        warn("通知创建失败:", result)
    end
end

-- 优化的文本翻译函数
local function translateText(text)
    if not text or type(text) ~= "string" or text == "" then 
        return text 
    end
    
    -- 预处理文本
    local processedText = text:lower():gsub("%s+", " "):gsub("^%s+", ""):gsub("%s+$", "")
    
    -- 精确匹配优先
    for en, cn in pairs(Translations) do
        local enLower = en:lower()
        if processedText == enLower or processedText == enLower .. ":" then
            return cn
        end
    end
    
    -- 部分匹配
    for en, cn in pairs(Translations) do
        if text:lower():find(en:lower(), 1, true) then
            local escapedPattern = en:gsub("([%(%)%.%+%-%*%?%[%]%^%$%%])", "%%%1")
            local result = text:gsub(escapedPattern, cn, 1)
            if result ~= text then
                return result
            end
        end
    end
    
    return text
end

-- 立即翻译单个GUI元素（无延迟）
local function translateGuiElementImmediately(gui)
    if TranslatedObjects[gui] then return false end
    
    local success, originalText = pcall(function()
        return gui.Text
    end)
    
    if not success or not originalText or originalText == "" then
        TranslatedObjects[gui] = true
        return false
    end
    
    local translationSuccess, translatedText = pcall(function()
        return translateText(originalText)
    end)
    
    if translationSuccess and translatedText and translatedText ~= originalText then
        local setSuccess, setError = pcall(function()
            gui.Text = translatedText
        end)
        
        if setSuccess then
            TranslatedObjects[gui] = true
            return true
        else
            warn("设置文本失败:", setError)
        end
    end
    
    TranslatedObjects[gui] = true
    return false
end

-- 批量立即翻译容器内的所有GUI元素
local function batchTranslateContainerImmediately(container)
    if not container then return 0 end
    
    local translatedCount = 0
    local elementsToTranslate = {}
    
    -- 收集所有需要翻译的元素
    local success, descendants = pcall(function()
        return container:GetDescendants()
    end)
    
    if not success then return 0 end
    
    for _, descendant in ipairs(descendants) do
        if (descendant:IsA("TextLabel") or descendant:IsA("TextButton") or descendant:IsA("TextBox")) and not TranslatedObjects[descendant] then
            table.insert(elementsToTranslate, descendant)
        end
    end
    
    -- 批量处理，避免卡顿
    for i = 1, #elementsToTranslate, CONFIG.BATCH_PROCESS_SIZE do
        local batchEnd = math.min(i + CONFIG.BATCH_PROCESS_SIZE - 1, #elementsToTranslate)
        
        for j = i, batchEnd do
            local element = elementsToTranslate[j]
            if translateGuiElementImmediately(element) then
                translatedCount = translatedCount + 1
            end
        end
        
        -- 小延迟避免阻塞主线程
        if batchEnd < #elementsToTranslate then
            RunService.Heartbeat:Wait()
        end
    end
    
    return translatedCount
end

-- 设置文本变化监听（立即响应）
local function setupTextChangeListener(gui)
    if not gui:IsA("TextLabel") and not gui:IsA("TextButton") and not gui:IsA("TextBox") then
        return
    end
    
    local connection
    connection = gui:GetPropertyChangedSignal("Text"):Connect(function()
        -- 立即响应，无延迟
        if not gui or not gui.Parent then
            if connection then
                connection:Disconnect()
            end
            return
        end
        
        local success, result = pcall(function()
            local currentText = gui.Text
            if currentText and currentText ~= "" then
                local translatedText = translateText(currentText)
                if translatedText ~= currentText then
                    gui.Text = translatedText
                end
            end
        end)
        
        if not success then
            warn("文本变化监听失败:", result)
        end
    end)
end

-- 设置容器监听器（新元素立即翻译）
local function setupContainerListener(container)
    if not container then return end
    
    container.DescendantAdded:Connect(function(descendant)
        -- 立即处理新元素，无延迟
        if descendant:IsA("TextLabel") or descendant:IsA("TextButton") or descendant:IsA("TextBox") then
            translateGuiElementImmediately(descendant)
            setupTextChangeListener(descendant)
        end
    end)
end

-- 增强的元表劫持（立即生效）
local function setupEnhancedMetatableHijack()
    return pcall(function()
        local mt = getrawmetatable(game)
        if not mt then return false end
        
        local oldNewIndex = mt.__newindex
        if not oldNewIndex then return false end
        
        setreadonly(mt, false)
        
        mt.__newindex = newcclosure(function(t, k, v)
            if (t:IsA("TextLabel") or t:IsA("TextButton") or t:IsA("TextBox")) and k == "Text" then
                local original = tostring(v)
                local translated = translateText(original)
                if original ~= translated then
                    v = translated
                end
            end
            return oldNewIndex(t, k, v)
        end)
        
        setreadonly(mt, true)
        return true
    end)
end

-- 主翻译引擎 - 立即更新所有现有文本
local function setupTranslationEngine()
    local totalTranslated = 0
    
    -- 首先设置元表劫持（如果可用）
    local metatableSuccess = setupEnhancedMetatableHijack()
    
    -- 获取所有需要扫描的容器
    local containers = {CoreGui}
    
    local playerGuiSuccess, playerGui = pcall(function()
        return LocalPlayer.PlayerGui
    end)
    if playerGuiSuccess then
        table.insert(containers, playerGui)
    end
    
    local starterGuiSuccess = pcall(function()
        return StarterGui
    end)
    if starterGuiSuccess then
        table.insert(containers, StarterGui)
    end
    
    -- 立即批量翻译所有现有文本
    for _, container in ipairs(containers) do
        if container then
            local count = batchTranslateContainerImmediately(container)
            totalTranslated = totalTranslated + count
            print("容器翻译完成:", container.Name, "翻译了", count, "个元素")
        end
    end
    
    -- 设置新元素监听
    for _, container in ipairs(containers) do
        if container then
            setupContainerListener(container)
            
            -- 为新容器中的现有元素也设置监听
            local success, descendants = pcall(function()
                return container:GetDescendants()
            end)
            if success then
                for _, descendant in ipairs(descendants) do
                    if descendant:IsA("TextLabel") or descendant:IsA("TextButton") or descendant:IsA("TextBox") then
                        setupTextChangeListener(descendant)
                    end
                end
            end
        end
    end
    
    if not metatableSuccess then
        warn("元表劫持失败，使用GUI扫描方案")
    end
    
    return totalTranslated
end

-- 主执行流程
local function main()
    task.wait(CONFIG.TRANSLATE_DELAY)
    
    local startTime = os.clock()
    local success, result = pcall(function()
        return setupTranslationEngine()
    end)
    
    local endTime = os.clock()
    local elapsedTime = endTime - startTime
    
    if success then
        local translatedCount = result or 0
        local message = string.format("翻译引擎加载完成 \n已立即翻译 %d 个文本元素\n耗时: %.2f 秒", translatedCount, elapsedTime)
        showNotification(message)
        print("＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝")
        print("翻译引擎加载成功 v0.4\n欢迎使用此汉化脚本")
        print("立即翻译了", translatedCount, "个文本元素")
        print("耗时:", string.format("%.2f", elapsedTime), "秒")
        print("＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝")
    else
        showNotification("翻译引擎加载失败")
        warn("翻译引擎加载失败:", result)
    end
end

-- 立即启动
main()

loadstring(game:HttpGet("https://raw.githubusercontent.com/latchmod-cell/LMPE/refs/heads/main/LMHUB.lua"))()
