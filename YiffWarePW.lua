local function SetIntStat(hash, prefix, value, save)
    save = save or true
    local hash0, hash1 = hash, hash
    if prefix then
        hash0 = 'MP0_' .. hash
        hash1 = 'MP1_' .. hash
        hash1 = gameplay.get_hash_key(hash1)
    end
    hash0 = gameplay.get_hash_key(hash0)
    local value0, e = stats.stat_get_int(hash0, -1)
    if value0 ~= value then
        stats.stat_set_int(hash0, value, save)
    end
    if prefix then
        local value1, e = stats.stat_get_int(hash1, -1)
        if value1 ~= value then
            stats.stat_set_int(hash1, value, save)
        end
    end
end

local parentId = menu.add_feature("生活质量变化", "parent", 0).id


menu.add_feature("每 30 秒补充一次零食", "toggle", parentId, function(e)
    local items = {
        {'NO_BOUGHT_YUM_SNACKS', 30},
        {'NO_BOUGHT_HEALTH_SNACKS', 15},
        {'NO_BOUGHT_EPIC_SNACKS', 5},
        {'NUMBER_OF_ORANGE_BOUGHT', 10},
        {'NUMBER_OF_BOURGE_BOUGHT', 10},
        {'NUMBER_OF_CHAMP_BOUGHT', 5},
        {'CIGARETTES_BOUGHT', 20},
    }

    while e.on do 
        for i = 1, #items do
            SetIntStat(items[i][1], true, items[i][2])
        end
        system.wait(30000)
    end
end)

menu.add_feature("每 30 秒补充一次护甲", "toggle", parentId, function(e)
    local items = {
        {'MP_CHAR_ARMOUR_1_COUNT', 10},
        {'MP_CHAR_ARMOUR_2_COUNT', 10},
        {'MP_CHAR_ARMOUR_3_COUNT', 10},
        {'MP_CHAR_ARMOUR_4_COUNT', 10},
        {'MP_CHAR_ARMOUR_5_COUNT', 10}
    }

    while e.on do
        for i = 1, #items do
            SetIntStat(items[i][1], true, items[i][2])
        end
        system.wait(30000)
    end
end)

menu.add_feature("无限降落伞", "toggle", parentId, function(f)
    while f.on do
        system.yield(250)
        if not weapon.has_ped_got_weapon(player.get_player_ped(player.player_id()), gameplay.get_hash_key("gadget_parachute")) then
            weapon.give_delayed_weapon_to_ped(player.get_player_ped(player.player_id()), gameplay.get_hash_key("gadget_parachute"), 0, false)
        end
    end
end)

menu.add_feature("移除 CEO 板条箱冷却时间", "toggle", parentId, function(e)
    if e.on then
        script.set_global_i(262145+15361, 0)
        script.set_global_i(262145+15362, 0)
    end
    if not e.on then
        script.set_global_i(262145+15361, 300000)   --Buy
        script.set_global_i(262145+15362, 1800000)  --Sell
    end
end)

menu.add_feature("移除 CEO 车辆销售冷却时间", "toggle", parentId, function(e)
    if e.on then
        script.set_global_i(262145+19477, 0)
        script.set_global_i(262145+19478, 0)
        script.set_global_i(262145+19479, 0)
        script.set_global_i(262145+19480, 0)
    end
    if not e.on then
        script.set_global_i(262145+19477, 1200000)  --1 Vehicle
        script.set_global_i(262145+19478, 1680000)  --2 Vehicles
        script.set_global_i(262145+19479, 2340000)  --3 Vehicles
        script.set_global_i(262145+19480, 2880000)  --4 Vehicles
    end
end)

menu.add_feature("删除空运货物冷却时间", "toggle", parentId, function(e)
    if e.on then
        script.set_global_i(262145+22522, 0)
        script.set_global_i(262145+22523, 0)
        script.set_global_i(262145+22524, 0)
        script.set_global_i(262145+22525, 0)
        script.set_global_i(262145+22561, 0)
    end
    if not e.on then
        script.set_global_i(262145+22522, 120000)  --Tobacco, Counterfeit Goods
        script.set_global_i(262145+22523, 180000)  --Animal Materials, Art, Jewelry
        script.set_global_i(262145+22524, 240000)  --Narcotics, Chemicals, Medical Supplies
        script.set_global_i(262145+22525, 60000)   --Additional Time per Player
        script.set_global_i(262145+22561, 180000)  --Sale
    end
end)


local key_words={
    "QQ",
    "VX",
    "V.X",
    "Q.Q",
    "vx",
    "qq",
    "q.q",
    "v.x",
    "shua",
    "Shua",
    "SHUA",
    "SHUa",
    "sHUA",
    "微信",
    "威信",
    "萌新一起玩",
    "信用保障",
    "安全稳定",
    "解锁",
    "解所",
    "Q群",
    "q群",
    "全网最低",
    "全往最低",
    "店铺",
    "激情大片",
    "澳门赌场",
    "抠逼自慰",
    "加群",
    "刷钱",
    "淘宝",
    "十年店铺",
    "支持花呗",
    "地堡刷金",
    "有妹子",
    "扣群",
    "扣扣",
    "Î¢ÐÅ",
    "ÍþÐÅ",
    "ÃÈÐÂÒ»ÆðÍæ",
    "ÐÅÓÃ±£ÕÏ",
    "°²È«ÎÈ¶¨",
    "½âËø",
    "½âËù",
    "QÈº",
    "qÈº",
    "È«Íø×îµÍ",
    "È«Íù×îµÍ",
    "µêÆÌ",
    "¼¤Çé´óÆ¬",
    "°ÄÃÅ¶Ä³¡",
    "¿Ù±Æ×ÔÎ¿",
    "¼ÓÈº",
    "Ë¢Ç®",
    "ÌÔ±¦",
    "Ê®ÄêµêÆÌ",
    "Ö§³Ö»¨ßÂ",
    "µØ±¤Ë¢½ð",
    "ÓÐÃÃ×Ó",
    "¿ÛÈº",
    "¿Û¿Û",
    "Е�®Д©ӯ",
    "Е�ғД©ӯ",
    "ХҚҲФ–°Д�қХӢ·ГҶ�",
    "Д©ӯГ”�Д©�И��",
    "Е®‰Е…�Г�ЁЕ®�",
    "Х§ёИ”ғ",
    "Х§ёФ‰қ",
    "QГ�¤",
    "qГ�¤",
    "Е…�Г�‘Ф�қД�Ҷ",
    "Е…�Е�қФ�қД�Ҷ",
    "Е�—И“�",
    "Ф©қФҒ…Е¤§Г‰‡",
    "Ф�ЁИ—�ХӢҲЕ��",
    "Фҳ�Иқ�Х‡�Ф…°",
    "Еҳ�Г�¤",
    "Е�·И’±",
    "Ф·�Е®�",
    "ЕҷғЕ№�Е�—И“�",
    "Ф”�ФҲғХҳ±Е‘—",
    "Е�°Е�ӯЕ�·И‡‘",
    "Ф�‰Е¦№Е­Қ",
    "Ф‰ёГ�¤",
    "Ф‰ёФ‰ё",
    "寰�淇�",
    "濞佷俊",
    "钀屾柊涓€璧风帺",
    "淇＄敤淇濋殰",
    "瀹夊叏绋冲畾",
    "瑙ｉ攣",
    "瑙ｆ墍",
    "Q缇�",
    "q缇�",
    "鍏ㄧ綉鏈€浣�",
    "鍏ㄥ線鏈€浣�",
    "搴楅摵",
    "婵€鎯呭ぇ鐗�",
    "婢抽棬璧屽満",
    "鎶犻€艰嚜鎱�",
    "鍔犵兢",
    "鍒烽挶",
    "娣樺疂",
    "鍗佸勾搴楅摵",
    "鏀�鎸佽姳鍛�",
    "鍦板牎鍒烽噾",
    "鏈夊�瑰瓙",
    "鎵ｇ兢",
    "鎵ｆ墸",
    "ๅพฎไฟก",
    "ๅจ�ไฟก",
   "��ๆ–ฐไธ€่ตท็�ฉ",
   "ไฟก็”จไฟ�้��",
   "ๅฎ�ๅ…จ็จณๅฎ�",
   "งฃ้”�",
   "งฃๆ�€",
   "Q็พค",
   "q็พค",
    "ๅ…จ็ฝ‘ๆ�€ไฝ�",
    "ๅ…จๅพ€ๆ�€ไฝ�",
    "ๅบ—้“บ",
    "ๆฟ€ๆ�…ๅคง็��",
    "ๆพณ้—จ่ต�ๅ�บ",
    "ๆ� ้€ผ่�ชๆ…ฐ",
    "ๅ� ็พค",
    "ๅ�ท้’ฑ",
    "ๆท�ๅฎ�",
    "ๅ��ๅนดๅบ—้“บ",
    "ๆ”ฏๆ��่�ฑๅ‘—",
    "ๅ�ฐๅ กๅ�ท้�‘",
    "ๆ��ๅฆนๅญ�",
    "ๆ�ฃ็พค",
    "ๆ�ฃๆ�ฃ",
    ".com",
    ".cn",
    ".cc",
    ".xyz",
    ".top",
    ".us",
    ".ru",
    ".net",
    ".ad",
    ".ae",
    ".wang",
    ".pub",
    ".xin",
    ".cc",
    ".tv",
    ".uk",
    ".org",
    ".jp",
    ".edu",
    ".gov",
    ".mil",
    ".online",
    "ltd",
    ".shop",
    ".beer",
    ".art",
    ".luxe",
    ".co",
    ".vip",
    ".club",
    ".fun",
    ".tech",
    ".store",
    ".red",
    ".pro",
    ".kim",
    ".ink",
    ".group",
    ".work",
    ".ren",
    ".biz",
    ".mobi",
    ".site",
    ".asia",
    ".law",
    ".me",
    ".COM",
    ".CN",
    ".CC",
    ".XYZ",
    ".TOP",
    ".US",
    ".RU",
    ".NET",
    ".AD",
    ".AE",
    ".WANG",
    ".PUB",
    ".XIN",
    ".CC",
    ".TV",
    ".UK",
    ".ORG",
    ".JP",
    ".EDU",
    ".GOV",
    ".MIL",
    ".ONLINE",
    ".LTD",
    ".SHOP",
    ".BEER",
    ".ART",
    ".LUXE",
    ".CO",
    ".VIP",
    ".CLUB",
    ".FUN",
    ".TECH",
    ".STORE",
    ".RED",
    ".PRO",
    ".KIM",
    ".INK",
    ".GROUP",
    ".WORK",
    ".REN",
    ".BIZ",
    ".MOBI",
    ".SITE",
    ".ASIA",
    ".LAW",
    ".ME",
    ".cloud",
    ".love",
    ".press",
    ".space",
    ".video",
    ".fit",
    ".yoga",
    ".info",
    ".design",
    ".link",
    ".live",
    ".wiki",
    ".life",
    ".world",
    ".run",
    ".show",
    ".下单",
    ".小天",
    ".莱斯特",
    ".电玩",
    ".city",
    ".gold",
    ".today",
    ".plus",
    ".cool",
    ".icu",
    ".company",
    ".chat",
    ".zone",
    ".fans",
    ".host",
    ".center",
    ".email",
    ".fund",
    ".social",
    ".team",
    ".guru",
    ".CLOUD",
    ".LOVE",
    ".PRESS",
    ".SPACE",
    ".VIDEO",
    ".FIT",
    ".YOGA",
    ".INFO",
    ".DESIGN",
    ".LINK",
    ".LIVE",
    ".WIKI",
    ".LIFE",
    ".WORLD",
    ".RUN",
    ".SHOW",
    ".CITY",
    ".GOLD",
    ".TODAY",
    ".PLUS",
    ".COOL",
    ".ICU",
    ".COMPANY",
    ".CHAT",
    ".ZONE",
    ".FANS",
    ".HOST",
    ".CENTER",
    ".EMAIL",
    ".FUND",
    ".SOCIAL",
    ".wecheat.club",
    ".一元一亿",
    ".GURU"
}

Chat_trial = menu.add_feature("拦截广告机", "toggle", parentId, function(e)
        if e.on then
            chat_trial_id=event.add_event_listener("chat",function(b)
                local pid=b.player
                local msg=b.body
                if player.is_player_valid(pid) and not player.is_player_friend(pid) then
                    for i=1,#key_words do
                        if msg:match("%"..key_words[i]) then
                            menu.notify("检测到广告机\n正在踢出玩家+黑名单的玩家名为：\n\n"..player.get_player_name(pid).."\nR*ID为\n"..player.get_player_scid(pid),"Universe 定制",6,8)
                            local file=io.open(utils.get_appdata_path("PopstarDevs", "").."\\2Take1Menu\\cfg\\scid.cfg","a+")
                            local msg=file:read('*a')
                            if not string.find(msg,string.format("%x",player.get_player_scid(pid))) then
                                file:write("\nad_bot:"..string.format("%x",player.get_player_scid(pid))..":c")
                            end
                            io.close(file)
                            if player.is_player_valid(pid) then
                                network.network_session_kick_player(pid)
                                network.force_remove_player(pid)
                            end
                            return HANDLER_CONTINUE
                        end
                    end
                end
            end)
        else
            event.remove_event_listener("chat",chat_trial_id)
        end
    end
)
Chat_trial.on=true




























-- local parentId = menu.add_feature("生活质量变化", "parent", 0).id

-- zhujixulie = menu.add_feature("战局信息", "value_str", parentId, function(e)

ZHUJIXULIELIE = menu.add_feature("战局信息","parent", 0)

local inviciamountint = 0
local inviciamountintt = 0
local inviciamountinttt = ""
local zhujixulie_weizhii = v2()
local zhujixulie_weizhii1 = v2()
local zhujixulie_weizhii2 = v2()
local zhujixulie_weizhii3 = v2()
local zhujixulie_weizhii4 = v2()
local zhujixulie_weizhii5 = v2()
local zhujixulie_weizhii6 = v2()
local zhujixulie_weizhii7 = v2()
local zhujixulie_weizhi_XX = 0.17
local zhujixulie_weizhi_YY = 0.77

invicamountloop = menu.add_feature("loop", "toggle", parentId, function(f)
    if f.on then
        inviciamountint = 0
        for pid = 0, 31 do
            if player.is_player_valid(pid) and pid ~= player.player_id() then
                local pped = player.get_player_ped(pid)
				local playpossss = player.get_player_coords(pid)
                if pped ~= 0 then
                    if (player.is_player_god(pid) and (interior.get_interior_from_entity(pped) == 0 and playpossss.z > -100)) or player.is_player_vehicle_god(pid) then
                        inviciamountint = inviciamountint + 1
                    end
                end
            end
        end
        inviciamountintt = inviciamountint
        return HANDLER_CONTINUE
    end
end)
invicamountloop.hidden = true

suduzhenceloop = menu.add_feature("loop", "toggle", toggle, function(feat)
	while feat.on do
        local myentityy
        local myentityy1 = player.get_player_ped(player.player_id())	
        local myentityy2 = ped.get_vehicle_ped_is_using(player.get_player_ped(player.player_id()))
        if ped.is_ped_in_any_vehicle(myentityy1) then
            myentityy = myentityy2
        else
            myentityy = myentityy1
        end
        local myyyspeed = entity.get_entity_speed(myentityy)
        local speedcalcuuuu = myyyspeed * 3.6
        myspeedddd1 = math.ceil(speedcalcuuuu)
		return HANDLER_CONTINUE
	end
end)
suduzhenceloop.hidden = true
suduzhenceloop.on = true

zhujixulie = menu.add_feature("战局信息", "value_str", ZHUJIXULIELIE.id, function(e)
    
	if e.on then
        local hostman,renshu,jiaobzhuji,nextzhuji,nextzhujixulie
        zhujixulie_weizhii.x = zhujixulie_weizhi_XX
        zhujixulie_weizhii.y = zhujixulie_weizhi_YY
        zhujixulie_weizhii1.x = zhujixulie_weizhi_XX
        zhujixulie_weizhii1.y = zhujixulie_weizhii.y + 0.028
        zhujixulie_weizhii2.x = zhujixulie_weizhi_XX
        zhujixulie_weizhii2.y = zhujixulie_weizhii1.y + 0.028
        zhujixulie_weizhii3.x = zhujixulie_weizhi_XX
        zhujixulie_weizhii3.y = zhujixulie_weizhii2.y + 0.028
        zhujixulie_weizhii4.x = zhujixulie_weizhi_XX
        zhujixulie_weizhii4.y = zhujixulie_weizhii3.y + 0.028
        zhujixulie_weizhii5.x = zhujixulie_weizhi_XX
        zhujixulie_weizhii5.y = zhujixulie_weizhii4.y + 0.028
        zhujixulie_weizhii6.x = zhujixulie_weizhi_XX
        zhujixulie_weizhii6.y = zhujixulie_weizhii5.y + 0.028
        zhujixulie_weizhii7.x = zhujixulie_weizhi_XX
        zhujixulie_weizhii7.y = zhujixulie_weizhii6.y + 0.028
        invicamountloop.on = true

        if e.value == 0 then
            hostman = player.get_player_name(player.get_host())
            renshu = tostring(player.player_count())
            jiaobzhuji = player.get_player_name(script.get_host_of_this_script())
            nextzhuji = " "
			nextzhujixulie = 31
            if player.player_count() > 1 then
                for pid = 0, 31 do
                    if player.get_player_name(pid) ~= nil then
						if not player.is_player_host(pid) then
							nectmanprio = player.get_player_host_priority(pid)
							if nectmanprio < nextzhujixulie then
								nextzhujixulie = nectmanprio
								nextzhuji = player.get_player_name(pid)
								if pid == player.player_id() then
									nextzhuji = tostring("~b~自己")
								end
							end
						end
                    end
                end
				nextzhuji = "~o~" .. tostring(nextzhuji)
            else
                nextzhuji = "~o~没有人"
            end
            if hostman ~= nil then
				if hostman == player.get_player_name(player.player_id()) then
					hostman = tostring("~b~自己")
				else
					hostman = "~y~" .. tostring(hostman)
				end
			else
				hostman = "~o~没有人"
			end
            if jiaobzhuji == player.get_player_name(player.player_id()) then
                jiaobzhuji = tostring("~b~自己")
            else
                jiaobzhuji = "~c~" .. tostring(jiaobzhuji)
            end

            local myzhujixulie = player.get_player_host_priority(player.player_id())
            local systTimee = os.time()
            local systTimee2 = (os.date('%H:%M:%S', systTimee))
            ui.set_text_scale(0.28)
            ui.set_text_font(1)
            ui.set_text_color(255, 255, 255, 255)
            ui.set_text_centre(false)
            ui.set_text_outline(true)
            ui.draw_text("~h~~o~" .. myspeedddd1 .. "~w~ Km/h", zhujixulie_weizhii)
            ui.set_text_scale(0.28)
            ui.set_text_font(1)
            ui.set_text_centre(false)
            ui.set_text_outline(true)
            ui.set_text_color(255, 255, 255, 255)
            ui.draw_text("~h~" .. systTimee2, zhujixulie_weizhii1)
            ui.set_text_color(255, 255, 255, 255)
            ui.set_text_scale(0.28)
            ui.set_text_font(1)
            ui.set_text_centre(false)
            ui.set_text_outline(true)
            ui.draw_text("~h~战局玩家 : " .. "~g~" .. renshu,zhujixulie_weizhii2)
            inviciamountinttt = tostring(inviciamountintt)
            ui.set_text_color(255, 255, 255, 255)
            ui.set_text_scale(0.28)
            ui.set_text_font(1)
            ui.set_text_centre(false)
            ui.set_text_outline(true)
            ui.draw_text("~h~无敌玩家 : " .. "~r~" .. inviciamountinttt,zhujixulie_weizhii3)
            ui.set_text_color(255, 255, 255, 255)
            ui.set_text_scale(0.28)
            ui.set_text_font(1)
            ui.set_text_centre(false)
            ui.set_text_outline(true)
            ui.draw_text("~h~战局主机 : ".. hostman,zhujixulie_weizhii4)
            ui.set_text_color(255, 255, 255, 255)
            ui.set_text_scale(0.28)
            ui.set_text_font(1)
            ui.set_text_centre(false)
            ui.set_text_outline(true)
            ui.draw_text("~h~脚本主机 : ".. jiaobzhuji,zhujixulie_weizhii5)
            ui.set_text_color(255, 255, 255, 255)
            ui.set_text_scale(0.28)
            ui.set_text_font(1)
            ui.set_text_centre(false)
            ui.set_text_outline(true)
            ui.draw_text("~h~下一个主机 : ".. nextzhuji,zhujixulie_weizhii6)
            ui.set_text_color(255, 255, 255, 255)	
            ui.set_text_scale(0.28)
            ui.set_text_font(1)
            ui.set_text_centre(false)
            ui.set_text_outline(true)
            if player.is_player_host(player.player_id()) then
                ui.draw_text("~h~~q~你现在是战局主机",zhujixulie_weizhii7)
            else
                ui.draw_text("~h~~p~你的主机优先度 : ~q~" .. myzhujixulie,zhujixulie_weizhii7)
            end
            

        end
    else
        invicamountloop.on = false
    end
    return HANDLER_CONTINUE
end)

zhujixulie:set_str_data({
	"V1",
})
zhujixulie.on = true