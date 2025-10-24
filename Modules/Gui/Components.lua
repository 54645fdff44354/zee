local Components = {}
local userInputService = game:GetService("UserInputService")
local runService = game:GetService("RunService")

-- ==================== SECTION ====================
function Components.CreateSection(parent, title, posY)
    local section = Instance.new("Frame")
    section.Size = UDim2.new(1, -20, 0, 30)
    section.Position = UDim2.new(0, 10, 0, posY)
    section.BackgroundTransparency = 1
    section.Parent = parent
    
    local sectionTitle = Instance.new("TextLabel")
    sectionTitle.Size = UDim2.new(1, 0, 1, 0)
    sectionTitle.Text = title
    sectionTitle.Font = Enum.Font.GothamBold
    sectionTitle.TextColor3 = Color3.fromRGB(150, 150, 170)
    sectionTitle.TextSize = 16
    sectionTitle.BackgroundTransparency = 1
    sectionTitle.TextXAlignment = Enum.TextXAlignment.Left
    sectionTitle.Parent = section
    
    local line = Instance.new("Frame")
    line.Size = UDim2.new(1, 0, 0, 2)
    line.Position = UDim2.new(0, 0, 1, -2)
    line.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
    line.BorderSizePixel = 0
    line.Parent = section
    
    return posY + 40
end

-- ==================== TOGGLE ====================
function Components.CreateToggle(parent, name, posY, defaultValue, callback)
    local toggleFrame = Instance.new("Frame")
    toggleFrame.Size = UDim2.new(1, -20, 0, 40)
    toggleFrame.Position = UDim2.new(0, 10, 0, posY)
    toggleFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 38)
    toggleFrame.BorderSizePixel = 0
    toggleFrame.Parent = parent
    
    local toggleCorner = Instance.new("UICorner")
    toggleCorner.CornerRadius = UDim.new(0, 8)
    toggleCorner.Parent = toggleFrame
    
    local toggleLabel = Instance.new("TextLabel")
    toggleLabel.Size = UDim2.new(0.7, 0, 1, 0)
    toggleLabel.Position = UDim2.new(0, 15, 0, 0)
    toggleLabel.Text = name
    toggleLabel.Font = Enum.Font.GothamMedium
    toggleLabel.TextColor3 = Color3.fromRGB(230, 230, 240)
    toggleLabel.TextSize = 14
    toggleLabel.TextXAlignment = Enum.TextXAlignment.Left
    toggleLabel.BackgroundTransparency = 1
    toggleLabel.Parent = toggleFrame
    
    local toggleButton = Instance.new("Frame")
    toggleButton.Size = UDim2.new(0, 40, 0, 20)
    toggleButton.Position = UDim2.new(1, -50, 0.5, -10)
    toggleButton.BackgroundColor3 = defaultValue and Color3.fromRGB(80, 200, 120) or Color3.fromRGB(60, 60, 70)
    toggleButton.BorderSizePixel = 0
    toggleButton.Parent = toggleFrame
    
    local toggleBtnCorner = Instance.new("UICorner")
    toggleBtnCorner.CornerRadius = UDim.new(1, 0)
    toggleBtnCorner.Parent = toggleButton
    
    local toggleCircle = Instance.new("Frame")
    toggleCircle.Size = UDim2.new(0, 16, 0, 16)
    toggleCircle.Position = defaultValue and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8)
    toggleCircle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    toggleCircle.BorderSizePixel = 0
    toggleCircle.Parent = toggleButton
    
    local circleCorner = Instance.new("UICorner")
    circleCorner.CornerRadius = UDim.new(1, 0)
    circleCorner.Parent = toggleCircle
    
    local value = defaultValue
    
    toggleFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            value = not value
            
            toggleButton.BackgroundColor3 = value and Color3.fromRGB(80, 200, 120) or Color3.fromRGB(60, 60, 70)
            toggleCircle:TweenPosition(
                value and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8),
                Enum.EasingDirection.Out,
                Enum.EasingStyle.Quart,
                0.2,
                true
            )
            
            callback(value)
        end
    end)
    
    return posY + 50
end

-- ==================== SLIDER ====================
function Components.CreateSlider(parent, name, posY, minValue, maxValue, defaultValue, callback)
    local sliderFrame = Instance.new("Frame")
    sliderFrame.Size = UDim2.new(1, -20, 0, 60)
    sliderFrame.Position = UDim2.new(0, 10, 0, posY)
    sliderFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 38)
    sliderFrame.BorderSizePixel = 0
    sliderFrame.Parent = parent
    
    local sliderCorner = Instance.new("UICorner")
    sliderCorner.CornerRadius = UDim.new(0, 8)
    sliderCorner.Parent = sliderFrame
    
    local sliderLabel = Instance.new("TextLabel")
    sliderLabel.Size = UDim2.new(0.7, 0, 0, 20)
    sliderLabel.Position = UDim2.new(0, 15, 0, 10)
    sliderLabel.Text = name
    sliderLabel.Font = Enum.Font.GothamMedium
    sliderLabel.TextColor3 = Color3.fromRGB(230, 230, 240)
    sliderLabel.TextSize = 14
    sliderLabel.TextXAlignment = Enum.TextXAlignment.Left
    sliderLabel.BackgroundTransparency = 1
    sliderLabel.Parent = sliderFrame
    
    local valueLabel = Instance.new("TextLabel")
    valueLabel.Size = UDim2.new(0, 60, 0, 20)
    valueLabel.Position = UDim2.new(1, -70, 0, 10)
    valueLabel.Text = tostring(defaultValue)
    valueLabel.Font = Enum.Font.GothamBold
    valueLabel.TextColor3 = Color3.fromRGB(80, 200, 120)
    valueLabel.TextSize = 14
    valueLabel.TextXAlignment = Enum.TextXAlignment.Right
    valueLabel.BackgroundTransparency = 1
    valueLabel.Parent = sliderFrame
    
    local sliderBar = Instance.new("Frame")
    sliderBar.Size = UDim2.new(1, -30, 0, 6)
    sliderBar.Position = UDim2.new(0, 15, 0, 40)
    sliderBar.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
    sliderBar.BorderSizePixel = 0
    sliderBar.Parent = sliderFrame
    
    local barCorner = Instance.new("UICorner")
    barCorner.CornerRadius = UDim.new(1, 0)
    barCorner.Parent = sliderBar
    
    local sliderFill = Instance.new("Frame")
    sliderFill.Size = UDim2.new((defaultValue - minValue) / (maxValue - minValue), 0, 1, 0)
    sliderFill.BackgroundColor3 = Color3.fromRGB(80, 200, 120)
    sliderFill.BorderSizePixel = 0
    sliderFill.Parent = sliderBar
    
    local fillCorner = Instance.new("UICorner")
    fillCorner.CornerRadius = UDim.new(1, 0)
    fillCorner.Parent = sliderFill
    
    local sliderButton = Instance.new("Frame")
    sliderButton.Size = UDim2.new(0, 16, 0, 16)
    sliderButton.Position = UDim2.new((defaultValue - minValue) / (maxValue - minValue), -8, 0.5, -8)
    sliderButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    sliderButton.BorderSizePixel = 0
    sliderButton.Parent = sliderBar
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(1, 0)
    btnCorner.Parent = sliderButton
    
    local value = defaultValue
    
    local function updateSlider(mouseX)
        local absoluteX = mouseX - sliderBar.AbsolutePosition.X
        local relativeX = math.clamp(absoluteX / sliderBar.AbsoluteSize.X, 0, 1)
        value = minValue + (maxValue - minValue) * relativeX
        value = math.floor(value * 10) / 10
        
        sliderFill.Size = UDim2.new(relativeX, 0, 1, 0)
        sliderButton.Position = UDim2.new(relativeX, -8, 0.5, -8)
        valueLabel.Text = tostring(value)
        
        callback(value)
    end
    
    local dragging = false
    
    sliderButton.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
        end
    end)
    
    userInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
    
    runService.RenderStepped:Connect(function()
        if dragging then
            updateSlider(userInputService:GetMouseLocation().X)
        end
    end)
    
    sliderBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            updateSlider(input.Position.X)
        end
    end)
    
    return posY + 70
end

-- ==================== DROPDOWN ====================
function Components.CreateDropdown(parent, name, posY, options, defaultOption, callback)
    local dropdownFrame = Instance.new("Frame")
    dropdownFrame.Size = UDim2.new(1, -20, 0, 40)
    dropdownFrame.Position = UDim2.new(0, 10, 0, posY)
    dropdownFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 38)
    dropdownFrame.BorderSizePixel = 0
    dropdownFrame.Parent = parent
    
    local dropCorner = Instance.new("UICorner")
    dropCorner.CornerRadius = UDim.new(0, 8)
    dropCorner.Parent = dropdownFrame
    
    local dropLabel = Instance.new("TextLabel")
    dropLabel.Size = UDim2.new(0.4, 0, 1, 0)
    dropLabel.Position = UDim2.new(0, 15, 0, 0)
    dropLabel.Text = name
    dropLabel.Font = Enum.Font.GothamMedium
    dropLabel.TextColor3 = Color3.fromRGB(230, 230, 240)
    dropLabel.TextSize = 14
    dropLabel.TextXAlignment = Enum.TextXAlignment.Left
    dropLabel.BackgroundTransparency = 1
    dropLabel.Parent = dropdownFrame
    
    local selectedLabel = Instance.new("TextLabel")
    selectedLabel.Size = UDim2.new(0.5, -40, 1, 0)
    selectedLabel.Position = UDim2.new(0.5, 0, 0, 0)
    selectedLabel.Text = defaultOption
    selectedLabel.Font = Enum.Font.GothamBold
    selectedLabel.TextColor3 = Color3.fromRGB(80, 200, 120)
    selectedLabel.TextSize = 14
    selectedLabel.TextXAlignment = Enum.TextXAlignment.Right
    selectedLabel.BackgroundTransparency = 1
    selectedLabel.Parent = dropdownFrame
    
    local arrow = Instance.new("TextLabel")
    arrow.Size = UDim2.new(0, 20, 1, 0)
    arrow.Position = UDim2.new(1, -30, 0, 0)
    arrow.Text = "▼"
    arrow.Font = Enum.Font.GothamBold
    arrow.TextColor3 = Color3.fromRGB(150, 150, 170)
    arrow.TextSize = 12
    arrow.BackgroundTransparency = 1
    arrow.Parent = dropdownFrame
    
    local optionsFrame = Instance.new("Frame")
    optionsFrame.Size = UDim2.new(1, -20, 0, #options * 35)
    optionsFrame.Position = UDim2.new(0, 10, 0, posY + 45)
    optionsFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
    optionsFrame.BorderSizePixel = 0
    optionsFrame.Visible = false
    optionsFrame.ZIndex = 10
    optionsFrame.Parent = parent
    
    local optCorner = Instance.new("UICorner")
    optCorner.CornerRadius = UDim.new(0, 8)
    optCorner.Parent = optionsFrame
    
    for i, option in ipairs(options) do
        local optionBtn = Instance.new("TextButton")
        optionBtn.Size = UDim2.new(1, -10, 0, 30)
        optionBtn.Position = UDim2.new(0, 5, 0, (i-1) * 35 + 2.5)
        optionBtn.Text = option
        optionBtn.Font = Enum.Font.GothamMedium
        optionBtn.TextColor3 = Color3.fromRGB(230, 230, 240)
        optionBtn.TextSize = 13
        optionBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
        optionBtn.BorderSizePixel = 0
        optionBtn.ZIndex = 11
        optionBtn.Parent = optionsFrame
        
        local optBtnCorner = Instance.new("UICorner")
        optBtnCorner.CornerRadius = UDim.new(0, 6)
        optBtnCorner.Parent = optionBtn
        
        optionBtn.MouseEnter:Connect(function()
            optionBtn.BackgroundColor3 = Color3.fromRGB(80, 200, 120)
        end)
        
        optionBtn.MouseLeave:Connect(function()
            optionBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
        end)
        
        optionBtn.MouseButton1Click:Connect(function()
            selectedLabel.Text = option
            optionsFrame.Visible = false
            callback(option)
        end)
    end
    
    dropdownFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            optionsFrame.Visible = not optionsFrame.Visible
        end
    end)
    
    return posY + 50
end

return Components