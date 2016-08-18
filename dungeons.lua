

--true for raids and scenarios and other stuff prob
function inDungeon()
 local isInstance, instanceType = IsInInstance()
 local zoneName = GetZoneText()
 if isInstance and (instanceType ~= "pvp") and (instanceType ~= "none") and (zoneName ~= "Kelp'thar Forest") then
   return true
 else
   return false
  end

end


function DungeonUpdateFrame()
  for i=1,2 do -- check once with all characters, once without
    if i==1 then
       accountWide=true
    else
       accountWide=false
    end

   -- get zone name
   -- match zone name to ach
    zoneName = GetZoneText()
--    ChatFrame1:AddMessage("BrockProgress - zonename:"..zoneName);
--timewalking check
  local weekday,month,day = CalendarGetDate()
  CalendarSetAbsMonth(month)
  
  local numEvents = CalendarGetNumDayEvents(0,day)
    if numEvents > 0 then
       for i=1,numEvents do
      -- is there a holiday on now?
         local title,hour,minute,calendarType = CalendarGetDayEvent(0,day,i)
		 if title == TIMEWALKINGEVENT then
            TimeWalkingEvent(accountWide)    
		 end
        -- if so, call appropriate function.
       end
    end
    checkDungeons(accountWide)
  end --for
end

function GeneralDungeons()
  displayAchievement(GLORYOFTHEHERO)
  displayAchievement(NORTHRENDDUNGEONHERO)
displayAchievement(NORTHRENDDUNGEONMASTER)
  displayAchievement(CLASSICDUNGEONMASTER)
  displayAchievement(OUTLANDDUNGEONMASTER)
end



--for all level specific achs..get before you level.  raids too if max level kicks in. use 
--'you should really be doing this now' level, rather than min
--also include max level once it falls off charts.
function checkDungeons(includesOtherCharacters)
 if not DKinStartZone() then
    local playerlevel = UnitLevel("player");
    checkDungeonList(VANILLADUNGEONACHIEVEMENTS,VANILLADUNGEONMAXLEVEL,includesOtherCharacters)
    checkDungeonList(BCDUNGEONACHIEVEMENTS,BCDUNGEONMAXLEVEL,includesOtherCharacters)
    checkDungeonList(WRATHDUNGEONACHS,WRATHDUNGEONMAXLEVEL,includesOtherCharacters)

--only faction-specific dungeon achs!
    if (playerlevel <= 85 and playerlevel >= 80) or CHECKMISSINGACHIEVEMENTS then
      if Alliance() then
        displayAchievement(TRIALOFTHECHAMPIONA)
        displayAchievement(HEROICTRIALOFTHECHAMPIONA)
      else
        displayAchievement(TRIALOFTHECHAMPIONH)
        displayAchievement(HEROICTRIALOFTHECHAMPIONH)
      end
    end
	--ChatFrame1:AddMessage("BrockProgress - checking cata dungeons");
      checkDungeonList(CATADUNGEONACHS,CATADUNGEONMAXLEVEL,includesOtherCharacters)
      checkDungeonListLimit(PANDADUNGEONACHS,PANDADUNGEONMAXLEVEL,includesOtherCharacters,5)
      checkDungeonListLimit(PANDARAIDS,PANDARAIDSMAXLEVEL,includesOtherCharacters,5)
      checkDungeonListLimit(DRAENORDUNGEONACHS,DRAENORDUNGEONMAXLEVEL,includesOtherCharacters,5)
--    end
 end
end

function checkDungeonListLimit(dungeonmin,dungeonmax,accountWide,dungeonlimit)
    local playerlevel = UnitLevel("player");
    dungeoncount = 0
    for dungeon, minlevel in pairs (dungeonmin) do
	  
     if CHECKMISSINGACHIEVEMENTS then --make sure all are fired.
        minlevel = 1
        dungeoncount = 0      
     end
     if minlevel <= playerlevel and dungeoncount < dungeonlimit then
        if (dungeonmax[dungeon] >= playerlevel) or CHECKMISSINGACHIEVEMENTS then
          displayAchievement(dungeon, accountWide)
          dungeoncount=dungeoncount+1
        end
     end
    end
end


function checkDungeonList(dungeonmin,dungeonmax,accountWide)
    local playerlevel = UnitLevel("player");
    for dungeon, minlevel in pairs (dungeonmin) do
     if CHECKMISSINGACHIEVEMENTS then --make sure all are fired.
        minlevel = 1      
     end
     if minlevel <= playerlevel then
        if (dungeonmax[dungeon] >= playerlevel) or CHECKMISSINGACHIEVEMENTS then
          displayAchievement(dungeon, accountWide)
        end
     end
    end
end
