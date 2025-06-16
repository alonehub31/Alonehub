-- Clear previous GUI if exists
if game.CoreGui:FindFirstChild("FakeFruitRain") then
    game.CoreGui.FakeFruitRain:Destroy()
end

-- Opening Screen
local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "FakeFruitRain"
gui.ResetOnSpawn = false

local background = Instance.new("Frame", gui)
background.Size = UDim2.new(1, 0, 1, 0)
background.BackgroundColor3 = Color3.fromRGB(30, 0, 40)

local title = Instance.new("TextLabel", background)
title.Size = UDim2.new(1, 0, 1, 0)
title.BackgroundTransparency = 1
title.Text = "WELCOME TO AL0NE HUB FRUIT RAIN"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextScaled = true
title.Font = Enum.Font.GothamBold

wait(3)

-- Loading bar
title.Text = "Loading..."
local bar = Instance.new("Frame", background)
bar.AnchorPoint = Vector2.new(0.5, 0.5)
bar.Position = UDim2.new(0.5, 0, 0.8, 0)
bar.Size = UDim2.new(0.6, 0, 0.05, 0)
bar.BackgroundColor3 = Color3.fromRGB(60, 60, 60)

local fill = Instance.new("Frame", bar)
fill.BackgroundColor3 = Color3.fromRGB(120, 0, 255)
fill.Size = UDim2.new(0, 0, 1, 0)

fill:TweenSize(UDim2.new(1, 0, 1, 0), Enum.EasingDirection.InOut, Enum.EasingStyle.Quad, 5, true)

wait(5)

-- Hide opening GUI
gui.Enabled = false

-- Main GUI
local mainGui = Instance.new("ScreenGui", game.CoreGui)
mainGui.Name = "FruitRainGui"

local mainFrame = Instance.new("Frame", mainGui)
mainFrame.Position = UDim2.new(0.3, 0, 0.25, 0)
mainFrame.Size = UDim2.new(0, 400, 0, 300)
mainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true

local titleText = Instance.new("TextLabel", mainFrame)
titleText.Size = UDim2.new(1, 0, 0, 40)
titleText.BackgroundTransparency = 1
titleText.Text = "AL0NE HUB - FRUIT RAIN"
titleText.TextColor3 = Color3.fromRGB(255, 255, 255)
titleText.Font = Enum.Font.GothamBold
titleText.TextSize = 20

-- Close button
local closeBtn = Instance.new("TextButton", mainFrame)
closeBtn.Text = "X"
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(1, -35, 0, 5)
closeBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.MouseButton1Click:Connect(function()
    mainGui.Enabled = false
end)

-- Open GUI button
local openBtn = Instance.new("TextButton", mainGui)
openBtn.Size = UDim2.new(0, 100, 0, 30)
openBtn.Position = UDim2.new(0, 10, 0.9, 0)
openBtn.Text = "Open GUI"
openBtn.BackgroundColor3 = Color3.fromRGB(50, 0, 100)
openBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
openBtn.MouseButton1Click:Connect(function()
    mainGui.Enabled = true
end)

-- Fruit Rain Folder
local folder = Instance.new("Frame", mainFrame)
folder.Position = UDim2.new(0, 0, 0, 50)
folder.Size = UDim2.new(1, 0, 1, -50)
folder.BackgroundTransparency = 1

-- Rain button
local rainBtn = Instance.new("TextButton", folder)
rainBtn.Size = UDim2.new(0, 200, 0, 40)
rainBtn.Position = UDim2.new(0.5, -100, 0, 10)
rainBtn.Text = "Click here for Fruit Rain"
rainBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 200)
rainBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
rainBtn.Font = Enum.Font.Gotham
rainBtn.TextSize = 16

-- Fake Fruit Function
local function spawnFakeFruit(name, position)
    local fruit = Instance.new("Tool")
    fruit.Name = name
    fruit.RequiresHandle = true

    local handle = Instance.new("Part")
    handle.Name = "Handle"
    handle.Size = Vector3.new(1.5, 1.5, 1.5)
    handle.Position = position
    handle.Anchored = false
    handle.CanCollide = true
    handle.Transparency = 0
    handle.Parent = fruit

    local mesh = Instance.new("SpecialMesh", handle)
    mesh.MeshType = Enum.MeshType.Sphere
    mesh.Scale = Vector3.new(1.2, 1.2, 1.2)

    fruit.Parent = workspace
end

-- Fruit Rain Trigger
rainBtn.MouseButton1Click:Connect(function()
    for i = 1, 25 do
        local fruitList = {"Dragon", "Dough", "Kitsune", "Leopard", "Portal"}
        local fruitName = fruitList[math.random(1, #fruitList)]
        local pos = Vector3.new(math.random(-100, 100), math.random(50, 100), math.random(-100, 100))
        spawnFakeFruit(fruitName, pos)
        wait(0.2)
    end
end)
