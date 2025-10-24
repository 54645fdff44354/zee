--[[
    XaXa Client Loader v2 - FIXED
    GitHub: 54645fdff44354/zee
]]

local baseURL = "https://raw.githubusercontent.com/54645fdff44354/zee/Main.lua"

print("🚀 XaXa Client Loader v2 Starting...")
print("📡 Repository: 54645fdff44354/zee")

-- ==================== MODULE CACHE ====================
local loadedModules = {}
local loading = {}

-- ==================== HTTP GET WITH RETRY ====================
local function httpGet(url, retries)
    retries = retries or 3
    
    for i = 1, retries do
        local success, result = pcall(function()
            return game:HttpGet(url, true)
        end)
        
        if success and result and result ~= "" then
            return result
        end
        
        if i < retries then
            warn("⚠️ Retry " .. i .. " for: " .. url)
            task.wait(0.5)
        end
    end
    
    error("❌ Failed to download: " .. url)
end

-- ==================== LOAD MODULE FUNCTION ====================
local function loadModule(modulePath)
    -- Check if already loaded
    if loadedModules[modulePath] then
        return loadedModules[modulePath]
    end
    
    -- Check for circular dependency
    if loading[modulePath] then
        warn("⚠️ Circular dependency detected: " .. modulePath)
        return nil
    end
    
    loading[modulePath] = true
    
    print("📦 Loading: " .. modulePath)
    
    -- Download source
    local url = baseURL .. modulePath
    local source = httpGet(url)
    
    -- Parse and execute
    local moduleFunc, syntaxError = loadstring(source, modulePath)
    
    if not moduleFunc then
        error("❌ Syntax error in " .. modulePath .. ":\n" .. tostring(syntaxError))
    end
    
    -- Create custom environment
    local env = setmetatable({}, {__index = _G})
    
    -- Custom require handler
    env.require = function(arg)
        if type(arg) == "string" then
            -- Direct path
            return loadModule(arg)
        else
            -- Handle require(script.Parent.ModuleName)
            local argStr = tostring(arg)
            
            -- Extract module name
            local moduleName = argStr:match("%.([^%.]+)$")
            
            if not moduleName then
                error("❌ Cannot parse require: " .. argStr)
            end
            
            -- Determine current directory
            local currentDir = modulePath:match("(.*/)")
            
            -- Try relative path first
            if currentDir then
                local relativePath = currentDir .. moduleName .. ".lua"
                local success, module = pcall(loadModule, relativePath)
                if success then
                    return module
                end
            end
            
            -- Try common locations
            local searchPaths = {
                "Modules/Aimbot/" .. moduleName .. ".lua",
                "Modules/GUI/" .. moduleName .. ".lua",
                "Modules/Utils/" .. moduleName .. ".lua",
                moduleName .. ".lua",
            }
            
            for _, path in ipairs(searchPaths) do
                local success, module = pcall(loadModule, path)
                if success and module then
                    return module
                end
            end
            
            error("❌ Module not found: " .. moduleName)
        end
    end
    
    -- Mock script object
    env.script = {
        Name = modulePath:match("([^/]+)%.lua$") or modulePath,
        Parent = {}
    }
    
    setfenv(moduleFunc, env)
    
    -- Execute module
    local success, result = pcall(moduleFunc)
    
    if not success then
        error("❌ Runtime error in " .. modulePath .. ":\n" .. tostring(result))
    end
    
    loadedModules[modulePath] = result
    loading[modulePath] = false
    
    print("✅ Loaded: " .. modulePath)
    
    return result
end

-- ==================== LOAD ALL MODULES ====================

local success, err = pcall(function()
    print("\n📚 Loading Configuration...")
    local Config = loadModule("Config.lua")
    
    print("\n🛠️ Loading Utilities...")
    local Notification = loadModule("Modules/Utils/Notification.lua")
    local Input = loadModule("Modules/Utils/Input.lua")
    
    print("\n🎨 Loading GUI Components...")
    local Components = loadModule("Modules/GUI/Components.lua")
    local FOVCircle = loadModule("Modules/GUI/FOVCircle.lua")
    local MainGUI = loadModule("Modules/GUI/MainGUI.lua")
    
    print("\n🎯 Loading Aimbot Modules...")
    local Prediction = loadModule("Modules/Aimbot/Prediction.lua")
    local TargetSelection = loadModule("Modules/Aimbot/TargetSelection.lua")
    local AimbotCore = loadModule("Modules/Aimbot/Core.lua")
    
    print("\n⚙️ Initializing Systems...")
    
    -- Services
    local player = game.Players.LocalPlayer
    local camera = workspace.CurrentCamera
    local runService = game:GetService("RunService")
    
    -- Initialize
    local inputHandler = Input.new(Config)
    local mainGUI = MainGUI.new(Config, player)
    local fovCircle = FOVCircle.new(Config)
    local targetSelection = TargetSelection.new(Config, player, camera)
    local aimbotCore = AimbotCore.new(Config, player, camera, targetSelection, inputHandler)
    local notificationSystem = Notification.new(mainGUI:GetScreenGui(), Config.Visual)
    
    -- Input Handling
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
    
    -- Main Loop
    runService.RenderStepped:Connect(function()
        fovCircle:Update()
        aimbotCore:Run()
    end)
    
    -- Startup
    notificationSystem:Show(
        "✅ XaXa Client Loaded",
        "Press INSERT to toggle GUI\nHold RIGHT CLICK to aim",
        3
    )
    
    print("\n" .. string.rep("=", 45))
    print("✅ XaXa Client " .. Config.Version .. " LOADED!")
    print(string.rep("=", 45))
    print("🎮 Controls:")
    print("   [INSERT] - Toggle GUI")
    print("   [RIGHT CLICK] - Activate Aimbot")
    print(string.rep("=", 45))
    print("📦 Repository: github.com/54645fdff44354/zee")
    print("Made with ❤️ by XaXa")
    print(string.rep("=", 45) .. "\n")
    
    -- Cleanup
    game:GetService("Players").PlayerRemoving:Connect(function(plr)
        if plr == player then
            pcall(function() fovCircle:Destroy() end)
            pcall(function() targetSelection:Destroy() end)
            pcall(function() mainGUI:Destroy() end)
            print("🧹 XaXa Client cleaned up")
        end
    end)
end)

if not success then
    warn("\n" .. string.rep("=", 45))
    warn("❌ XAXA CLIENT FAILED TO LOAD")
    warn(string.rep("=", 45))
    warn("Error: " .. tostring(err))
    warn(string.rep("=", 45) .. "\n")
end
