local ScreenGui = Instance.new("ScreenGui", game.Players.LocalPlayer:WaitForChild("PlayerGui"))
ScreenGui.ResetOnSpawn = false

local bg = Instance.new("Frame", ScreenGui)
bg.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
bg.Size = UDim2.new(0, 0, 0, 0)
bg.Position = UDim2.new(0.5, -250, 0.5, -150)
bg.AnchorPoint = Vector2.new(0.5, 0.5)
bg.BorderSizePixel = 0

game:GetService("TweenService"):Create(bg, TweenInfo.new(2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
	Size = UDim2.new(0, 500, 0, 300)
}):Play()

local button = Instance.new("TextButton", bg)
button.Size = UDim2.new(0, 200, 0, 50)
button.Position = UDim2.new(0.5, -100, 0.5, -25)
button.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
button.Text = "Scripti Çalıştır"
button.TextColor3 = Color3.fromRGB(255, 255, 255)
button.TextScaled = true
button.Font = Enum.Font.GothamBold
button.BorderSizePixel = 0
button.ZIndex = 2

local label = Instance.new("TextLabel", bg)
label.Size = UDim2.new(1, 0, 1, 0)
label.Position = UDim2.new(0, 0, 0, 0)
label.BackgroundTransparency = 1
label.TextColor3 = Color3.fromRGB(255, 255, 255)
label.TextScaled = true
label.Font = Enum.Font.GothamBold
label.Text = ""
label.ZIndex = 1

local sound = Instance.new("Sound", game.SoundService)
sound.SoundId = "rbxassetid://8449305114"
sound.Volume = 1
sound.Looped = true

button.MouseButton1Click:Connect(function()
	button.Visible = false
	label.Text = "HARAKET EDEN GAY BUĞRA 🌈🌈🌈"
	sound:Play()
end)
