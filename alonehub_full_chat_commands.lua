
-- ALONE HUB FULL SCRIPT (Chat Komutları + Açılış + Mobil TPTool + Help GUI + Spam Sistemi)

local plr = game.Players.LocalPlayer
local char = plr.Character or plr.CharacterAdded:Wait()
local hum = char:WaitForChild("Humanoid")
local root = char:WaitForChild("HumanoidRootPart")
local uis = game:GetService("UserInputService")
local rs = game:GetService("RunService")
local teleportService = game:GetService("TeleportService")

-- AÇILIŞ EKRANI
do
    local TweenService = game:GetService("TweenService")

    local openingGui = Instance.new("ScreenGui", game.CoreGui)
    openingGui.Name = "AloneHub_Opening"
    openingGui.ResetOnSpawn = false
    openingGui.IgnoreGuiInset = true

    local bg = Instance.new("Frame", openingGui)
    bg.Size = UDim2.new(1, 0, 1, 0)
    bg.BackgroundColor3 = Color3.fromRGB(95, 0, 130)
    bg.BackgroundTransparency = 1

    local label = Instance.new("TextLabel", bg)
    label.Size = UDim2.new(1, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.Text = "THANK YOU FOR USING ALONE HUB"
    label.TextColor3 = Color3.new(1, 1, 1)
    label.TextScaled = true
    label.Font = Enum.Font.GothamBlack
    label.TextTransparency = 1

    TweenService:Create(bg, TweenInfo.new(1), {BackgroundTransparency = 0}):Play()
    TweenService:Create(label, TweenInfo.new(1), {TextTransparency = 0}):Play()
    label.Size = UDim2.new(0.8, 0, 0.8, 0)
    label.Position = UDim2.new(0.1, 0, 0.1, 0)
    TweenService:Create(label, TweenInfo.new(2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Size = UDim2.new(1, 0, 1, 0),
        Position = UDim2.new(0, 0, 0, 0)
    }):Play()

    task.delay(5, function()
        TweenService:Create(label, TweenInfo.new(1), {TextTransparency = 1}):Play()
        TweenService:Create(bg, TweenInfo.new(1), {BackgroundTransparency = 1}):Play()
        task.wait(1)
        openingGui:Destroy()
    end)
end

-- SYSTEM FLAG
local systemEnabled = false
local tpTouchActive = false
local spamEnabled = false
local spamWords = "ALONE HUB 💜"

-- SHOW INFO MESSAGE
function showMessage(text)
    local msg = Instance.new("TextLabel", game.CoreGui)
    msg.Text = text
    msg.Size = UDim2.new(0.4, 0, 0.05, 0)
    msg.Position = UDim2.new(0.3, 0, 0.9, 0)
    msg.BackgroundColor3 = Color3.fromRGB(40, 0, 60)
    msg.TextColor3 = Color3.new(1, 1, 1)
    msg.Font = Enum.Font.GothamSemibold
    msg.TextScaled = true
    msg.BackgroundTransparency = 0.3
    msg.ZIndex = 999999
    game.Debris:AddItem(msg, 2)
end

-- HELP GUI
local helpGui = Instance.new("ScreenGui", game.CoreGui)
helpGui.Name = "HelpGui"
helpGui.ResetOnSpawn = false
helpGui.Enabled = false

local frame = Instance.new("Frame", helpGui)
frame.Size = UDim2.new(0.4, 0, 0.5, 0)
frame.Position = UDim2.new(0.3, 0, 0.25, 0)
frame.BackgroundColor3 = Color3.fromRGB(50, 0, 80)
frame.BorderSizePixel = 0

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0.15, 0)
title.Text = "ALONE HUB - COMMANDS"
title.TextColor3 = Color3.new(1, 1, 1)
title.Font = Enum.Font.GothamBlack
title.TextScaled = true
title.BackgroundTransparency = 1

local cmds = Instance.new("TextLabel", frame)
cmds.Size = UDim2.new(1, -20, 0.8, -20)
cmds.Position = UDim2.new(0, 10, 0.15, 10)
cmds.Text = "!fly
!invis
!ws <speed>
!tptool
!rejoin
!serverhop
!bring <player>
!reset
!godmode
!fling <player>
!spam on <text>
!spam off"
cmds.TextColor3 = Color3.new(1, 1, 1)
cmds.Font = Enum.Font.Gotham
cmds.TextSize = 20
cmds.TextWrapped = true
cmds.TextYAlignment = Enum.TextYAlignment.Top
cmds.BackgroundTransparency = 1

local closeBtn = Instance.new("TextButton", frame)
closeBtn.Size = UDim2.new(0, 40, 0, 40)
closeBtn.Position = UDim2.new(1, -45, 0, 5)
closeBtn.Text = "X"
closeBtn.TextScaled = true
closeBtn.Font = Enum.Font.GothamBold
closeBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
closeBtn.TextColor3 = Color3.new(1, 1, 1)
closeBtn.MouseButton1Click:Connect(function()
    helpGui.Enabled = false
end)

-- MOBIL TPTOUCH
game:GetService("UserInputService").TouchTap:Connect(function(touches)
	if tpTouchActive and systemEnabled then
		local pos = touches[1].Position
		local camera = workspace.CurrentCamera
		local ray = camera:ScreenPointToRay(pos.X, pos.Y)
		local result = workspace:Raycast(ray.Origin, ray.Direction * 500)
		if result and result.Position then
			plr.Character:MoveTo(result.Position + Vector3.new(0, 3, 0))
		end
	end
end)

-- SPAM
task.spawn(function()
	while true do
		if spamEnabled then
			game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer(spamWords, "All")
		end
		task.wait(0.5)
	end
end)

-- KOMUT ALGILAYICI
plr.Chatted:Connect(function(msg)
	local args = string.split(msg, " ")
	local cmd = args[1]:lower()

	if cmd == "!alonehubon" or cmd == "!on" then
		systemEnabled = true
		showMessage("ALONE HUB ENABLED")
	elseif cmd == "!alonehuboff" or cmd == "!off" then
		systemEnabled = false
		showMessage("ALONE HUB DISABLED")
	end

	if not systemEnabled then return end

	if cmd == "!fly" then
		hum:ChangeState(Enum.HumanoidStateType.Physics)
		local bv = Instance.new("BodyVelocity", root)
		bv.Velocity = Vector3.new(0, 0, 0)
		bv.MaxForce = Vector3.new(100000, 100000, 100000)
		rs.RenderStepped:Connect(function()
			bv.Velocity = root.CFrame.LookVector * 50
		end)
		showMessage("fly turned on")

	elseif cmd == "!invis" then
		for _, part in pairs(char:GetDescendants()) do
			if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
				part.Transparency = 1
			end
		end
		showMessage("invisibility on")

	elseif cmd == "!ws" and tonumber(args[2]) then
		hum.WalkSpeed = tonumber(args[2])
		showMessage("walkspeed set to " .. args[2])

	elseif cmd == "!tptool" then
		tpTouchActive = not tpTouchActive
		showMessage("touch teleport " .. (tpTouchActive and "enabled" or "disabled"))

	elseif cmd == "!help" then
		helpGui.Enabled = true

	elseif cmd == "!rejoin" then
		teleportService:Teleport(game.PlaceId)

	elseif cmd == "!serverhop" then
		local HttpService = game:GetService("HttpService")
		local servers = game:GetService("HttpService"):JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Desc&limit=100")).data
		for _, v in pairs(servers) do
			if v.id ~= game.JobId then
				teleportService:TeleportToPlaceInstance(game.PlaceId, v.id)
				break
			end
		end

	elseif cmd == "!bring" and args[2] then
		local target = game.Players:FindFirstChild(args[2])
		if target and target.Character then
			target.Character:MoveTo(root.Position + Vector3.new(3,0,0))
			showMessage("brought " .. args[2])
		end

	elseif cmd == "!reset" then
		hum.Health = 0

	elseif cmd == "!godmode" then
		hum.Name = "GodHumanoid"
		local newHum = hum:Clone()
		newHum.Parent = char
		newHum.Name = "Humanoid"
		task.wait()
		hum:Destroy()
		showMessage("godmode enabled")

	elseif cmd == "!fling" and args[2] then
		local target = game.Players:FindFirstChild(args[2])
		if target and target.Character then
			local bv = Instance.new("BodyVelocity", target.Character:FindFirstChild("HumanoidRootPart"))
			bv.Velocity = Vector3.new(0, 1000, 0)
			bv.MaxForce = Vector3.new(1e5, 1e5, 1e5)
			game.Debris:AddItem(bv, 1)
			showMessage("flung " .. args[2])
		end

	elseif cmd == "!spam" then
		if args[2] == "on" then
			spamWords = table.concat(args, " ", 3)
			spamEnabled = true
			showMessage("spam started: " .. spamWords)
		elseif args[2] == "off" then
			spamEnabled = false
			showMessage("spam stopped")
		end
	end
end)
