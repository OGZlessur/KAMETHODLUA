--------------------------------------------------
-- DRONE VIEW + MAPHACK NO ICON (FIXED)
--------------------------------------------------

-- 1. EXPIRATION CHECK FIRST
local function expired()
    local e = {2026, 4, 11}
    local n = os.date("*t")
    return (n.year > e[1]) or (n.year == e[1] and n.month > e[2])
        or (n.year == e[1] and n.month == e[2] and n.day > e[3])
end

if expired() then
    gg.alert("Script expired")
    os.exit()
end

gg.setVisible(false)
gg.clearResults()

--------------------------------------------------
-- TARGET CHECK
--------------------------------------------------
local info = gg.getTargetInfo()
if not info then
    gg.alert("No target selected")
    os.exit()
end

local MY_BITMASK = gg.REGION_ANONYMOUS | gg.REGION_C_ALLOC

--------------------------------------------------
-- MAP HACK NO ICON (UNCHANGED)
--------------------------------------------------

function APPLY_NO_ICON()
    gg.clearResults()
    gg.setRanges(MY_BITMASK)
    gg.searchNumber("98,784,247,822;47,244,640,279", gg.TYPE_QWORD)
    local results = gg.getResults(gg.getResultCount())
    if #results > 0 then
        for i, v in ipairs(results) do
            if v.value == 98784247822 then v.value = 98784247823 end
        end
        gg.setValues(results)
        gg.toast("🚫 MapHack No Icon Activated")
    else
        gg.toast("❌ No Icon Pattern not found.")
    end
    gg.clearResults()
end

function ULTIMATE_MAPHACK()
    gg.clearResults()
    gg.setRanges(-2080835)
    
    -- 1. Your pattern search
    gg.searchNumber("2.25F;9.18354962e-41F;1.40129846e-45F", gg.TYPE_FLOAT)
    
    -- 2. Your refine logic
    gg.refineNumber("2.25", gg.TYPE_FLOAT)
    
    local count = gg.getResultCount()
    
    -- 3. Safety Check: Only patch if the count is reasonable (e.g., less than 50)
    if count > 0 and count < 10 then
        local results = gg.getResults(count)
        for i, v in ipairs(results) do 
            v.value = 5 
        end
        gg.setValues(results)
        gg.toast("✅ Ultimate Maphack ON (" .. count .. " values)")
    elseif count >= 20 then
        gg.alert("⚠️ Warning: Found " .. count .. " values. This is too many and might crash the game. Try restarting the match.")
    else
        gg.toast("🚫 Values not found")
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
-- MENU
--------------------------------------------------
while true do
    if gg.isVisible(true) then
        gg.setVisible(false)

        local m = gg.prompt(
            {
                "👁️ [MAP] Map Hack Icon",
                "🚫 [ICON] Map Hack No Icon",
                "📡 [DRONE] Initial Data Scan",
                "🚁 [DRONE] View Height (1-10)"
            },
            {false, false, false, 1},
            {"checkbox", "checkbox", "checkbox", "number"}
        )

        if m then
            if m[1] then ULTIMATE_MAPHACK() end
            if m[2] then APPLY_NO_ICON() end
            if m[3] then scanDrone() end
            
            local lvl = tonumber(m[4])
            if lvl and lvl >= 1 and lvl <= 10 then
                applyDrone(lvl)
            else
                gg.toast("⚠️ Use Drone Level 1-10 only")
            end
        end
    end
    gg.sleep(300)
end
