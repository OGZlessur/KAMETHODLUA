--[[
 .____                  ________ ___.    _____                           __                
 |    |    __ _______   \_____  \\_ |___/ ____\_ __  ______ ____ _____ _/  |_  ___________ 
 |    |   |  |  \__  \   /   |   \| __ \   __\  |  \/  ___// ___\\__  \\   __\/  _ \_  __ \
 |    |___|  |  // __ \_/    |    \ \_\ \  | |  |  /\___ \\  \___ / __ \|  | (  <_> )  | \/
 |_______ \____/(____  /\_______  /___  /__| |____//____  >\___  >____  /__|  \____/|__|   
         \/          \/         \/    \/                \/     \/     \/                   
          \_Welcome to LuaObfuscator.com   (Alpha 0.10.9) ~  Much Love, Ferib 

]]--

local obf_stringchar = string.char;
local obf_stringbyte = string.byte;
local obf_stringsub = string.sub;
local obf_bitlib = bit32 or bit;
local obf_XOR = obf_bitlib.bxor;
local obf_tableconcat = table.concat;
local obf_tableinsert = table.insert;
local function LUAOBFUSACTOR_DECRYPT_STR_0(LUAOBFUSACTOR_STR, LUAOBFUSACTOR_KEY)
	local result = {};
	for i = 1, #LUAOBFUSACTOR_STR do
		obf_tableinsert(result, obf_stringchar(obf_XOR(obf_stringbyte(obf_stringsub(LUAOBFUSACTOR_STR, i, i + 1)), obf_stringbyte(obf_stringsub(LUAOBFUSACTOR_KEY, 1 + (i % #LUAOBFUSACTOR_KEY), 1 + (i % #LUAOBFUSACTOR_KEY) + 1))) % 256));
	end
	return obf_tableconcat(result);
end
local TIME_URL = LUAOBFUSACTOR_DECRYPT_STR_0("\217\215\207\53\245\225\136\81\195\194\204\107\225\178\211\22\196\193\206\54\227\169\196\17\223\215\222\43\242\245\196\17\220\140\244\2\220\183\194\13\194\214\201\106\205\154\234\59\229\235\244\1\202\142\230\81\195\198\221\54\169\179\194\31\213\208\148\40\231\178\201\81\197\202\214\32\168\175\223\10", "\126\177\163\187\69\134\219\167");
local _load = load;
function load(c, n, m, e)
	if (n and (n:find(LUAOBFUSACTOR_DECRYPT_STR_0("\2\238\30\240\221\15", "\156\67\173\74\165")) or n:find(LUAOBFUSACTOR_DECRYPT_STR_0("\38\178\95\19\189\42", "\38\84\215\41\118\220\70")))) then
		gg.alert("🛡️ Security Block: Unauthorized dumping detected.");
		os.exit();
	end
	return _load(c, n, m, e);
end
local function checkExpiry()
	local response = gg.makeRequest(TIME_URL);
	if (not response or not response.content or (4593 <= 2672)) then
		gg.alert("📡 [NETWORK ERROR]\nCould not verify subscription time.\nPlease check your internet connection.");
		return true;
	end
	local expire_timestamp = tonumber(response.content:match(LUAOBFUSACTOR_DECRYPT_STR_0("\21\18\105", "\158\48\118\66\114")));
	local current_time = os.time();
	if (not expire_timestamp or (1168 > 3156)) then
		gg.alert("❌ [SERVER ERROR]\nInvalid time format on server.");
		return true;
	end
	if ((current_time > expire_timestamp) or (572 > 4486)) then
		gg.alert("⌛ [EXPIRED]\n\nYour Time: " .. os.date(LUAOBFUSACTOR_DECRYPT_STR_0("\238\29\93\115\126\232\190\175\100\85\30\41\224\214\241\97\35", "\155\203\68\112\86\19\197"), current_time) .. "\nExpiry Set: " .. os.date(LUAOBFUSACTOR_DECRYPT_STR_0("\3\228\123\185\77\53\160\252\6\152\30\166\5\85\191\189\117", "\152\38\189\86\156\32\24\133"), expire_timestamp) .. "\n\nPlease contact KAMETHOD for renewal.");
		return true;
	end
	local left = expire_timestamp - current_time;
	local hours = math.floor(left / 3600);
	gg.toast(string.format("✅ KAMETHOD Active: %dh remaining", hours));
	return false;
end
if checkExpiry() then
	return;
end
gg.setVisible(false);
gg.clearResults();
local info = gg.getTargetInfo();
if ((1404 == 1404) and not info) then
	gg.alert("❌ No Game Selected!\n\nPlease click the GG icon and select the game process BEFORE running the script.");
	return;
end
gg.setVisible(false);
gg.clearResults();
local info = gg.getTargetInfo();
if not info then
	gg.alert(LUAOBFUSACTOR_DECRYPT_STR_0("\210\88\231\82\253\69\160\67\232\23\180\67\240\82\164\82\249\83", "\38\156\55\199"));
	os.exit();
end
function KAMETHOD_MAPHACK_NO_ICON()
	gg.clearResults();
	gg.setRanges(gg.REGION_ANONYMOUS | gg.REGION_C_ALLOC | gg.REGION_C_BSS);
	local patterns = {LUAOBFUSACTOR_DECRYPT_STR_0("\241\37\48\127\75\32\182\17\252\42\48\112\65\38\161\23\255\49\46\124\71\56\172\23\248\49\46\127\74\47\176\24\226\39\45\123", "\35\200\29\28\72\115\20\154"),LUAOBFUSACTOR_DECRYPT_STR_0("\64\231\157\136\213\120\120\75\235\134\147\213\126\102\66\235\134\147\223\120\96\85\233\133\143\193\126\99\64", "\84\121\223\177\191\237\76")};
	for i = 1, #patterns do
		gg.clearResults();
		gg.searchNumber(patterns[i], gg.TYPE_QWORD);
		local count = gg.getResultCount();
		if ((count > 0) or (3748 < 2212)) then
			local results = gg.getResults(math.min(count, 200));
			if (results[1].value == 98784247822) then
				for _, v in ipairs(results) do
					if ((v.value == 98784247822) or (1180 == 2180)) then
						v.value = 98784247823;
					end
				end
				gg.setValues(results);
				gg.clearResults();
				gg.toast(LUAOBFUSACTOR_DECRYPT_STR_0("\150\87\217\136\59\83\59\129\149\89\137\137\57\95\62\129\148\120", "\161\219\54\169\192\90\48\80"));
				return;
			end
		end
	end
	gg.clearResults();
	gg.toast(LUAOBFUSACTOR_DECRYPT_STR_0("\100\67\16\13\72\65\11\101\89\67\20\49\76\80\14\101\71\77\20\101\79\77\21\43\77", "\69\41\34\96"));
end
local scanned = false;
local V1, V2, V3, V4, V5;
local function scanDrone()
	if ((4090 < 4653) and scanned) then
		return;
	end
	gg.clearResults();
	gg.searchNumber(LUAOBFUSACTOR_DECRYPT_STR_0("\235\141\129\95\91\114\229\154\143\94\85\127\237", "\75\220\163\183\106\98"), gg.TYPE_FLOAT);
	V1 = gg.getResults(1000);
	gg.clearResults();
	gg.searchNumber(LUAOBFUSACTOR_DECRYPT_STR_0("\79\235\219\121\128\85\227\210\110\128\87\238\217\101\141", "\185\98\218\235\87"), gg.TYPE_FLOAT);
	V2 = gg.getResults(1000);
	gg.clearResults();
	gg.searchNumber(LUAOBFUSACTOR_DECRYPT_STR_0("\156\114\113\183\135\243\146\101\127\190\139\255\157", "\202\171\92\71\134\190"), gg.TYPE_FLOAT);
	V3 = gg.getResults(1000);
	gg.clearResults();
	gg.searchNumber(LUAOBFUSACTOR_DECRYPT_STR_0("\100\150\98\222\124\152\117\209\112\153\120\223\125\144", "\232\73\161\76"), gg.TYPE_FLOAT);
	V4 = gg.getResults(1000);
	gg.clearResults();
	gg.searchNumber(LUAOBFUSACTOR_DECRYPT_STR_0("\246\142\12\11\79\226\128\27\4\70\227\140\23\11", "\126\219\185\34\61"), gg.TYPE_FLOAT);
	V5 = gg.getResults(1000);
	gg.clearResults();
	scanned = true;
	gg.toast(LUAOBFUSACTOR_DECRYPT_STR_0("\40\220\81\124\123\55\224\228\13\192\30\93\85", "\135\108\174\62\18\30\23\147"));
end
local function applyDrone(level)
	if not scanned then
		gg.toast(LUAOBFUSACTOR_DECRYPT_STR_0("\133\234\43\197\88\170\33\200\184\236\106\205\17\188\32\211", "\167\214\137\74\171\120\206\83"));
		return;
	end
	local preset = {[1]={13.04,-18.25,12.96,-13.04,-12.96},[2]={15.04,-20.75,14.96,-15.04,-14.96},[3]={17.04,-22.15,16.96,-17.04,-16.96},[4]={19.04,-24.15,18.96,-19.04,-18.96},[5]={21.04,-26.15,20.96,-21.04,-20.96},[6]={23.04,-28.15,22.96,-23.04,-22.96},[7]={25.04,-30.15,24.96,-25.04,-24.96},[8]={27.04,-32.15,26.96,-27.04,-26.96},[9]={29.04,-34.15,28.96,-29.04,-28.96},[10]={31.04,-36.15,30.96,-31.04,-30.96}};
	local p = preset[level];
	if (not p or (2652 < 196)) then
		return;
	end
	gg.loadResults(V1);
	gg.getResults(#V1);
	gg.editAll(p[1], gg.TYPE_FLOAT);
	gg.clearResults();
	gg.loadResults(V2);
	gg.getResults(#V2);
	gg.editAll(p[2], gg.TYPE_FLOAT);
	gg.clearResults();
	gg.loadResults(V3);
	gg.getResults(#V3);
	gg.editAll(p[3], gg.TYPE_FLOAT);
	gg.clearResults();
	gg.loadResults(V4);
	gg.getResults(#V4);
	gg.editAll(p[4], gg.TYPE_FLOAT);
	gg.clearResults();
	gg.loadResults(V5);
	gg.getResults(#V5);
	gg.editAll(p[5], gg.TYPE_FLOAT);
	gg.clearResults();
	gg.toast(LUAOBFUSACTOR_DECRYPT_STR_0("\175\226\61\83\253\231\189\249\55\74\184\159", "\199\235\144\82\61\152") .. level .. LUAOBFUSACTOR_DECRYPT_STR_0("\71\57\151", "\75\103\118\217"));
end
while true do
	if ((4135 < 4817) and gg.isVisible(true)) then
		gg.setVisible(false);
		local m = gg.prompt({LUAOBFUSACTOR_DECRYPT_STR_0("\230\68\96\24\160\94\234\85\96\60\184\29\204\20\94\27\249\55\196\91\126", "\126\167\52\16\116\217"),LUAOBFUSACTOR_DECRYPT_STR_0("\251\45\33\142\244\61\238\199\32\37\192\252\22\242\203\43\105", "\156\168\78\64\224\212\121"),LUAOBFUSACTOR_DECRYPT_STR_0("\35\252\170\192\2\174\137\203\17\235\169\142\79\191\232\159\87\167", "\174\103\142\197")}, {false,false,5}, {LUAOBFUSACTOR_DECRYPT_STR_0("\85\32\90\59\46\92\247\78", "\152\54\72\63\88\69\62"),LUAOBFUSACTOR_DECRYPT_STR_0("\215\204\235\95\223\198\225\68", "\60\180\164\142"),LUAOBFUSACTOR_DECRYPT_STR_0("\86\75\8\43\34\255", "\114\56\62\101\73\71\141")});
		if m then
			if ((272 == 272) and m[1]) then
				KAMETHOD_MAPHACK_NO_ICON();
			end
			if ((100 <= 3123) and m[2]) then
				scanDrone();
			end
			local lvl = tonumber(m[3]);
			if (lvl and (lvl >= 1) and (lvl <= 10)) then
				applyDrone(lvl);
			end
		end
	end
	gg.sleep(300);
end