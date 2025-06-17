-- ALONE HUB SYSTEM by GBT
if not _G.AloneHubLoaded then
    _G.AloneHubLoaded = true

    -- EFFECTLİ YÜKLEME EKRANI
    local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
    local Frame = Instance.new("Frame", ScreenGui)
    local TextLabel = Instance.new("TextLabel", Frame)
    local UIGradient = Instance.new("UIGradient", Frame)

    ScreenGui.IgnoreGuiInset = true
    ScreenGui.ResetOnSpawn = false
    Frame.Size = UDim2.new(1,0,1,0)
    Frame.BackgroundColor3 = Color3.fromRGB(0,0,0)
    TextLabel.Text = "ALONE HUB IS LOADING..."
    TextLabel.TextColor3 = Color3.fromRGB(255,255,255)
    TextLabel.TextSize = 40
    TextLabel.AnchorPoint = Vector2.new(0.5,0.5)
    TextLabel.Position = UDim2.new(0.5,0,0.5,0)
    TextLabel.Size = UDim2.new(0.8,0,0.1,0)
    TextLabel.BackgroundTransparency = 1

    UIGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(170, 0, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 255, 255))
    }

    wait(3)
    Frame:TweenSize(UDim2.new(1,0,0,0), "Out", "Quad", 2, true)
    wait(2)
    ScreenGui:Destroy()

    -- KOMUT SİSTEMİ BAŞLANGICI
    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer
    local ChatService = game:GetService("StarterGui")

    -- Bildirim Fonksiyonu
    local function notify(msg)
        ChatService:SetCore("SendNotification", {
            Title = "ALONE HUB",
            Text = msg,
            Duration = 3
        })
    end

    local secmode = false

    -- HELP GUI
    local function createHelpGUI()
        if game.CoreGui:FindFirstChild("HelpGUI") then game.CoreGui.HelpGUI:Destroy() end

        local gui = Instance.new("ScreenGui", game.CoreGui)
        gui.Name = "HelpGUI"
        local frame = Instance.new("Frame", gui)
        frame.Size = UDim2.new(0.4,0,0.5,0)
        frame.Position = UDim2.new(0.3,0,0.25,0)
        frame.BackgroundColor3 = Color3.fromRGB(20,20,20)
        frame.BorderSizePixel = 0
        frame.Active = true
        frame.Draggable = true

        local scroll = Instance.new("ScrollingFrame", frame)
        scroll.Size = UDim2.new(1,0,1,0)
        scroll.CanvasSize = UDim2.new(0,0,2,0)
        scroll.ScrollBarThickness = 6
        scroll.BackgroundTransparency = 1

        local close = Instance.new("TextButton", frame)
        close.Size = UDim2.new(0,25,0,25)
        close.Position = UDim2.new(1,-30,0,5)
        close.Text = "X"
        close.BackgroundColor3 = Color3.fromRGB(255,0,0)
        close.MouseButton1Click:Connect(function() gui:Destroy() end)

        local cmds = {
            "!on - Start system",
            "!fly - Toggle fly",
            "!ws <speed> - WalkSpeed",
            "!jumppower <value> - JumpPower",
            "!invis - Invisible",
            "!to <player> - Teleport",
            "!tptool - Teleport Tool",
            "!fling <player> - Fling",
            "!annoy <player> - Troll options",
            "!rickroll - Rickroll effect",
            "!credits - Show credit",
            "!info - Server info",
            "!reload - Reload script",
            "!trolltools - Open tools",
            "!secmode on/off - Private commands"
        }

        for i, cmd in ipairs(cmds) do
            local txt = Instance.new("TextLabel", scroll)
            txt.Size = UDim2.new(1, -10, 0, 25)
            txt.Position = UDim2.new(0, 5, 0, (i - 1) * 30)
            txt.Text = cmd
            txt.TextColor3 = Color3.fromRGB(255,255,255)
            txt.BackgroundTransparency = 1
            txt.TextXAlignment = Enum.TextXAlignment.Left
        end
    end

    -- Tool GUI
    local function openToolGUI()
        local gui = Instance.new("ScreenGui", game.CoreGui)
        gui.Name = "TrollToolGUI"
        local frame = Instance.new("Frame", gui)
        frame.Size = UDim2.new(0.3,0,0.4,0)
        frame.Position = UDim2.new(0.35,0,0.3,0)
        frame.BackgroundColor3 = Color3.fromRGB(30,30,30)
        frame.Active = true
        frame.Draggable = true

        local tools = {
            "Gravity Coil", "Speed Coil", "Rocket Launcher", "Slingshot", "Sword"
        }

        for i, toolName in ipairs(tools) do
            local btn = Instance.new("TextButton", frame)
            btn.Size = UDim2.new(1, -10, 0, 30)
            btn.Position = UDim2.new(0, 5, 0, (i - 1) * 35 + 10)
            btn.Text = toolName
            btn.MouseButton1Click:Connect(function()
                local tool = Instance.new("Tool")
                tool.RequiresHandle = false
                tool.Name = toolName
                tool.Parent = LocalPlayer.Backpack
                notify(toolName.." added to Backpack!")
            end)
        end
    end

    -- Komut Kontrol
    LocalPlayer.Chatted:Connect(function(msg)
        if secmode then
            notify("(SECMODE) "..msg)
        end

        local args = msg:split(" ")
        local cmd = args[1]:lower()

        if cmd == "!on" then
            notify("Alone Hub Activated!")
        elseif cmd == "!help" then
            createHelpGUI()
        elseif cmd == "!fly" then
            notify("Fly toggled (not implemented)")
        elseif cmd == "!ws" and tonumber(args[2]) then
            LocalPlayer.Character.Humanoid.WalkSpeed = tonumber(args[2])
            notify("WalkSpeed set to "..args[2])
        elseif cmd == "!jumppower" and tonumber(args[2]) then
            LocalPlayer.Character.Humanoid.JumpPower = tonumber(args[2])
            notify("JumpPower set to "..args[2])
        elseif cmd == "!invis" then
            LocalPlayer.Character.Head.Transparency = 1
            for _,v in pairs(LocalPlayer.Character:GetDescendants()) do
                if v:IsA("BasePart") and v.Name ~= "HumanoidRootPart" then
                    v.Transparency = 1
                end
            end
            notify("Invisibility ON")
        elseif cmd == "!to" and args[2] then
            local target = args[2]:lower()
            for _,player in ipairs(Players:GetPlayers()) do
                if player.Name:lower():sub(1, #target) == target then
                    LocalPlayer.Character:PivotTo(player.Character:GetPivot())
                    notify("Teleported to "..player.Name)
                end
            end
        elseif cmd == "!tptool" then
            local tool = Instance.new("Tool", LocalPlayer.Backpack)
            tool.RequiresHandle = false
            tool.Name = "TP Tool"
            tool.Activated:Connect(function()
                local mouse = LocalPlayer:GetMouse()
                if mouse.Hit then
                    LocalPlayer.Character:PivotTo(mouse.Hit + Vector3.new(0,3,0))
                end
            end)
            notify("Teleport Tool added.")
        elseif cmd == "!rickroll" then
            notify("Never gonna give you up 🎵")
        elseif cmd == "!credits" then
            notify("THIS SCRIPT BY AL0NE")
        elseif cmd == "!info" then
            notify("Players: "..#Players:GetPlayers().." | JobId: "..game.JobId)
        elseif cmd == "!reload" then
            notify("Reloading script...")
            wait(1)
            loadstring(game:HttpGet("https://raw.githubusercontent.com/alonehub31/Alonehub/main/AloneHubChatSystem.lua"))()
        elseif cmd == "!trolltools" then
            openToolGUI()
        elseif cmd == "!secmode" and args[2] then
            if args[2]:lower() == "on" then
                secmode = true
                notify("Secret Mode ON")
            elseif args[2]:lower() == "off" then
                secmode = false
                notify("Secret Mode OFF")
            end
        end
    end)
end
