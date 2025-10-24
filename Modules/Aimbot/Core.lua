local Prediction = require(script.Parent.Prediction)

local AimbotCore = {}

function AimbotCore.new(config, player, camera, targetSelection, inputHandler)
    local self = setmetatable({}, {__index = AimbotCore})
    
    self.config = config
    self.player = player
    self.camera = camera
    self.targetSelection = targetSelection
    self.inputHandler = inputHandler
    
    return self
end

function AimbotCore:Run()
    if not self.config.Settings.aimbotEnabled then
        return
    end
    
    if not self.inputHandler:IsKeyDown("rightClick") then
        return
    end
    
    local enemy, targetPart = self.targetSelection:GetClosestEnemy()
    
    if enemy and targetPart then
        local targetPos = targetPart.Position

        if targetPart.Velocity.Magnitude > 0.1 then
            local distance = (self.camera.CFrame.Position - targetPos).Magnitude
            local predictionTime = Prediction.CalculatePredictionTime(distance)
            targetPos = Prediction.PredictMovement(targetPart, predictionTime)
        end
        
        if targetPos then
            local newCFrame = CFrame.new(self.camera.CFrame.Position, targetPos)
            self.camera.CFrame = self.camera.CFrame:Lerp(newCFrame, self.config.Settings.aimbotSpeed)
        end
    end
end

return AimbotCore