--------------------------------------------------
-- KAMETHOD CLOUD v1.8 [FIXED DRONE]
--------------------------------------------------

-- 1. REMOTE CONFIGURATION
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

-- 3. DYNAMIC EXPIRATION CHECK
local function checkExpiry()
    local response = gg.makeRequest(TIME_URL)
    if not response or not response.content then
        gg.alert("📡 [NETWORK ERROR]\nCould not verify subscription.")
        return true
    end
    local expire_timestamp = tonumber(response.content:match("%d+"))
    local current_time = os.time()
    if not expire_timestamp then return true end
    if current_time > expire_timestamp then
        gg.alert("⌛ [EXPIRED]\nPlease renew.")
        return true 
    end
    gg.toast("✅ KAMETHOD Active")
    return false
end

if checkExpiry() then return end

-- 4. TARGET CHECK
local info = gg.getTargetInfo()
if not info then
    gg.alert("❌ No Game Selected!")
    return 
end

--------------------------------------------------
-- GLOBAL VARIABLES (Removed 'local' to fix Cloud error)
--------------------------------------------------
scanned = false
V1 = {}; V2 = {}; V3 = {}; V4 = {}; V5 = {}

--------------------------------------------------
-- MAP FEATURES
--------------------------------------------------
function ULTIMATE_MAPHACK()
    gg.clearResults()
    gg.setRanges(gg.REGION_ANONYMOUS)
    gg.searchNumber("2.25F;9.18354962e-41F;1.40129846e-45F", gg.TYPE_FLOAT)
    gg.refineNumber("2.25", gg.TYPE_FLOAT)
    local results = gg.getResults(gg.getResultsCount())
    for i, v in ipairs(results) do v.value = 5 end
    gg.setValues(results)
    gg.toast("✅ Ultimate Maphack ON")
end

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
end

function SYNC_SHADERS()
    gg.clearResults()
    gg.setRanges(gg.REGION_ANONYMOUS)
    gg.searchNumber("11D;23D;7602241D;51D;121D", gg.TYPE_DWORD)
    local count = gg.getResultCount()
    if count > 0 then
        local results = gg.getResults(count)
        for i, v in ipairs(results) do
            if v.value == 11 then v.value = 12 end
        end
        gg.setValues(results)
        gg.toast("✨ Shaders Synced")
    end
end

--------------------------------------------------
-- DRONE VIEW LOGIC (STABLE VERSION)
--------------------------------------------------
function scanDrone()
    gg.clearResults()
    gg.setRanges(gg.REGION_ANONYMOUS)
    
    gg.toast("📡 Scanning Drone...")
    
    -- We save ONLY the addresses to keep memory clean
    gg.searchNumber("7.65999984741", gg.TYPE_FLOAT)
    V1 = gg.getResults(100)
    gg.clearResults()

    gg.searchNumber("-10.97999954224", gg.TYPE_FLOAT)
    V2 = gg.getResults(100)
    gg.clearResults()

    gg.searchNumber("7.61999988556", gg.TYPE_FLOAT)
    V3 = gg.getResults(100)
    gg.clearResults()

    gg.searchNumber("-7.65999984741", gg.TYPE_FLOAT)
    V4 = gg.getResults(100)
    gg.clearResults()

    gg.searchNumber("-7.61999988556", gg.TYPE_FLOAT)
    V5 = gg.getResults(100)
    gg.clearResults()

    if #V1 > 0 then
        scanned = true
        gg.toast("✅ Drone Scan OK! ("..#V1.." values)")
    else
        scanned = false
        gg.alert("❌ Drone values not found!\nMake sure you are in a match and the camera is at default height.")
    end
end

function applyDrone(level)
    if not scanned then
        gg.alert("⚠️ Error: You must 'Scan Drone' first!")
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

    -- THE FIX: We must load and THEN get the results before we can edit them
    gg.loadResults(V1)
    local r1 = gg.getResults(100) -- This tells GG "Prepare these for editing"
    gg.editAll(p[1], gg.TYPE_FLOAT)

    gg.loadResults(V2)
    local r2 = gg.getResults(100)
    gg.editAll(p[2], gg.TYPE_FLOAT)

    gg.loadResults(V3)
    local r3 = gg.getResults(100)
    gg.editAll(p[3], gg.TYPE_FLOAT)

    gg.loadResults(V4)
    local r4 = gg.getResults(100)
    gg.editAll(p[4], gg.TYPE_FLOAT)

    gg.loadResults(V5)
    local r5 = gg.getResults(100)
    gg.editAll(p[5], gg.TYPE_FLOAT)

    gg.toast("🚁 Drone Level " .. level .. " Applied")
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
                "🎨 Sync Shaders", 
                "📡 Scan Drone (MUST DO ONCE)", 
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