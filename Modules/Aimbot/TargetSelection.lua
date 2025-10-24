local TargetSelection = {}

function TargetSelection.new(config, player, camera)
    local self = setmetatable({}, {__index = TargetSelection})
    
    self.config = config
    self.player = player
    self.camera = camera
    self.userInputService = game:GetService("UserInputService")
    
    return self
end

function TargetSelection:GetClosestEnemy()
    local closestEnemy = nil
    local closestPart = nil
    local shortestDistance = math.huge
    local mousePos = self.userInputService:GetMouseLocation()
    
    for _, otherPlayer in pairs(game.Players:GetPlayers()) do
        if otherPlayer ~= self.player and otherPlayer.Character then
            if self.config.Settings.aimbotTeamCheck and otherPlayer.Team == self.player.Team then
                continue
            end
            
            local targetPart = otherPlayer.Character:FindFirstChild(self.config.Settings.aimbotTarget)
            if not targetPart then
                targetPart = otherPlayer.Character:FindFirstChild("HumanoidRootPart")
            end
            
            if targetPart then
                local targetPos = targetPart.Position
                local distance = (self.camera.CFrame.Position - targetPos).Magnitude
                
                if distance <= self.config.Settings.aimbotRange then
                    local screenPos, onScreen = self.camera:WorldToViewportPoint(targetPos)
                    
                    if onScreen then
                        local screenDistance = (Vector2.new(screenPos.X, screenPos.Y) - mousePos).Magnitude
                        
                        if screenDistance <= self.config.Settings.aimbotFOV then
                            local ray = Ray.new(
                                self.camera.CFrame.Position, 
                                (targetPos - self.camera.CFrame.Position).Unit * distance
                            )
                            local hit = workspace:FindPartOnRayWithIgnoreList(
                                ray, 
                                {self.player.Character}
                            )
                            
                            if not hit or hit:IsDescendantOf(otherPlayer.Character) then
                                if screenDistance < shortestDistance then
                                    closestEnemy = otherPlayer.Character
                                    closestPart = targetPart
                                    shortestDistance = screenDistance
                                end
                            end
                        end
                    end
                end
            end
        end
    end
    
    return closestEnemy, closestPart
end

function TargetSelection:Destroy()
    
end

return TargetSelection