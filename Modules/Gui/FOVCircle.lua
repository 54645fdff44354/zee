local FOVCircle = {}

function FOVCircle.new(config)
    local self = setmetatable({}, {__index = FOVCircle})
    
    self.config = config
    self.camera = workspace.CurrentCamera
    
    self.circle = Drawing.new("Circle")
    self.circle.Visible = config.Settings.showFOVCircle
    self.circle.Radius = config.Settings.aimbotFOV
    self.circle.Color = config.Visual.primaryColor
    self.circle.Thickness = 2
    self.circle.Transparency = 0.7
    self.circle.NumSides = 64
    self.circle.Filled = false
    
    return self
end

function FOVCircle:Update()
    if self.circle then
        self.circle.Position = Vector2.new(
            self.camera.ViewportSize.X / 2, 
            self.camera.ViewportSize.Y / 2
        )
        self.circle.Radius = self.config.Settings.aimbotFOV
        self.circle.Visible = self.config.Settings.showFOVCircle
    end
end

function FOVCircle:SetVisible(visible)
    if self.circle then
        self.circle.Visible = visible
    end
end

function FOVCircle:Destroy()
    if self.circle then
        self.circle:Remove()
        self.circle = nil
    end
end

return FOVCircle