local Components = require(script.Parent.Components)

local MainGUI = {}

function MainGUI.new(config, player)
    local self = setmetatable({}, {__index = MainGUI})
    
    self.config = config
    self.player = player
    self.visible = true
    
    self:CreateGUI()
    
    return self
end

function MainGUI:CreateGUI()
    -- Screen GUI
    self.screenGui = Instance.new("ScreenGui")
    self.screenGui.Name = "XaXaClient"
    self.screenGui.Parent = self.player:WaitForChild("PlayerGui")
    self.screenGui.ResetOnSpawn = false
    self.screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    
    -- Main Frame
    self.mainFrame = Instance.new("Frame")
    self.mainFrame.Name = "MainFrame"
    self.mainFrame.Size = UDim2.new(0, 400, 0, 550)
    self.mainFrame.Position = UDim2.new(0.5, -200, 0.5, -275)
    self.mainFrame.BackgroundColor3 = self.config.Visual.backgroundColor
    self.mainFrame.BorderSizePixel = 0
    self.mainFrame.Active = true
    self.mainFrame.Draggable = true
    self.mainFrame.Parent = self.screenGui
    
    local mainCorner = Instance.new("UICorner")
    mainCorner.CornerRadius = UDim.new(0, 12)
    mainCorner.Parent = self.mainFrame
    
    -- Shadow
    local shadow = Instance.new("ImageLabel")
    shadow.Name = "Shadow"
    shadow.Size = UDim2.new(1, 30, 1, 30)
    shadow.Position = UDim2.new(0, -15, 0, -15)
    shadow.BackgroundTransparency = 1
    shadow.Image = "rbxasset://textures/ui/GuiImagePlaceholder.png"
    shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
    shadow.ImageTransparency = 0.5
    shadow.ScaleType = Enum.ScaleType.Slice
    shadow.SliceCenter = Rect.new(10, 10, 10, 10)
    shadow.ZIndex = 0
    shadow.Parent = self.mainFrame
    
    -- Title Bar
    self:CreateTitleBar()
    
    -- Content Frame
    self.contentFrame = Instance.new("ScrollingFrame")
    self.contentFrame.Size = UDim2.new(1, -20, 1, -70)
    self.contentFrame.Position = UDim2.new(0, 10, 0, 60)
    self.contentFrame.BackgroundTransparency = 1
    self.contentFrame.ScrollBarThickness = 4
    self.contentFrame.ScrollBarImageColor3 = Color3.fromRGB(80, 80, 100)
    self.contentFrame.BorderSizePixel = 0
    self.contentFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
    self.contentFrame.Parent = self.mainFrame
    
    -- Build Settings
    self:BuildSettings()
end

function MainGUI:CreateTitleBar()
    local titleBar = Instance.new("Frame")
    titleBar.Size = UDim2.new(1, 0, 0, 50)
    titleBar.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
    titleBar.BorderSizePixel = 0
    titleBar.Parent = self.mainFrame
    
    local titleCorner = Instance.new("UICorner")
    titleCorner.CornerRadius = UDim.new(0, 12)
    titleCorner.Parent = titleBar
    
    -- Title
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(1, -100, 1, 0)
    titleLabel.Position = UDim2.new(0, 20, 0, 0)
    titleLabel.Text = "XaXa Client"
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleLabel.TextSize = 24
    titleLabel.BackgroundTransparency = 1
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.Parent = titleBar
    
    -- Version
    local versionLabel = Instance.new("TextLabel")
    versionLabel.Size = UDim2.new(0, 100, 0, 20)
    versionLabel.Position = UDim2.new(0, 20, 1, -25)
    versionLabel.Text = self.config.Version
    versionLabel.Font = Enum.Font.GothamMedium
    versionLabel.TextColor3 = Color3.fromRGB(100, 100, 120)
    versionLabel.TextSize = 12
    versionLabel.BackgroundTransparency = 1
    versionLabel.TextXAlignment = Enum.TextXAlignment.Left
    versionLabel.Parent = titleBar
    
    -- Close Button
    local closeButton = Instance.new("TextButton")
    closeButton.Size = UDim2.new(0, 35, 0, 35)
    closeButton.Position = UDim2.new(1, -45, 0, 7.5)
    closeButton.Text = "×"
    closeButton.Font = Enum.Font.GothamBold
    closeButton.TextColor3 = Color3.fromRGB(255, 70, 70)
    closeButton.TextSize = 24
    closeButton.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
    closeButton.BorderSizePixel = 0
    closeButton.Parent = titleBar
    
    local closeCorner = Instance.new("UICorner")
    closeCorner.CornerRadius = UDim.new(0, 8)
    closeCorner.Parent = closeButton
    
    closeButton.MouseEnter:Connect(function()
        closeButton.BackgroundColor3 = Color3.fromRGB(255, 70, 70)
        closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    end)
    
    closeButton.MouseLeave:Connect(function()
        closeButton.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
        closeButton.TextColor3 = Color3.fromRGB(255, 70, 70)
    end)
    
    closeButton.MouseButton1Click:Connect(function()
        self:ToggleVisible()
    end)
end

function MainGUI:BuildSettings()
    local posY = 10
    
    posY = Components.CreateSection(self.contentFrame, "🎯 Aimbot Settings", posY)
    
    posY = Components.CreateToggle(self.contentFrame, "Enable Aimbot", posY, self.config.Settings.aimbotEnabled, function(value)
        self.config.Settings.aimbotEnabled = value
    end)
    
    posY = Components.CreateDropdown(
        self.contentFrame, 
        "Target Part", 
        posY, 
        {"Head", "HumanoidRootPart", "Torso"}, 
        self.config.Settings.aimbotTarget, 
        function(option)
            self.config.Settings.aimbotTarget = option
        end
    )
    
    posY = Components.CreateSlider(self.contentFrame, "Aimbot Speed", posY, 0.01, 1, self.config.Settings.aimbotSpeed, function(value)
        self.config.Settings.aimbotSpeed = value
    end)
    
    posY = Components.CreateSlider(self.contentFrame, "Aimbot Range", posY, 50, 2000, self.config.Settings.aimbotRange, function(value)
        self.config.Settings.aimbotRange = value
    end)
    
    posY = Components.CreateSlider(self.contentFrame, "FOV Size", posY, 30, 500, self.config.Settings.aimbotFOV, function(value)
        self.config.Settings.aimbotFOV = value
    end)
    
    posY = Components.CreateToggle(self.contentFrame, "Show FOV Circle", posY, self.config.Settings.showFOVCircle, function(value)
        self.config.Settings.showFOVCircle = value
    end)
    
    posY = Components.CreateToggle(self.contentFrame, "Team Check", posY, self.config.Settings.aimbotTeamCheck, function(value)
        self.config.Settings.aimbotTeamCheck = value
    end)
    
    self.contentFrame.CanvasSize = UDim2.new(0, 0, 0, posY + 20)
end

function MainGUI:ToggleVisible()
    self.visible = not self.visible
    self.mainFrame.Visible = self.visible
end

function MainGUI:SetVisible(visible)
    self.visible = visible
    self.mainFrame.Visible = visible
end

function MainGUI:GetScreenGui()
    return self.screenGui
end

function MainGUI:Destroy()
    if self.screenGui then
        self.screenGui:Destroy()
    end
end

return MainGUI