--------------------------------------------------
-- KAMETHOD CLOUD v2.7
--------------------------------------------------
gg.setVisible(false)

local MY_BITMASK = gg.REGION_ANONYMOUS | gg.REGION_C_ALLOC | gg.REGION_C_BSS 
local drone_scanned = false
local map_scanned = false
local drone_lvl = 5

-- Tables to store the memory addresses found during scanning
local V1, V2, V3, V4, V5 = {}, {}, {}, {}, {} -- Drone addresses
local MAP_REVEAL_ADDR = {} -- Maphack addresses

--------------------------------------------------
-- 🛠️ SCANNING LOGIC
--------------------------------------------------

-- 1. Scan for Maphack Reveal
function SCAN_MAPHACK()
    gg.clearResults()
    gg.setRanges(MY_BITMASK)
    gg.toast("🔍 Scanning Map Values...")
    gg.searchNumber("2.25F;9.18354962e-41F;1.40129846e-45F", gg.TYPE_FLOAT)
    gg.refineNumber("2.25", gg.TYPE_FLOAT)
    
    local count = gg.getResultCount()
    if count > 0 then
        MAP_REVEAL_ADDR = gg.getResults(count)
        map_scanned = true
        gg.toast("✅ Map Data Found: " .. count)
    else
        map_scanned = false
        gg.alert("❌ Map values not found. Are you in a match?")
    end
end

-- 2. Scan for Drone View
function SCAN_DRONE()
    gg.clearResults()
    gg.setRanges(MY_BITMASK)
    gg.toast("📡 Searching Drone Pointers...")
    
    local function get(val)
        gg.searchNumber(val, gg.TYPE_FLOAT)
        local res = gg.getResults(100)
        gg.clearResults()
        return res
    end

    V1 = get("7.65999984741"); V2 = get("-10.97999954224")
    V3 = get("7.61999988556"); V4 = get("-7.65999984741")
    V5 = get("-7.61999988556")

    if #V1 > 0 then
        drone_scanned = true
        gg.toast("✅ Drone Data Cached")
    else
        drone_scanned = false
        gg.alert("❌ Drone not found!")
    end
end

--------------------------------------------------
-- 🚀 APPLY LOGIC (NO FREEZE)
--------------------------------------------------

function APPLY_MAPHACK()
    if not map_scanned then gg.alert("⚠️ Scan Maphack First!") return end
    for i, v in ipairs(MAP_REVEAL_ADDR) do
        v.value = 5
    end
    gg.setValues(MAP_REVEAL_ADDR)
    gg.toast("🔥 Maphack Applied")
end

function APPLY_DRONE(lvl)
    if not drone_scanned then gg.alert("⚠️ Scan Drone First!") return end
    local preset = {
        [1]={13.04,-18.25,12.96,-13.04,-12.96}, [2]={15.04,-20.75,14.96,-15.04,-14.96},
        [3]={17.04,-22.15,16.96,-17.04,-16.96}, [4]={19.04,-24.15,18.96,-19.04,-18.96},
        [5]={21.04,-26.15,20.96,-21.04,-20.96}, [6]={23.04,-28.15,22.96,-23.04,-22.96},
        [7]={25.04,-30.15,24.96,-25.04,-24.96}, [8]={27.04,-32.15,26.96,-27.04,-26.96},
        [9]={29.04,-34.15,28.96,-29.04,-28.96}, [10]={31.04,-36.15,30.96,-31.04,-30.96}
    }
    local p = preset[lvl]
    local function edit(t, val)
        if #t > 0 then
            for i, v in ipairs(t) do v.value = val end
            gg.setValues(t)
        end
    end
    edit(V1, p[1]); edit(V2, p[2]); edit(V3, p[3]); edit(V4, p[4]); edit(V5, p[5])
    gg.toast("🚁 Drone X" .. lvl .. " Applied")
end

-- Maphack No Icon (Doesn't need separate scan because it's a direct pattern search/replace)
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
        gg.toast("🚫 No Icon Applied")
    else
        gg.toast("❌ No Icon Not Found")
    end
end

--------------------------------------------------
-- 📱 USER MENU
--------------------------------------------------
while true do
    if gg.isVisible(true) then
        gg.setVisible(false)
        
        local mStatus = map_scanned and "🟢" or "🔴"
        local dStatus = drone_scanned and "🟢" or "🔴"
        
        local m = gg.choice({
            "🛰️ [1] SCAN MAPHACK " .. mStatus,
            "👁️ [2] APPLY MAPHACK",
            "📡 [3] SCAN DRONE " .. dStatus,
            "🚁 [4] APPLY DRONE (Level: " .. drone_lvl .. ")",
            "🚫 [5] NO ICON MAPHACK",
            "⚙️ [6] SET DRONE LEVEL",
            "🧹 [7] RESET ALL / LOBBY",
            "❌ EXIT"
        }, nil, "🛡️ KAMETHOD VIP v2.7\nSelect Scans first, then Apply.")

        if m == 1 then SCAN_MAPHACK() end
        if m == 2 then APPLY_MAPHACK() end
        if m == 3 then SCAN_DRONE() end
        if m == 4 then APPLY_DRONE(drone_lvl) end
        if m == 5 then APPLY_NO_ICON() end
        if m == 6 then 
            local p = gg.prompt({"Set Level (1-10)"}, {drone_lvl}, {"number"})
            if p then drone_lvl = tonumber(p[1]) end
        end
        if m == 7 then 
            map_scanned = false; drone_scanned = false
            MAP_REVEAL_ADDR = {}; V1, V2, V3, V4, V5 = {}, {}, {}, {}, {}
            gg.clearResults(); gg.toast("🧹 Memory Purged")
        end
        if m == 8 then os.exit() end
    end
    gg.sleep(200)
end