--// Fake Fruit Rain Script (AL0NE HUB - English Version)
if game.CoreGui:FindFirstChild("FakeFruitRain") then
    game.CoreGui.FakeFruitRain:Destroy()
end

local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "FakeFruitRain"
gui.ResetOnSpawn = false

--// Loading Screen
local loadingFrame = Instance.new("Frame", gui)
loadingFrame.Size = UDim2.new(1, 0, 1, 0)
loadingFrame.BackgroundColor3 = Color3.fromRGB(20, 0, 30)

local welcomeText = Instance.new("TextLabel", loadingFrame)
welcomeText.Size = UDim2.new(1, 0, 0.2, 0)
welcomeText.Position = UDim2.new(0, 0, 0.4, 0)
welcomeText.BackgroundTransparency = 1
welcomeText.Text = "WELCOME TO AL0NE HUB - FRUIT RAIN"
welcomeText.TextColor3 = Color3.fromRGB(200, 0, 255)
welcomeText.Font = Enum.Font.GothamBlack
welcomeText.TextScaled = true

local loadingBarBG = Instance.new("Frame", loadingFrame)
loadingBarBG.Size = UDim2.new(0.6, 0, 0.05, 0)
loadingBarBG.Position = UDim2.new(0.2, 0, 0.7, 0)
loadingBarBG.BackgroundColor3 = Color3.fromRGB(60, 0, 90)
loadingBarBG.BorderSizePixel = 0

local loadingBar = Instance.new("Frame", loadingBarBG)
loadingBar.BackgroundColor3 = Color3.fromRGB(255, 0, 255)
loadingBar.Size = UDim2.new(0, 0, 1, 0)
loadingBar.BorderSizePixel = 0

-- Progress bar animation
for i = 1, 100 do
	wait(0.05)
	loadingBar.Size = UDim2.new(i / 100, 0, 1, 0)
end

loadingFrame:Destroy()

--// Main GUI
local mainFrame = Instance.new("Frame", gui)
mainFrame.Size = UDim2.new(0, 450, 0, 320)
mainFrame.Position = UDim2.new(0.5, -225, 0.5, -160)
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
mainFrame.BorderSizePixel = 0
mainFrame.Visible = true
mainFrame.Active = true
mainFrame.Draggable = true

local title = Instance.new("TextLabel", mainFrame)
title.Size = UDim2.new(1, 0, 0, 40)
title.Text = "AL0NE HUB - FRUIT RAIN"
title.TextColor3 = Color3.fromRGB(255, 0, 255)
title.BackgroundColor3 = Color3.fromRGB(30, 0, 40)
title.Font = Enum.Font.GothamBold
title.TextScaled = true

local folder = Instance.new("Frame", mainFrame)
folder.Size = UDim2.new(1, -20, 1, -80)
folder.Position = UDim2.new(0, 10, 0, 60)
folder.BackgroundColor3 = Color3.fromRGB(35, 0, 50)
folder.BorderSizePixel = 0

local folderTitle = Instance.new("TextLabel", folder)
folderTitle.Size = UDim2.new(1, 0, 0, 30)
folderTitle.Text = "fruit rain"
folderTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
folderTitle.BackgroundTransparency = 1
folderTitle.Font = Enum.Font.GothamMedium
folderTitle.TextScaled = true

local button = Instance.new("TextButton", folder)
button.Size = UDim2.new(0.8, 0, 0, 40)
button.Position = UDim2.new(0.1, 0, 0.4, 0)
button.Text = "click here for fruit rain"
button.TextColor3 = Color3.fromRGB(255, 255, 255)
button.BackgroundColor3 = Color3.fromRGB(150, 0, 200)
button.Font = Enum.Font.GothamBold
button.TextScaled = true
button.BorderSizePixel = 0

button.MouseButton1Click:Connect(function()
	for i = 1, 15 do
		local fruit = Instance.new("Part", workspace)
		fruit.Size = Vector3.new(2, 2, 2)
		fruit.Position = game.Players.LocalPlayer.Character.HumanoidRootPart.Position + Vector3.new(math.random(-20, 20), 30, math.random(-20, 20))
		fruit.Anchored = false
		fruit.BrickColor = BrickColor.Random()
		fruit.Material = Enum.Material.SmoothPlastic
		fruit.Shape = Enum.PartType.Ball

		local label = Instance.new("BillboardGui", fruit)
		label.Size = UDim2.new(0, 100, 0, 50)
		label.AlwaysOnTop = true

		local text = Instance.new("TextLabel", label)
		text.Size = UDim2.new(1, 0, 1, 0)
		text.BackgroundTransparency = 1
		text.Text = "🍇 Fake Fruit"
		text.TextColor3 = Color3.new(1, 0, 1)
		text.TextScaled = true
		text.Font = Enum.Font.GothamBold

		game.Debris:AddItem(fruit, 10)
	end
end)

--// Close & Open GUI Buttons
local closeBtn = Instance.new("TextButton", mainFrame)
closeBtn.Size = UDim2.new(0, 40, 0, 40)
closeBtn.Position = UDim2.new(1, -45, 0, 5)
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextScaled = true
closeBtn.MouseButton1Click:Connect(function()
	mainFrame.Visible = false
end)

local openBtn = Instance.new("TextButton", gui)
openBtn.Size = UDim2.new(0, 120, 0, 40)
openBtn.Position = UDim2.new(0, 10, 0, 10)
openBtn.Text = "Open GUI"
openBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
openBtn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
openBtn.Font = Enum.Font.GothamBold
openBtn.TextScaled = true
openBtn.Visible = true
openBtn.MouseButton1Click:Connect(function()
	mainFrame.Visible = true
end)
