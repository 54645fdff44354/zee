local Notification = {}

function Notification.new(parent, config)
    local self = setmetatable({}, {__index = Notification})
    
    self.parent = parent
    self.config = config or {}
    
    return self
end

function Notification:Show(title, description, duration)
    duration = duration or 3
    
    local notification = Instance.new("Frame")
    notification.Size = UDim2.new(0, 300, 0, 80)
    notification.Position = UDim2.new(0.5, -150, 0, -100)
    notification.BackgroundColor3 = self.config.backgroundColor or Color3.fromRGB(20, 20, 25)
    notification.BorderSizePixel = 0
    notification.Parent = self.parent
    
    local notifCorner = Instance.new("UICorner")
    notifCorner.CornerRadius = UDim.new(0, 12)
    notifCorner.Parent = notification
    
    local notifTitle = Instance.new("TextLabel")
    notifTitle.Size = UDim2.new(1, 0, 0, 30)
    notifTitle.Text = title
    notifTitle.Font = Enum.Font.GothamBold
    notifTitle.TextColor3 = self.config.primaryColor or Color3.fromRGB(80, 200, 120)
    notifTitle.TextSize = 16
    notifTitle.BackgroundTransparency = 1
    notifTitle.Parent = notification
    
    local notifDesc = Instance.new("TextLabel")
    notifDesc.Size = UDim2.new(1, -20, 0, 40)
    notifDesc.Position = UDim2.new(0, 10, 0, 35)
    notifDesc.Text = description
    notifDesc.Font = Enum.Font.GothamMedium
    notifDesc.TextColor3 = Color3.fromRGB(200, 200, 210)
    notifDesc.TextSize = 13
    notifDesc.BackgroundTransparency = 1
    notifDesc.TextWrapped = true
    notifDesc.Parent = notification
    
    -- Animate in
    notification:TweenPosition(
        UDim2.new(0.5, -150, 0, 20),
        Enum.EasingDirection.Out,
        Enum.EasingStyle.Back,
        0.5,
        true
    )
    
    task.wait(duration)
    
    -- Animate out
    notification:TweenPosition(
        UDim2.new(0.5, -150, 0, -100),
        Enum.EasingDirection.In,
        Enum.EasingStyle.Back,
        0.5,
        true,
        function()
            notification:Destroy()
        end
    )
end

return Notification