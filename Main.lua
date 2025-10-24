-- ==================== IMPORTS ====================
local Config = require(script.Config)
local Notification = require(script.Modules.Utils.Notification)
local Input = require(script.Modules.Utils.Input)
local FOVCircle = require(script.Modules.GUI.FOVCircle)
local MainGUI = require(script.Modules.GUI.MainGUI)
local TargetSelection = require(script.Modules.Aimbot.TargetSelection)
local AimbotCore = require(script.Modules.Aimbot.Core)

-- ==================== SERVICES ====================
local player = game.Players.LocalPlayer
local camera = workspace.CurrentCamera
local runService = game:GetService("RunService")

-- ==================== INITIALIZE MODULES ====================

-- Input Handler
local inputHandler = Input.new(Config)

-- Main GUI
local mainGUI = MainGUI.new(Config, player)

-- FOV Circle
local fovCircle = FOVCircle.new(Config)

-- Target Selection (SIN crear Part en workspace)
local targetSelection = TargetSelection.new(Config, player, camera)

-- Aimbot Core
local aimbotCore = AimbotCore.new(Config, player, camera, targetSelection, inputHandler)

-- Notification System
local notificationSystem = Notification.new(mainGUI:GetScreenGui(), Config.Visual)

-- ==================== INPUT HANDLING ====================

inputHandler:OnInputBegan(function(input, gameProcessed)
    if not gameProcessed and input.KeyCode == Config.Controls.toggleGUI then
        mainGUI:ToggleVisible()
    end
    
    if input.UserInputType == Config.Controls.activateAimbot then
        inputHandler:SetState("rightClick", true)
    end
end)

inputHandler:OnInputEnded(function(input)
    if input.UserInputType == Config.Controls.activateAimbot then
        inputHandler:SetState("rightClick", false)
    end
end)

-- ==================== MAIN LOOP ====================

runService.RenderStepped:Connect(function()
    -- Update FOV Circle
    fovCircle:Update()
    
    -- Run Aimbot
    aimbotCore:Run()
end)

-- ==================== STARTUP ====================

notificationSystem:Show(
    "✅ XaXa Client Loaded",
    "Press INSERT to toggle GUI\nHold RIGHT CLICK to aim",
    3
)

print("=====================================")
print("✅ XaXa Client " .. Config.Version .. " Loaded")
print("=====================================")
print("🎮 Controls:")
print("   [INSERT] - Toggle GUI")
print("   [RIGHT CLICK] - Activate Aimbot")
print("=====================================")
print("Made with ❤️ by ng - Modular Edition")

-- ==================== CLEANUP ====================

game:GetService("Players").PlayerRemoving:Connect(function(plr)
    if plr == player then
        fovCircle:Destroy()
        targetSelection:Destroy()
        mainGUI:Destroy()
    end
end)