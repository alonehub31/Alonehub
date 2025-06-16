if game.CoreGui:FindFirstChild("FakeServerFinder") then
    game.CoreGui.FakeServerFinder:Destroy()
end

local loadingGui = Instance.new("ScreenGui", game.CoreGui)
loadingGui.Name = "FakeServerFinder"
loadingGui.ResetOnSpawn = false

local bg = Instance.new("Frame", loadingGui)
bg.Size = UDim2.new(1, 0, 1, 0)
bg.Position = UDim2.new(0, 0, 0, 0)
bg.BackgroundColor3 = Color3.fromRGB(120, 0, 180)

local introText = Instance.new("TextLabel", bg)
introText.Size = UDim2.new(1, 0, 1, 0)
introText.BackgroundTransparency = 1
introText.Text = "WELCOME TO AL0NE HUB SERVER FINDER"
introText.TextColor3 = Color3.fromRGB(0, 255, 255)
introText.TextScaled = true
introText.Font = Enum.Font.FredokaOne

task.wait(5)

introText.TextColor3 = Color3.fromRGB(255, 255, 255)
for i = 1, 100, 1 do
    introText.Text = "Loading... " .. i .. "%"
    task.wait(0.08)
end

loadingGui:Destroy()

--// Ana GUI
local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "FakeServerFinder_Main"
gui.ResetOnSpawn = false

local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0, 600, 0, 400)
main.Position = UDim2.new(0.5, -300, 0.5, -200)
main.BackgroundColor3 = Color3.fromRGB(30,30,30)
main.BorderSizePixel = 0
main.AnchorPoint = Vector2.new(0.5, 0.5)
main.Visible = false
main.Active = true
main.Draggable = true

-- Fade-in AÃ§Ä±lÄ±ÅŸ
main.BackgroundTransparency = 1
main.Visible = true
for i = 1, 10 do
    main.BackgroundTransparency = 1 - (i * 0.1)
    task.wait(0.05)
end

-- BaÅŸlÄ±k
local title = Instance.new("TextLabel", main)
title.Size = UDim2.new(1, 0, 0, 40)
title.Text = "AL0NE HUB - SERVER FINDER"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.BackgroundColor3 = Color3.fromRGB(50,50,50)
title.Font = Enum.Font.FredokaOne
title.TextScaled = true

-- Kapatma Butonu (X)
local closeBtn = Instance.new("TextButton", main)
closeBtn.Size = UDim2.new(0, 40, 0, 40)
closeBtn.Position = UDim2.new(1, -45, 0, 0)
closeBtn.Text = "X"
closeBtn.BackgroundColor3 = Color3.fromRGB(170, 0, 0)
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.Font = Enum.Font.FredokaOne
closeBtn.TextScaled = true

-- Open GUI Butonu
local openBtn = Instance.new("TextButton", gui)
openBtn.Size = UDim2.new(0, 120, 0, 40)
openBtn.Position = UDim2.new(1, -130, 0, 10)
openBtn.AnchorPoint = Vector2.new(0, 0)
openBtn.Text = "Open GUI"
openBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
openBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
openBtn.Font = Enum.Font.FredokaOne
openBtn.TextScaled = true
openBtn.Visible = false

closeBtn.MouseButton1Click:Connect(function()
    main.Visible = false
    openBtn.Visible = true
end)

openBtn.MouseButton1Click:Connect(function()
    main.Visible = true
    openBtn.Visible = false
end)

-- Folder ButonlarÄ±
local folder1 = Instance.new("TextButton", main)
folder1.Size = UDim2.new(0, 200, 0, 40)
folder1.Position = UDim2.new(0, 10, 0, 60)
folder1.Text = "fruit server list"
folder1.BackgroundColor3 = Color3.fromRGB(70,70,70)
folder1.TextColor3 = Color3.fromRGB(255,255,255)
folder1.Font = Enum.Font.FredokaOne
folder1.TextScaled = true

local folder2 = Instance.new("TextButton", main)
folder2.Size = UDim2.new(0, 200, 0, 40)
folder2.Position = UDim2.new(0, 10, 0, 110)
folder2.Text = "boss finder 2nd sea"
folder2.BackgroundColor3 = Color3.fromRGB(70,70,70)
folder2.TextColor3 = Color3.fromRGB(255,255,255)
folder2.Font = Enum.Font.FredokaOne
folder2.TextScaled = true

-- Ä°Ã§erik AlanÄ± (Scroll Destekli)
local content = Instance.new("ScrollingFrame", main)
content.Position = UDim2.new(0, 220, 0, 60)
content.Size = UDim2.new(1, -230, 1, -70)
content.BackgroundColor3 = Color3.fromRGB(40,40,40)
content.CanvasSize = UDim2.new(0, 0, 0, 0)
content.ScrollBarThickness = 6

-- Temizle Fonksiyonu
local function clearContent()
    for _, child in pairs(content:GetChildren()) do
        if child:IsA("GuiObject") then
            child:Destroy()
        end
    end
end

-- Fruit Rastgele SeÃ§ici (Nadirlik AyarlÄ±)
local commonFruits = {"Bomb", "Spike", "Chop", "Flame", "Ice", "Barrier", "Rubber", "Magma", "Smoke"}
local function getRandomFruit()
    local chance = math.random(1, 100)
    if chance <= 3 then
        return "Kitsune"
    elseif chance > 3 and chance <= 5 then
        return "Dragon"
    else
        return commonFruits[math.random(1, #commonFruits)]
    end
end

-- Fruit Server Listesi GÃ¶ster
local function showFakeServers()
    clearContent()
    local y = 0
    for i = 1, 20 do
        local btn = Instance.new("TextButton", content)
        btn.Size = UDim2.new(1, -10, 0, 30)
        btn.Position = UDim2.new(0, 5, 0, y)
        local fruit = getRandomFruit()
        btn.Text = "Server " .. i .. " - Fruit: " .. fruit
        btn.BackgroundColor3 = Color3.fromRGB(60,60,60)
        btn.TextColor3 = Color3.fromRGB(255,255,255)
        btn.Font = Enum.Font.FredokaOne
        btn.TextScaled = true
        y = y + 35
    end
    content.CanvasSize = UDim2.new(0, 0, 0, y)
end

-- Sahte Boss Finder
local function showBossFinder()
    clearContent()
    local label = Instance.new("TextLabel", content)
    label.Size = UDim2.new(1, 0, 0, 30)
    label.Position = UDim2.new(0, 0, 0, 0)
    label.Text = "No boss found in 2nd Sea currently."
    label.TextColor3 = Color3.fromRGB(255,255,255)
    label.BackgroundTransparency = 1
    label.Font = Enum.Font.FredokaOne
    label.TextScaled = true
    content.CanvasSize = UDim2.new(0, 0, 0, 40)
end

-- TÄ±klama BaÄŸlantÄ±larÄ±
folder1.MouseButton1Click:Connect(showFakeServers)
folder2.MouseButton1Click:Connect(showBossFinder)
