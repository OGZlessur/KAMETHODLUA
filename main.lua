--------------------------------------------------
-- KAMETHOD CLOUD v3.0 [ULTIMATE HEX EDITION]
--------------------------------------------------
gg.setVisible(false)

-- Safer Bitmask for Parallel Space (Anonymous + C_Alloc)
local MY_BITMASK = gg.REGION_ANONYMOUS | gg.REGION_C_ALLOC
local drone_scanned = false
local map_scanned = false
local drone_lvl = 5

-- Data Storage
local V1, V2, V3, V4, V5 = {}, {}, {}, {}, {}
local MAP_HEX_ADDR = {}

-- 

--------------------------------------------------
-- 🛠️ SMART HEX & SCAN LOGIC
--------------------------------------------------

-- 1. SMART HEX MAPHACK (Targets Client Rendering)
function SCAN_MAPHACK()
    gg.clearResults()
    gg.setRanges(MY_BITMASK)
    gg.toast("🔍 Scanning Hex Signature...")
    
    -- Hex for 2.25F; 0.01F; 1.0F within 12 bytes
    gg.searchNumber("40100000h;3C23D70Ah;3F800000h::12", gg.TYPE_DWORD)
    gg.refineNumber("40100000h", gg.TYPE_DWORD)
    
    local count = gg.getResultCount()
    if count > 0 and count < 50 then
        MAP_HEX_ADDR = gg.getResults(count)
        map_scanned = true
        gg.toast("✅ Hex Signature Found: " .. count)
    else
        map_scanned = false
        gg.alert("❌ Signature not found. Are you in a match?")
    end
end

-- 2. APPLY MAPHACK (Force Reveal)
function APPLY_MAPHACK()
    if not map_scanned then gg.alert("⚠️ Scan Maphack First!") return end
    for i, v in ipairs(MAP_HEX_ADDR) do
        -- 40A00000h is Hex for 5.0 (Reveal Distance)
        v.value = "40A00000h"
    end
    gg.setValues(MAP_HEX_ADDR)
    gg.toast("🔥 Client-Side Reveal ACTIVE")
end

-- 3. SCAN DRONE
function SCAN_DRONE()
    gg.clearResults()
    gg.setRanges(gg.REGION_ANONYMOUS)
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

-- 4. APPLY DRONE
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
    gg.toast("🚁 Drone View Level " .. lvl)
end

-- 5. NO ICON PATTERN
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
        gg.toast("🚫 Enemy Icons Removed")
    else
        gg.toast("❌ No Icon Pattern not found.")
    end
end

-- 

--------------------------------------------------
-- 📱 USER MENU
--------------------------------------------------
while true do
    if gg.isVisible(true) then
        gg.setVisible(false)
        
        local mStatus = map_scanned and "🟢" or "🔴"
        local dStatus = drone_scanned and "🟢" or "🔴"
        
        local m = gg.choice({
            "🛰️ [1] SCAN MAPHACK HEX " .. mStatus,
            "👁️ [2] APPLY ULTIMATE REVEAL",
            "📡 [3] SCAN DRONE DATA " .. dStatus,
            "🚁 [4] APPLY DRONE (Lvl: " .. drone_lvl .. ")",
            "🚫 [5] REMOVE ENEMY ICONS",
            "⚙️ [6] SET DRONE VALUE (1-10)",
            "🧹 [7] RESET FOR NEXT MATCH",
            "❌ EXIT"
        }, nil, "🛡️ KAMETHOD VIP v3.0\nStatus: "..mStatus.." Map | "..dStatus.." Drone")

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
            MAP_HEX_ADDR = {}; V1, V2, V3, V4, V5 = {}, {}, {}, {}, {}
            gg.clearResults(); gg.toast("🧹 Ready for New Match")
        end
        if m == 8 then os.exit() end
    end
    gg.sleep(200)
end
