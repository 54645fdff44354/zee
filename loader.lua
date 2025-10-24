local baseURL = "https://raw.githubusercontent.com/54645fdff44354/zee/main.lua/"

local modules = {}

local function githubRequire(path)
    if modules[path] then
        return modules[path]
    end
    
    local fullURL = baseURL .. path
    print("📦 Loading: " .. path)
    
    local success, source = pcall(function()
        return game:HttpGet(fullURL, true)
    end)
    
    if not success then
        error("Failed to load module: " .. path)
    end
    
    local func, err = loadstring(source)
    if not func then
        error("Syntax error in " .. path .. ": " .. tostring(err))
    end
    
    local env = getfenv(func)
    local oldRequire = env.require
    
    env.require = function(modulePath)
        if type(modulePath) == "string" then
            return githubRequire(modulePath)
        end
        
        local pathStr = tostring(modulePath)
        if pathStr:match("Parent") then
            local moduleName = pathStr:match("%.([^%.]+)$")
            
            local paths = {
                "Modules/Aimbot/" .. moduleName .. ".lua",
                "Modules/GUI/" .. moduleName .. ".lua",
                "Modules/Utils/" .. moduleName .. ".lua",
            }
            
            for _, p in ipairs(paths) do
                local ok, mod = pcall(githubRequire, p)
                if ok then return mod end
            end
        end
        
        return oldRequire(modulePath)
    end
    
    setfenv(func, env)
    
    local module = func()
    modules[path] = module
    
    print("✅ Loaded: " .. path)
    return module
end

print("🚀 XaXa Client - Starting...")
githubRequire("Main.lua")
