-- // GUI Kontrol
if game.CoreGui:FindFirstChild("AL0NE_UNIVERSAL_GUI") then
    game.CoreGui.AL0NE_UNIVERSAL_GUI:Destroy()
end

-- // Açılış Ekranı
local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "AL0NE_UNIVERSAL_GUI"
gui.ResetOnSpawn = false

local loadingFrame = Instance.new("Frame", gui)
loadingFrame.Size = UDim2.new(1, 0, 1, 0)
loadingFrame.BackgroundColor3 = Color3.fromRGB(30, 0, 50)

local title = Instance.new("TextLabel", loadingFrame)
title.Text = "WELCOME TO AL0NE HUB"
title.TextColor3 = Color3.fromRGB(0, 170, 255)
title.TextScaled = true
title.Size = UDim2.new(1, 0, 0.2, 0)
title.Position = UDim2.new(0, 0, 0.4, 0)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold

local barBg = Instance.new("Frame", loadingFrame)
barBg.Size = UDim2.new(0.6, 0, 0.05, 0)
barBg.Position = UDim2.new(0.2, 0, 0.7, 0)
barBg.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
barBg.BorderSizePixel = 0

local bar = Instance.new("Frame", barBg)
bar.Size = UDim2.new(0, 0, 1, 0)
bar.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
bar.BorderSizePixel = 0

-- // Yüklenme Animasyonu
for i = 1, 100 do
	bar.Size = UDim2.new(i/100, 0, 1, 0)
	wait(0.05)
end

loadingFrame:Destroy()

-- // Ana GUI
local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0, 500, 0, 400)
main.Position = UDim2.new(0.5, -250, 0.5, -200)
main.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
main.BorderSizePixel = 0
main.Visible = true
main.Active = true
main.Draggable = true

local uilist = Instance.new("UIListLayout", main)
uilist.FillDirection = Enum.FillDirection.Vertical
uilist.Padding = UDim.new(0, 5)

local folders = {}

local function createFolder(name)
	local folder = Instance.new("Frame")
	folder.Size = UDim2.new(1, 0, 0, 30)
	folder.BackgroundColor3 = Color3.fromRGB(40, 40, 40)

	local button = Instance.new("TextButton", folder)
	button.Text = "[+] " .. name
	button.Size = UDim2.new(1, 0, 1, 0)
	button.BackgroundTransparency = 1
	button.TextColor3 = Color3.new(1, 1, 1)
	button.Font = Enum.Font.GothamBold
	button.TextSize = 16

	local content = Instance.new("Frame", folder)
	content.Size = UDim2.new(1, 0, 0, 0)
	content.BackgroundTransparency = 1
	content.ClipsDescendants = true

	local layout = Instance.new("UIListLayout", content)
	layout.Padding = UDim.new(0, 5)

	local open = false
	button.MouseButton1Click:Connect(function()
		open = not open
		button.Text = open and "[-] " .. name or "[+] " .. name
		content.Size = UDim2.new(1, 0, 0, open and layout.AbsoluteContentSize.Y or 0)
	end)

	content:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		if open then
			content.Size = UDim2.new(1, 0, 0, layout.AbsoluteContentSize.Y)
		end
	end)

	folder.Parent = main
	folders[name] = content
	return content
end

-- // Folder: V1 Hacks
local f1 = createFolder("V1 Hacks")

local function createButton(parent, text, callback)
	local btn = Instance.new("TextButton", parent)
	btn.Size = UDim2.new(1, 0, 0, 30)
	btn.Text = text
	btn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
	btn.TextColor3 = Color3.new(1, 1, 1)
	btn.Font = Enum.Font.Gotham
	btn.TextSize = 14
	btn.MouseButton1Click:Connect(callback)
end

createButton(f1, "WalkSpeed Boost", function()
	game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 100
end)

createButton(f1, "JumpPower Boost", function()
	game.Players.LocalPlayer.Character.Humanoid.JumpPower = 120
end)

createButton(f1, "Enable Fly", function()
	loadstring(game:HttpGet("https://pastebin.com/raw/yjF6vEJK"))()
end)

createButton(f1, "Enable Noclip", function()
	loadstring(game:HttpGet("https://pastebin.com/raw/Up8F8qGK"))()
end)

createButton(f1, "Click Teleport", function()
	local tool = Instance.new("Tool")
	tool.RequiresHandle = false
	tool.Name = "ClickTP"
	tool.Activated:Connect(function()
		local mouse = game.Players.LocalPlayer:GetMouse()
		if mouse then
			game.Players.LocalPlayer.Character:MoveTo(mouse.Hit.Position + Vector3.new(0, 3, 0))
		end
	end)
	tool.Parent = game.Players.LocalPlayer.Backpack
end)

createButton(f1, "Player ESP", function()
	for _,v in pairs(game.Players:GetPlayers()) do
		if v ~= game.Players.LocalPlayer then
			local esp = Instance.new("BillboardGui", v.Character:FindFirstChild("Head"))
			esp.Size = UDim2.new(0,100,0,40)
			esp.AlwaysOnTop = true
			local label = Instance.new("TextLabel", esp)
			label.Size = UDim2.new(1,0,1,0)
			label.BackgroundTransparency = 1
			label.Text = v.Name
			label.TextColor3 = Color3.new(1,1,1)
		end
	end
end)

-- // Folder: V2 Hacks
local f2 = createFolder("V2 Hacks")

createButton(f2, "Invisibility", function()
	local char = game.Players.LocalPlayer.Character
	for _, v in pairs(char:GetDescendants()) do
		if v:IsA("BasePart") then
			v.Transparency = 1
		end
	end
end)

createButton(f2, "Give Teleport Tool", function()
	local tool = Instance.new("Tool")
	tool.RequiresHandle = false
	tool.Name = "Teleport Tool"
	tool.Activated:Connect(function()
		local mouse = game.Players.LocalPlayer:GetMouse()
		game.Players.LocalPlayer.Character:SetPrimaryPartCFrame(CFrame.new(mouse.Hit.Position + Vector3.new(0,3,0)))
	end)
	tool.Parent = game.Players.LocalPlayer.Backpack
end)

-- // Folder: Info
local f3 = createFolder("Info")

local function labelInfo(parent, txt)
	local lbl = Instance.new("TextLabel", parent)
	lbl.Size = UDim2.new(1, 0, 0, 20)
	lbl.Text = txt
	lbl.TextColor3 = Color3.new(1,1,1)
	lbl.BackgroundTransparency = 1
	lbl.Font = Enum.Font.Gotham
	lbl.TextSize = 13
end

labelInfo(f3, "GameID: " .. game.PlaceId)
labelInfo(f3, "JobID: " .. game.JobId)
labelInfo(f3, "Player Count: " .. #game.Players:GetPlayers())
labelInfo(f3, "Max Players: " .. game.Players.MaxPlayers)
labelInfo(f3, "Ping: " .. tostring(math.floor(game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValue())))

-- // Folder: Player Info
local f4 = createFolder("Player Info")

for _,plr in pairs(game.Players:GetPlayers()) do
	createButton(f4, plr.Name, function()
		local info = "Username: " .. plr.Name .. "\n"
		info = info .. "Display Name: " .. plr.DisplayName .. "\n"
		info = info .. "User ID: " .. plr.UserId .. "\n"
		info = info .. "Account Age (days): " .. plr.AccountAge .. "\n"
		info = info .. "Friend Count: " .. #(plr:GetFriendsAsync():GetCurrentPage())
		setclipboard(info)
	end)
end

-- // GUI Toggle
local toggleBtn = Instance.new("TextButton", gui)
toggleBtn.Text = "Open GUI"
toggleBtn.Size = UDim2.new(0, 100, 0, 30)
toggleBtn.Position = UDim2.new(1, -110, 1, -40)
toggleBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
toggleBtn.TextColor3 = Color3.new(1,1,1)
toggleBtn.Font = Enum.Font.Gotham
toggleBtn.TextSize = 14

toggleBtn.MouseButton1Click:Connect(function()
	main.Visible = not main.Visible
end)
