--------------------------------------------------
-- KAMETHOD CLOUD v1.8
--------------------------------------------------

-- 1. REMOTE CONFIGURATION
-- Replace the URL below with your actual Raw GitHub link for time.txt
local TIME_URL = "https://raw.githubusercontent.com/OGZlessur/KAMETHODLUA/refs/heads/main/time.txt"

-- 2. ANTI-DUMP PROTECTION
local _load = load
load = function(c, n, m, e)
    if n and (n:find("ACTUAL") or n:find("reveal")) then 
        gg.alert("🛡️ Security Block: Unauthorized dumping detected.")
        os.exit() 
    end
    return _load(c, n, m, e)
end



-- 3. DYNAMIC EXPIRATION CHECK (REMOTE)
local function checkExpiry()
    local response = gg.makeRequest(TIME_URL)
    
    if not response or not response.content then
        gg.alert("📡 [NETWORK ERROR]\nCould not verify subscription time.\nPlease check your internet connection.")
        return true
    end

    -- Extract number from the text file
    local expire_timestamp = tonumber(response.content:match("%d+"))
    local current_time = os.time()
    
    if not expire_timestamp then
        gg.alert("❌ [SERVER ERROR]\nInvalid time format on server.")
        return true
    end
    
    if current_time > expire_timestamp then
        gg.alert("⌛ [EXPIRED]\n\nYour Time: " .. os.date("%Y-%m-%d %H:%M:%S", current_time) .. 
                 "\nExpiry Set: " .. os.date("%Y-%m-%d %H:%M:%S", expire_timestamp) ..
                 "\n\nPlease contact KAMETHOD for renewal.")
        return true 
    end
    
    local left = expire_timestamp - current_time
    local hours = math.floor(left/3600)
    gg.toast(string.format("✅ KAMETHOD Active: %dh remaining", hours))
    return false
end

-- Run Expiry Check
if checkExpiry() then return end

gg.setVisible(false)
gg.clearResults()

-- 4. TARGET CHECK (SAFELY HANDLED)
local info = gg.getTargetInfo()
if not info then
    gg.alert("❌ No Game Selected!\n\nPlease click the GG icon and select the game process BEFORE running the script.")
    return 
end

--------------------------------------------------
-- KAMETHOD SAFE DRONE + MAPHACK + NOGRASS (GG KO)
--------------------------------------------------



gg.setVisible(false)
gg.clearResults()

local scanned = false
local V1, V2, V3, V4, V5

--------------------------------------------------
-- MAP FEATURES (STABLE SEARCH & WRITE)
--------------------------------------------------

-- Feature: Ultimate Maphack (Visibility)
function ULTIMATE_MAPHACK()
    gg.clearResults()
    gg.setRanges(gg.REGION_ANONYMOUS)
    gg.searchNumber("2.25F;9.18354962e-41F;1.40129846e-45F", gg.TYPE_FLOAT)
    gg.refineNumber("2.25", gg.TYPE_FLOAT)
    local results = gg.getResults(gg.getResultsCount())
    for i, v in ipairs(results) do v.value = 5 end
    gg.setValues(results)
    gg.toast("✅ Ultimate Maphack ON")
    gg.clearResults()
end

-- Feature: No Icon (Fog Bypass)
function MAPHACK_NO_ICON()
    gg.clearResults()
    gg.setRanges(gg.REGION_ANONYMOUS | gg.REGION_C_ALLOC)
    gg.searchNumber("98,784,247,822;47,244,640,279", gg.TYPE_QWORD)
    local results = gg.getResults(gg.getResultsCount())
    for i, v in ipairs(results) do
        if v.value == 98784247822 then v.value = 98784247823 end
    end
    gg.setValues(results)
    gg.toast("🔥 No Icon ON")
    gg.clearResults()
end


-- Feature: Syncing Shaders (Grass/Icon Visibility)
function SYNC_SHADERS()
    gg.clearResults()
    gg.setRanges(gg.REGION_ANONYMOUS)
    gg.toast("🎨 Syncing Shaders...")
    -- Searching for the shader logic group
    gg.searchNumber("11D;23D;7602241D;51D;121D", gg.TYPE_DWORD)
    local count = gg.getResultCount()
    if count > 0 then
        local results = gg.getResults(count)
        for i, v in ipairs(results) do
            if v.value == 11 then v.value = 12 end -- Modify the primary shader index
        end
        gg.setValues(results)
        gg.toast("✨ Shaders Synced (Grass Bypass)")
    else
        gg.toast("⚠️ Shader pattern not found")
    end
    gg.clearResults()
end

--------------------------------------------------
-- DRONE VIEW (SCAN ONCE)
--------------------------------------------------
local scanned = false
local V1, V2, V3, V4, V5

local function scanDrone()
    if scanned then return end

    gg.clearResults()
    gg.searchNumber("7.65999984741", gg.TYPE_FLOAT)
    V1 = gg.getResults(1000)
    gg.clearResults()

    gg.searchNumber("-10.97999954224", gg.TYPE_FLOAT)
    V2 = gg.getResults(1000)
    gg.clearResults()

    gg.searchNumber("7.61999988556", gg.TYPE_FLOAT)
    V3 = gg.getResults(1000)
    gg.clearResults()

    gg.searchNumber("-7.65999984741", gg.TYPE_FLOAT)
    V4 = gg.getResults(1000)
    gg.clearResults()

    gg.searchNumber("-7.61999988556", gg.TYPE_FLOAT)
    V5 = gg.getResults(1000)
    gg.clearResults()

    scanned = true
    gg.toast("Drone scan OK")
end

--------------------------------------------------
-- APPLY DRONE LEVEL (FIXED)
--------------------------------------------------
local function applyDrone(level)
    if not scanned then
        gg.toast("Scan drone first")
        return
    end

    local preset = {
        [1]={13.04,-18.25,12.96,-13.04,-12.96},
        [2]={15.04,-20.75,14.96,-15.04,-14.96},
        [3]={17.04,-22.15,16.96,-17.04,-16.96},
        [4]={19.04,-24.15,18.96,-19.04,-18.96},
        [5]={21.04,-26.15,20.96,-21.04,-20.96},
        [6]={23.04,-28.15,22.96,-23.04,-22.96},
        [7]={25.04,-30.15,24.96,-25.04,-24.96},
        [8]={27.04,-32.15,26.96,-27.04,-26.96},
        [9]={29.04,-34.15,28.96,-29.04,-28.96},
        [10]={31.04,-36.15,30.96,-31.04,-30.96},
    }

    local p = preset[level]
    if not p then return end

    gg.loadResults(V1); gg.getResults(#V1); gg.editAll(p[1], gg.TYPE_FLOAT); gg.clearResults()
    gg.loadResults(V2); gg.getResults(#V2); gg.editAll(p[2], gg.TYPE_FLOAT); gg.clearResults()
    gg.loadResults(V3); gg.getResults(#V3); gg.editAll(p[3], gg.TYPE_FLOAT); gg.clearResults()
    gg.loadResults(V4); gg.getResults(#V4); gg.editAll(p[4], gg.TYPE_FLOAT); gg.clearResults()
    gg.loadResults(V5); gg.getResults(#V5); gg.editAll(p[5], gg.TYPE_FLOAT); gg.clearResults()

    gg.toast("Drone View X" .. level .. " ON")
end
--------------------------------------------------
-- MAIN MENU
--------------------------------------------------
while true do
    if gg.isVisible(true) then
        gg.setVisible(false)

        local m = gg.prompt(
            {
                "🚀 Ultimate Maphack", 
                "👁️ Maphack No Icon", 
                "🎨 Sync Shaders (Low Lag)", 
                "📡 Scan Drone (Once)", 
                "🚁 Drone Level (1-10)"
            },
            {false, false, false, false, 5},
            {"checkbox", "checkbox", "checkbox", "checkbox", "number"}
        )

        if m then
            if m[1] then ULTIMATE_MAPHACK() end
            if m[2] then MAPHACK_NO_ICON() end
            if m[3] then SYNC_SHADERS() end
            if m[4] then scanDrone() end
            local lvl = tonumber(m[5])
            if lvl and lvl >= 1 and lvl <= 10 then applyDrone(lvl) end
        end
    end
    gg.sleep(300)
end
