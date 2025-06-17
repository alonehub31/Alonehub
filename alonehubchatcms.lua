-- ALONE HUB CHAT GUI SYSTEM V2

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local uis = game:GetService("UserInputService")
local coregui = game:GetService("CoreGui")
local teleportService = game:GetService("TeleportService")

-- GUI temizle
pcall(function() coregui:FindFirstChild("ALONE_HUB_GUI"):Destroy() end)

-- GUI başlat
local gui = Instance.new("ScreenGui", coregui)
gui.Name = "ALONE_HUB_GUI"
gui.ResetOnSpawn = false

-- Açılış ekranı
local opening = Instance.new("Frame", gui)
opening.Size = UDim2.new(1, 0, 1, 0)
opening.BackgroundColor3 = Color3.new(0, 0, 0)

local openText = Instance.new("TextLabel", opening)
openText.Size = UDim2.new(1, 0, 1, 0)
openText.Text = "THANK YOU FOR USING AL0NE HUB"
openText.Font = Enum.Font.GothamBold
openText.TextColor3 = Color3.new(1, 1, 1)
openText.TextScaled = true
openText.BackgroundTransparency = 1

wait(5)
opening:Destroy()

-- Bildirim alanı
local notify = Instance.new("TextLabel", gui)
notify.Size = UDim2.new(0, 300, 0, 30)
notify.Position = UDim2.new(1, -310, 1, -40)
notify.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
notify.TextColor3 = Color3.new(1, 1, 1)
notify.Font = Enum.Font.GothamBold
notify.TextSize = 16
notify.Text = ""
notify.Visible = false

local function showNotify(text)
	notify.Text = text
	notify.Visible = true
	wait(2.5)
	notify.Visible = false
end

-- Help GUI
local helpGui = Instance.new("Frame", gui)
helpGui.Size = UDim2.new(0, 300, 0, 250)
helpGui.Position = UDim2.new(0.5, -150, 0.5, -125)
helpGui.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
helpGui.Visible = false

local helpTitle = Instance.new("TextLabel", helpGui)
helpTitle.Size = UDim2.new(1, 0, 0, 40)
helpTitle.Text = "ALONE HUB - HELP"
helpTitle.Font = Enum.Font.GothamBold
helpTitle.TextColor3 = Color3.new(1, 1, 1)
helpTitle.TextSize = 20
helpTitle.BackgroundTransparency = 1

local helpClose = Instance.new("TextButton", helpGui)
helpClose.Size = UDim2.new(0, 30, 0, 30)
helpClose.Position = UDim2.new(1, -35, 0, 5)
helpClose.Text = "X"
helpClose.Font = Enum.Font.GothamBold
helpClose.TextSize = 16
helpClose.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
helpClose.TextColor3 = Color3.new(1, 1, 1)
helpClose.MouseButton1Click:Connect(function()
	helpGui.Visible = false
end)

local helpText = Instance.new("TextLabel", helpGui)
helpText.Position = UDim2.new(0, 10, 0, 50)
helpText.Size = UDim2.new(1, -20, 1, -60)
helpText.Text = "!on\n!fly / !nofly\n!jump 150\n!ws 100\n!to PlayerName\n!invis / !vis\n!esp\n!shiftlock\n!tptool\n!help\n!reload\n!info\n!credits"
helpText.Font = Enum.Font.Code
helpText.TextSize = 16
helpText.TextColor3 = Color3.new(1, 1, 1)
helpText.TextWrapped = true
helpText.TextYAlignment = Enum.TextYAlignment.Top
helpText.TextXAlignment = Enum.TextXAlignment.Left
helpText.BackgroundTransparency = 1

-- Sistem değişkenleri
local enabled = false
local flying = false

local function startFly()
	local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
	if not hrp then return end
	local bv = Instance.new("BodyVelocity", hrp)
	bv.Name = "ALONE_FLY"
	bv.MaxForce = Vector3.new(1e9, 1e9, 1e9)
	bv.Velocity = Vector3.zero
	flying = true
	coroutine.wrap(function()
		while flying and bv and bv.Parent do
			local cam = workspace.CurrentCamera
			local dir = Vector3.zero
			if uis:IsKeyDown(Enum.KeyCode.W) then dir += cam.CFrame.LookVector end
			if uis:IsKeyDown(Enum.KeyCode.S) then dir -= cam.CFrame.LookVector end
			if uis:IsKeyDown(Enum.KeyCode.A) then dir -= cam.CFrame.RightVector end
			if uis:IsKeyDown(Enum.KeyCode.D) then dir += cam.CFrame.RightVector end
			bv.Velocity = dir * 100
			wait()
		end
	end)()
end

local function stopFly()
	flying = false
	local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
	if hrp then
		local bv = hrp:FindFirstChild("ALONE_FLY")
		if bv then bv:Destroy() end
	end
end

local function makeESP()
	for _,plr in pairs(Players:GetPlayers()) do
		if plr ~= player and not plr.Character:FindFirstChild("ESP") then
			local esp = Instance.new("BillboardGui", plr.Character)
			esp.Name = "ESP"
			esp.Size = UDim2.new(0, 100, 0, 40)
			esp.AlwaysOnTop = true
			local txt = Instance.new("TextLabel", esp)
			txt.Size = UDim2.new(1,0,1,0)
			txt.BackgroundTransparency = 1
			txt.Text = plr.Name
			txt.TextColor3 = Color3.new(1,0,0)
			txt.TextScaled = true
			txt.Font = Enum.Font.GothamBold
		end
	end
end

local function showCredits()
	local frame = Instance.new("Frame", gui)
	frame.Size = UDim2.new(1, 0, 1, 0)
	frame.BackgroundColor3 = Color3.new(0, 0, 0)

	local text = Instance.new("TextLabel", frame)
	text.Size = UDim2.new(1, 0, 1, 0)
	text.Text = "THIS SCRIPT BY AL0NE HUB"
	text.Font = Enum.Font.GothamBold
	text.TextColor3 = Color3.new(1, 1, 1)
	text.TextScaled = true
	text.BackgroundTransparency = 1

	wait(5)
	frame:Destroy()
end

local function reloadScript()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/alonehub31/Alonehub/main/chatguiv2.lua"))()
end

local function showInfo()
	local info = "Players:\n"
	for _,p in pairs(Players:GetPlayers()) do
		info = info .. p.Name .. " (" .. tostring(p.AccountAge) .. " days)\n"
	end
	info = info .. "\nJobId: "..game.JobId.."\nPlaceId: "..game.PlaceId.."\nPlayerCount: "..#Players:GetPlayers()
	setclipboard(info)
	showNotify("Server info copied to clipboard 📋")
end

-- Komut kontrolü
player.Chatted:Connect(function(msg)
	msg = msg:lower()

	if msg == "!on" then
		enabled = true
		showNotify("System Enabled ✅")

	elseif msg == "!fly" and enabled then
		startFly()
		showNotify("Fly Enabled 🕊️")

	elseif msg == "!nofly" and enabled then
		stopFly()
		showNotify("Fly Disabled 🛑")

	elseif msg:match("!jump") and enabled then
		local val = tonumber(msg:match("%d+"))
		if val and player.Character then
			player.Character:FindFirstChildOfClass("Humanoid").JumpPower = val
			showNotify("JumpPower set to "..val)
		end

	elseif msg:match("!ws") and enabled then
		local val = tonumber(msg:match("%d+"))
		if val and player.Character then
			player.Character:FindFirstChildOfClass("Humanoid").WalkSpeed = val
			showNotify("WalkSpeed set to "..val)
		end

	elseif msg:match("!to") and enabled then
		local name = msg:match("!to (.+)")
		for _,plr in pairs(Players:GetPlayers()) do
			if plr.Name:lower():sub(1,#name) == name then
				local hrp = player.Character:FindFirstChild("HumanoidRootPart")
				local target = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")
				if hrp and target then
					hrp.CFrame = target.CFrame + Vector3.new(2,0,0)
					showNotify("Teleported to "..plr.Name)
				end
			end
		end

	elseif msg == "!invis" and enabled then
		for _,v in pairs(player.Character:GetChildren()) do
			if v:IsA("BasePart") then
				v.Transparency = 1
			end
		end
		showNotify("Invisible ON 🫥")

	elseif msg == "!vis" and enabled then
		for _,v in pairs(player.Character:GetChildren()) do
			if v:IsA("BasePart") then
				v.Transparency = 0
			end
		end
		showNotify("Invisible OFF 👀")

	elseif msg == "!esp" and enabled then
		makeESP()
		showNotify("ESP Enabled 🔎")

	elseif msg == "!shiftlock" and enabled then
		pcall(function()
			local cam = workspace.CurrentCamera
			cam.CameraSubject = player.Character:FindFirstChild("Humanoid")
			cam.CameraType = Enum.CameraType.Scriptable
			wait(0.1)
			cam.CameraType = Enum.CameraType.Custom
		end)
		showNotify("Shift Lock toggled")

	elseif msg == "!tptool" and enabled then
		local tool = Instance.new("Tool", player.Backpack)
		tool.RequiresHandle = false
		tool.Name = "TeleportTool"
		tool.Activated:Connect(function()
			local mouse = player:GetMouse()
			if mouse and mouse.Hit then
				local root = player.Character:FindFirstChild("HumanoidRootPart")
				if root then
					root.CFrame = mouse.Hit + Vector3.new(0,3,0)
				end
			end
		end)
		showNotify("Teleport Tool added 🧰")

	elseif msg == "!help" and enabled then
		helpGui.Visible = true
		showNotify("Help GUI Opened 📜")

	elseif msg == "!reload" and enabled then
		showNotify("Reloading script 🔄")
		wait(1)
		reloadScript()

	elseif msg == "!info" and enabled then
		showInfo()

	elseif msg == "!credits" and enabled then
		showCredits()
	end
end)
