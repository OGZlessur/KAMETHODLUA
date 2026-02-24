--------------------------------------------------
-- KAMETHOD CLOUD v3.2 [MLBB ULTIMATE EDITION]
--------------------------------------------------
gg.setVisible(false)

-- Memory Configuration
local MY_BITMASK = gg.REGION_ANONYMOUS | gg.REGION_C_ALLOC
local drone_lvl = 5
local drone_scanned = false

-- Data Tables
local V1, V2, V3, V4, V5 = {}, {}, {}, {}, {}

--------------------------------------------------
-- 🛠️ 1. ICON MAPHACK (QWORD SIGNATURES)
--------------------------------------------------
function APPLY_ICON_HACK()
    gg.setRanges(gg.REGION_ANONYMOUS)
    gg.toast("🔍 Syncing Icon Signatures...")

    -- ICON V1
    gg.clearResults()
    gg.searchNumber("4616189618054758400Q;72057594037927936Q", gg.TYPE_QWORD)
    if gg.getResultCount() > 0 then
        local r = gg.getResults(100)
        for i, v in ipairs(r) do
            if v.value == 4616189618054758400 then v.value = 4616189618054758401 end
        end
        gg.setValues(r)
    end

    -- ICON V2
    gg.clearResults()
    gg.searchNumber("4619567317775286272Q;1103806595072Q;1103806595072Q;282574488338432Q", gg.TYPE_QWORD)
    if gg.getResultCount() > 0 then
        local r = gg.getResults(100)
        for i, v in ipairs(r) do
            if v.value == 4619567317775286272 then v.value = 4619567317775286273 end
        end
        gg.setValues(r)
    end

    -- ICON V3
    gg.clearResults()
    gg.searchNumber("4621256167635550208Q;1099511627776Q", gg.TYPE_QWORD)
    if gg.getResultCount() > 0 then
        local r = gg.getResults(100)
        for i, v in ipairs(r) do
            if v.value == 4621256167635550208 then v.value = 4621256167635550209 end
        end
        gg.setValues(r)
    end
    gg.toast("✅ Icons Synced")
end

--------------------------------------------------
-- 🛠️ 2. ULTIMATE MAPHACK (HEX RENDERING)
--------------------------------------------------
function APPLY_ULTIMATE_HEX()
    gg.clearResults()
    gg.setRanges(MY_BITMASK)
    gg.toast("🔍 Scanning Rendering Hex...")
    
    -- Search for Client-Side Visual Signature
    gg.searchNumber("40100000h;3C23D70Ah;3F800000h::12", gg.TYPE_DWORD)
    gg.refineNumber("40100000h", gg.TYPE_DWORD)
    
    local count = gg.getResultCount()
    if count > 0 then
        local results = gg.getResults(count)
        for i, v in ipairs(results) do
            v.value = "40A00000h" -- Set to 5.0F
        end
        gg.setValues(results)
        gg.toast("✅ Ultimate Reveal ON")
    else
        gg.toast("❌ Hex Reveal Not Found")
    end
end

--------------------------------------------------
-- 🛠️ 3. DRONE VIEW LOGIC
--------------------------------------------------
function SCAN_DRONE()
    gg.setRanges(gg.REGION_ANONYMOUS)
    local function get(val)
        gg.clearResults()
        gg.searchNumber(val, gg.TYPE_FLOAT)
        local res = gg.getResults(100)
        return res
    end
    V1=get("7.65999984741"); V2=get("-10.97999954224"); V3=get("7.61999988556")
    V4=get("-7.65999984741"); V5=get("-7.61999988556")
    if #V1 > 0 then drone_scanned = true; gg.toast("✅ Drone Ready") else gg.toast("❌ Drone Not Found") end
end

function APPLY_DRONE(lvl)
    if not drone_scanned then return end
    local p = {
        [1]={13.04,-18.25,12.96,-13.04,-12.96}, [2]={15.04,-20.75,14.96,-15.04,-14.96},
        [3]={17.04,-22.15,16.96,-17.04,-16.96}, [4]={19.04,-24.15,18.96,-19.04,-18.96},
        [5]={21.04,-26.15,20.96,-21.04,-20.96}, [6]={23.04,-28.15,22.96,-23.04,-22.96},
        [7]={25.04,-30.15,24.96,-25.04,-24.96}, [8]={27.04,-32.15,26.96,-27.04,-26.96},
        [9]={29.04,-34.15,28.96,-29.04,-28.96}, [10]={31.04,-36.15,30.96,-31.04,-30.96}
    }
    local v = p[lvl]
    local function ed(t, val) if #t > 0 then for _, i in ipairs(t) do i.value = val end gg.setValues(t) end end
    ed(V1, v[1]); ed(V2, v[2]); ed(V3, v[3]); ed(V4, v[4]); ed(V5, v[5])
    gg.toast("🚁 Drone Level " .. lvl)
end

--------------------------------------------------
-- 📱 MASTER MENU
--------------------------------------------------
while true do
    if gg.isVisible(true) then
        gg.setVisible(false)
        
        local dStat = drone_scanned and "🟢" or "🔴"
        
        local m = gg.choice({
            "⚡ [ AUTO SYNC ALL ]",
            "🖼️ [1] SYNC ICON SIGNATURES",
            "🛰️ [2] APPLY ULTIMATE MAPHACK",
            "📡 [3] SCAN DRONE DATA " .. dStat,
            "🚁 [4] APPLY DRONE (Level: " .. drone_lvl .. ")",
            "⚙️ [5] CHANGE DRONE LEVEL",
            "🧹 [RESET FOR NEXT MATCH]",
            "❌ EXIT"
        }, nil, "🛡️ KAMETHOD MLBB VIP v3.2")

        if m == 1 then 
            APPLY_ICON_HACK()
            APPLY_ULTIMATE_HEX()
            SCAN_DRONE()
            APPLY_DRONE(drone_lvl)
        end
        if m == 2 then APPLY_ICON_HACK() end
        if m == 3 then APPLY_ULTIMATE_HEX() end
        if m == 4 then SCAN_DRONE() end
        if m == 5 then APPLY_DRONE(drone_lvl) end
        if m == 6 then 
            local p = gg.prompt({"Drone Level (1-10)"}, {drone_lvl}, {"number"})
            if p then drone_lvl = tonumber(p[1]) end
        end
        if m == 7 then 
            drone_scanned = false
            V1, V2, V3, V4, V5 = {}, {}, {}, {}, {}
            gg.clearResults(); gg.toast("🧹 Memory Purged")
        end
        if m == 8 then os.exit() end
    end
    gg.sleep(200)
end
