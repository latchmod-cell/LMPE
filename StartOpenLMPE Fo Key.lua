-- 在脚本中使用
local NeoUI =  -- 假设脚本路径

-- 创建示例UI
NeoUI:CreateExampleUI()

-- 或者单独创建组件
local screenGui = NeoUI:CreateScreenGui("MyUI")
local window, content = NeoUI:CreateWindow("MyWindow", screenGui, "我的窗口")

-- 在窗口中添加按钮
local button = NeoUI:CreateButton("MyButton", content, "点击我")
button.MouseButton1Click:Connect(function()
    print("按钮被点击!")
end)