local Prediction = {}

function Prediction.PredictMovement(targetPart, time)
    if not targetPart or not targetPart:IsA("BasePart") then
        return nil
    end
    
    local velocity = targetPart.Velocity
    if velocity.Magnitude < 0.1 then
        return targetPart.Position
    end
    
    local futurePosition = targetPart.Position + (velocity * time)
    return futurePosition
end

function Prediction.CalculatePredictionTime(distance)
    local baseTime = 0.1
    local maxTime = 0.3
    
    local predictionTime = baseTime + (distance / 1000) * (maxTime - baseTime)
    return math.clamp(predictionTime, baseTime, maxTime)
end

return Prediction