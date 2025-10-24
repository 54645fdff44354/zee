local Config = {}

-- Settings
Config.Settings = {
    aimbotEnabled = false,
    aimbotSpeed = 0.2,
    aimbotTarget = "Head",
    aimbotVisibility = false, -- CAMBIADO: ya no muestra la part
    aimbotRange = 500,
    aimbotFOV = 100,
    aimbotAutoShoot = false,
    aimbotTeamCheck = false,
    aimbotSensitivity = 0.5,
    showFOVCircle = true,
}

-- Controls
Config.Controls = {
    toggleGUI = Enum.KeyCode.Insert,
    activateAimbot = Enum.UserInputType.MouseButton2,
}

-- Visual Settings
Config.Visual = {
    primaryColor = Color3.fromRGB(80, 200, 120),
    backgroundColor = Color3.fromRGB(20, 20, 25),
    frameColor = Color3.fromRGB(30, 30, 38),
}

-- Version
Config.Version = "v1.0 Modular"

return Config