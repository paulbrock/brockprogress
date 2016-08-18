
DARKMOONTICKETS = 515
DARKMOONTARGET =110

lockedStarterZones = {}
lockedStarterZones["The Wandering Isle"]=true
lockedStarterZones["Kezan"]=true
lockedStarterZones["Gilneas"]=true
lockedStarterZones["Plaguelands: The Scarlet Enclave"] = true



function inLockedStarterZone()
  --get current zone
  local currentZone = GetZoneText();
--  ChatFrame1:AddMessage("zonetext="..currentZone);
  --if zone on list then true
  return (lockedStarterZones[currentZone] ~= nil )
end


function checkHolidays(accountWide,CHECKMISSINGACHIEVEMENTSLOCAL)
  if not inLockedStarterZone() then
    local weekday,month,day = CalendarGetDate()
    CalendarSetAbsMonth(month)
    local numEvents = CalendarGetNumDayEvents(0,day)
    if numEvents > 0 then
       for i=1,numEvents do
      -- is there a holiday on now?
         local title,hour,minute,calendarType = CalendarGetDayEvent(0,day,i)
         outputHolidayAchievements(title,accountWide)
        -- if so, call appropriate function.
       end
    end
  end

  if CHECKMISSINGACHIEVEMENTSLOCAL then
       ChatFrame1:AddMessage("BrockProgress-checkholidays: checking all hols")      
       PilgrimsBounty(accountWide)
       WinterVeil(accountWide)
       DarkmoonFaire(accountWide)
       outputHolidayAchievements(NOBLEGARDEN,accountWide)
       outputHolidayAchievements(STRANGLETHORNFISHING,accountWide)
       ChildrensWeek(accountWide)
       BrewFest(accountWide)
       Midsummer(accountWide)
       LunarFestival(accountWide)
       LoveIsInTheAir(accountwide)
       HallowsEnd(accountwide)
	   
       outputHolidayAchievements(DAYOFTHEDEAD,accountWide)
       outputHolidayAchievements(PIRATESDAY,accountWide)
       ChatFrame1:AddMessage("BrockProgress: completed checking all hols")      
   end

end

--check pvp holidays.  Not quite sure how to do this.
function checkPVPHolidays(accountWide)
  if not inLockedStarterZone() then
  local weekday,month,day = CalendarGetDate()
  CalendarSetAbsMonth(month)
  local numEvents = CalendarGetNumDayEvents(0,day)
  if numEvents > 0 then
     for i=1,numEvents do
    -- is there a holiday on now?
       local title,hour,minute,calendarType = CalendarGetDayEvent(0,day,i)
       outputPVPHolidayAchievements(title,accountWide)
    -- if so, call appropriate function.
     end
  end
  end
end


--for now just limit to removing holidays with no PVP
function outputPVPHolidayAchievements(title,accountWide)
  if title == PILGRIMSBOUNTY then
    PilgrimsBounty(accountWide)
  elseif title == WINTERVEIL then
    WinterVeil(accountWide)
  elseif title == NOBLEGARDEN then
    NobleGarden(accountWide)
  elseif title == CHILDRENSWEEK then
    ChildrensWeek(accountWide)
  elseif title == BREWFEST then
    Brewfest(accountWide)
  elseif title == MIDSUMMER then
    Midsummer(accountWide)
  elseif title == LUNARFESTIVAL then
--    LunarFestival(accountWide) -- do nothing.  no LF achs are pvp
  elseif title == LOVEISINTHEAIR then
    LoveIsInTheAir(accountwide)
  elseif title == HALLOWSEND then
       displayAchievement(GNERDRAGE,accountWide)
  end
end


function BrewFest(accountwide)
  OAFT(BREWFESTNEUTRAL,accountwide)
  if UnitFactionGroup("player") == "Alliance" or CHECKMISSINGACHIEVEMENTS then
    displayAchievement(STRANGEBREWA,accountwide)
   elseif UnitLevel("player") >= 55 or CHECKMISSINGACHIEVEMENTS then  -- horde and 55
     displayAchievement(STRANGEBREWH,accountwide)
  end
end

function outputHolidayAchievements(title,accountwide)
  if title == PILGRIMSBOUNTY then
    PilgrimsBounty(accountwide)
  elseif title == WINTERVEIL then
    WinterVeil(accountwide)
  elseif title == STRANGLETHORNFISHING or title == KALUAKFISHING then
    FishingTournament( accountwide)
  elseif title == DARKMOONFAIRE then
    DarkmoonFaire(accountwide)
  elseif title == NOBLEGARDEN then
    NobleGarden()
  elseif title == CHILDRENSWEEK then
    ChildrensWeek()
  elseif title == BREWFEST then
    BrewFest(accountwide)
  elseif title == MIDSUMMER then
    Midsummer(accountwide)
  elseif title == LUNARFESTIVAL then
    LunarFestival(accountwide)
  elseif title == LOVEISINTHEAIR then
    LoveIsInTheAir(accountwide)

  elseif title == HALLOWSEND then
    HallowsEnd(accountwide)
  elseif title == DAYOFTHEDEAD then
    OAFT(DAYOFTHEDEADACHS, accountwide)
  elseif title == PIRATESDAY then
    OAFT(PIRATESDAYACHS, accountwide)
  elseif title == BATTLEGROUNDBONUSEVENT then
    BattlegroundBonusEvent()
  elseif title == DRAENORDUNGEONBONUSEVENT then
    DraenorDungeonBonusEvent()
  elseif title == PETBATTLEBONUSEVENT then
    PetBattleBonusEvent(accountwide)
  elseif title == TIMEWALKINGEVENT then
    TimeWalkingEvent(accountwide)
  elseif title == APEXISBONUSEVENT then
    ApexisBonusEvent(accountwide)
  else
    ChatFrame1:AddMessage("BrockProgress:"..title.." not a recognised Holiday")
  end
end

function ApexisBonusEvent(accountWide)
  if UnitLevel("player") > 95 then
    displayAchievement(MASTEROFAPEXIS,accountWide)
  end
end

function TimeWalkingEvent(accountwide)
 --output all relevant dungeons  only relevant for lvl 71+ - NO MAX LEVEL
 --only covers
 --BC: arcatraz, black morass, mana tombs, shattered halls, slave pens
 --Wrath:ahnkahet, gundrak, halls of lightning, nexus, utgarde pinnacle
 if UnitLevel("player") >= 71 then
 
--BC
 displayAchievement(HEROICMANATOMBS,accountwide)
 displayAchievement(HEROICSHATTEREDHALLS,accountwide)
 displayAchievement(ARCATRAZ,accountwide)
 displayAchievement(HEROICSLAVEPENS,accountwide)
 displayAchievement(HEROICARCATRAZ,accountwide)
 displayAchievement(SLAVEPENS,accountwide)
 displayAchievement(SHATTEREDHALLS,accountwide)
 
--WRATH DUNGEONS (NONHEROIC)--
 displayAchievement(AHNKAHET,accountwide)
 displayAchievement(GUNDRAK,accountwide)
 displayAchievement(HALLSOFLIGHTNING,accountwide)
 displayAchievement(NEXUS,accountwide)
 displayAchievement(UTGARDEPINNACLE,accountwide)
 
--wrath heroic
   displayAchievement(HEROICAHNKAHET,accountwide)
   displayAchievement(HEROICGUNDRAK,accountwide)
   displayAchievement(HEROICHALLSOFLIGHTNING,accountwide)
   displayAchievement(HEROICNEXUS,accountwide)
   displayAchievement(HEROICUTGARDEPINNACLE,accountwide)
   
   displayAchievement(DONTLOOKUP,accountwide)
   displayAchievement(IVEHADWORSE,accountwide)
   displayAchievement(WERENOTRETREATING,accountwide)
   displayAchievement(ONTHEROCKS,accountwide)
   displayAchievement(INTENSECOLD,accountwide)
   displayAchievement(WATCHHIMDIE,accountwide)
   displayAchievement(GOTTAGO,accountwide)
   displayAchievement(RESPECTYOURELDERS,accountwide)
   displayAchievement(CONSUMPTIONJUNCTION,accountwide)
   displayAchievement(OHNOVOS,accountwide)
   displayAchievement(LOCKDOWN,accountwide)
   displayAchievement(AVOIDDANCE,accountwide)
   displayAchievement(SHARETHELOVE,accountwide)
   displayAchievement(SNAKESWHYDITHAVETOBESNAKES,accountwide)
   displayAchievement(BRANNSPANKINNEW,accountwide)
   displayAchievement(TIMELYDEATH,accountwide)
   displayAchievement(SHATTERRESISTANT,accountwide)
   displayAchievement(ZOMBIEFEST,accountwide)
   displayAchievement(LODIDODIWELOVESTHESKADI,accountwide)
   displayAchievement(KINGSBANE,accountwide)
   displayAchievement(MAKEITCOUNT,accountwide)
   displayAchievement(EMERALDVOID,accountwide)
   displayAchievement(SPLITPERSONALITY,accountwide)
   displayAchievement(CHAOSTHEORY,accountwide)
   displayAchievement(HADRONOXDENIED,accountwide)
   displayAchievement(VOLAZJSQUICKDEMISE,accountwide)
   displayAchievement(VOLUNTEERWORK,accountwide)
   displayAchievement(BETTEROFFDRED,accountwide)
   displayAchievement(DEFENSELESS,accountwide)
   displayAchievement(DEHYDRATION,accountwide)
   displayAchievement(WHATTHEECK,accountwide)
   displayAchievement(LESSRABI,accountwide)
   displayAchievement(GOODGRIEF,accountwide)
   displayAchievement(ABUSETHEOOZE,accountwide)
   displayAchievement(LIGHTNINGSTRUCK,accountwide)
   displayAchievement(THECULLINGOFTIME,accountwide)
   displayAchievement(THEINCREDIBLEHULK,accountwide)
   displayAchievement(MYGIRLLOVESTOSKADIALLTHETIME,accountwide)
   displayAchievement(EXPERIENCEDDRAKERIDER,accountwide)
   displayAchievement(RUBYVOID,accountwide)
   displayAchievement(AMBERVOID,accountwide)
 end
 
 
end


function BattlegroundBonusEvent()
 --if right level for bonus battlegrounds
 if UnitLevel("player") >= 15 then --think this is right
   BGdailyflag = false; --reset flag so it keeps showing up
 end
end

function PetBattleBonusEvent(accountwide)
  OAFT(BATTLINGPETBATTLEACHS,accountwide,5)
  startcount = outputcounter; --can we see outputcounter?
  lines = 2
  
avgpetlevel = GetAveragePetLevel(1)  -- only for current selected pets
playerlevel = UnitLevel("player") 

  for currachievement,currlevel in pairs(PETBATTLEACHS) do
     -- if table level < player level then display achievement
      if currlevel <= avgpetlevel then
        if playerlevel >= PETBATTLEACHSPLAYER[currachievement] and (outputcounter-startcount) < lines then
          displayAchievement(currachievement,accountwide)
          
        end
      end 
  end
end



function DraenorDungeonBonusEvent()
 --if right level for bonus battlegrounds
 if UnitLevel("player") >= 95 then 
   ChatFrame1:AddMessage("BrockProgress:do some dungeons")
 end
end


function Midsummer(accountwide)
--level check

local playerlevel = UnitLevel("player");
if CHECKMISSINGACHIEVEMENTS then
  playerlevel = 120
end
  OAFT(MIDSUMMERACHS,accountwide)
  if UnitFactionGroup("player") == "Alliance" then
    displayAchievement(EXTINGUISHINGEKA)
    displayAchievement(EXTINGUISHINGKA)
    displayAchievement(FLAMEKEEPEREKA)
    displayAchievement(FLAMEKEEPERKA)
    if playerlevel >= 40 then
    displayAchievement(FLAMEKEEPEROUTLANDA)
    displayAchievement(FLAMEKEEPERNORTHA)
    displayAchievement(EXTINGUISHINGNORTHA)
    displayAchievement(EXTINGUISHINGOUTLANDA)
    end
    if playerlevel >= 60 then
      displayAchievement(EXTINGUISHINGCATAA)
      displayAchievement(EXTINGUISHINGPANDARIAA)
      displayAchievement(FLAMEKEEPERCATAA) 
      displayAchievement(DESECRATIONOFTHEHORDE) 
      displayAchievement(FIRESOFAZEROTHA) 
      displayAchievement(FLAMEWARDENOFPANDARIA) 

    end

   else

    displayAchievement(EXTINGUISHINGEKH)
    displayAchievement(EXTINGUISHINGKH)
    displayAchievement(FLAMEKEEPEREKH)
    displayAchievement(FLAMEKEEPERKH)
    if playerlevel >= 40 then
      displayAchievement(EXTINGUISHINGNORTHH)
      displayAchievement(EXTINGUISHINGOUTLANDH)
      displayAchievement(FLAMEKEEPEROUTLANDH)
      displayAchievement(FLAMEKEEPERNORTHH)
    end
    if playerlevel >= 60 then
      displayAchievement(EXTINGUISHINGCATAH)
      displayAchievement(EXTINGUISHINGPANDARIAH)
      displayAchievement(FLAMEKEEPERCATAH)   
      displayAchievement(DESECRATIONOFTHEALLIANCE) 
      displayAchievement(FIRESOFAZEROTHH) 
      displayAchievement(FLAMEKEEPEROFPANDARIA) 
    end
  end
 -- add dailies somehow?
end


function ChildrensWeek()

--level check

local playerlevel = UnitLevel("player");
if CHECKMISSINGACHIEVEMENTS then
  playerlevel = 120;
end

if playerlevel >= 10 then

   --level 10 to get orphan, pet, as long as can get orphan
   displayAchievement(HOMEALONE)
   displayAchievement(AWISNTITCUTE)
   --any 5 dailies - levl 10
   displayAchievement(DAILYCHORES)
   --nasty; wg, ab - level 10
   displayPartAchievement(SCHOOLOFHARDKNOCKS,2)
   if playerlevel >= 20 then

     --nasty;  eots-20
     displayPartAchievement(SCHOOLOFHARDKNOCKS,3)
     if playerlevel >= 45 then
       --nasty; av-45
       displayAchievement(SCHOOLOFHARDKNOCKS)
       if playerlevel >= 75 then
          --min level for food 75
          displayAchievement(BADEXAMPLE)
          --UP similar level - 75?	
          displayAchievement(HAILTOTHEKINGBABY)
          displayAchievement(FORTHECHILDREN)
       end
     end
   end


   displayAchievement(VETERANNANNY)
end



end


function NobleGarden(accountwide)
  OAFT(NOBLEGARDENNEUTRAL,accountwide)

  if UnitFactionGroup("player") == "Alliance" then
    displayAchievement(NOBLEGARDENA,accountwide)
    displayAchievement(SPRINGFLINGA,accountwide)
   else
     displayAchievement(SPRINGFLINGH,accountwide)
    displayAchievement(NOBLEGARDENH,accountwide)
  end

end


function CheckDMProfessionQuests()
DMFIRSTAIDQUEST=29512
DMFISHINGQUEST=29513
DMCOOKINGQUEST=29509
  complete = 0;
  --check each secondary profession
  if IsQuestFlaggedCompleted(DMFIRSTAIDQUEST) then
    complete = 1;
  end
  if IsQuestFlaggedCompleted(DMFISHINGQUEST) then
    complete = complete+1;
  end
  if IsQuestFlaggedCompleted(DMCOOKINGQUEST) then
    complete = complete+1;
  end
  --if at least 1 incomplete, output line
  if complete < 3 then
    addLine("Darkmoon profession quests: "..complete.." /3");
  end
end


function DarkmoonFaire(accountwide)
--any level 
 -- add dailies somehow?
  --ChatFrame1:AddMessage("BrockProgress:DMFAIRE START")
  if accountwide and (GetDailyQuestsCompleted() < 5) then
    addLine("Darkmoon dailies complete: "..GetDailyQuestsCompleted().."/5");
  end
  if accountwide then 
    CheckDMProfessionQuests()
  end
  OAFT(DARKMOONFAIRENEUTRAL,accountwide,3)
       
  local playerlevel = UnitLevel("player");
  if CHECKMISSINGACHIEVEMENTS then
    playerlevel = 120
  end
  local hours, minutes=GetGameTime()
--late night or 30+
  if (hours > 3 and hours < 9) or playerlevel >=60 then
     displayAchievement(DARKMOONDUELIST,accountwide)
     displayAchievement(DARKMOONDOMINATOR,accountwide)
  end 
--need to go to shattrath and dalaran

if playerlevel >= 58 then
  if UnitFactionGroup("player") == "Horde" then
    displayAchievement(TAKINGTHESHOWONTHEROADH,accountwide)
  else
    displayAchievement(TAKINGTHESHOWONTHEROADA,accountwide)
  end
end
    ChatFrame1:AddMessage("BrockProgress:dmfaire currency")
  if getCurrencyLevel(DARKMOONTICKETS) >= DARKMOONTARGET then
    addLine("spend Darkmoon tickets! Balance:"..getCurrencyLevel(DARKMOONTICKETS))
  end

end


function FishingTournament( accountwide)
--no point on trial.  OK for low levels though as can switch to higher one
  --if between 9am and 2pm, output. 
  ChatFrame1:AddMessage("BrockProgress:fish tourney called")
  local hours, minutes=GetGameTime()
  if not IsTrialAccount() then
    if hours > 5 and hours < 15 then
      displayAchievement(FISHINGTOURNAMENT, accountwide) 
    end
  end
end


function PilgrimsBounty(accountWide)
--any level can do these
  displayAchievement(FOODFIGHT,accountWide)  
  displayAchievement(SHARINGISCARING,accountWide)
  displayAchievement(TURKINATOR,accountWide)
  local playerlevel = UnitLevel("player");
  if CHECKMISSINGACHIEVEMENTS then
    playerlevel = 120
  end
  if playerlevel >= 10 then
    displayAchievement(TURKEYLURKEY,accountWide)
  end
  if playerlevel >= 55 then
    displayAchievement(TEROKKARTURKEY,accountWide)
  end
  if accountWide then
    displayCooking(300)
  end


  if UnitFactionGroup("player") == "Horde" then
    displayAchievement(NOWWERECOOKINGH,accountWide)
    displayAchievement(PILGRIMSPROGRESSH,accountWide)
    displayAchievement(PILGRIMSPAUNCHH,accountWide)
    if playerlevel >= 55 then
      displayAchievement(PILGRIMSPERILH,accountWide)
      displayAchievement(PILGRIMA,accountWide)
    end
  else
    displayAchievement(NOWWERECOOKINGA,accountWide)
    displayAchievement(PILGRIMSPROGRESSA,accountWide)
    displayAchievement(PILGRIMSPAUNCHA,accountWide)
    if playerlevel >= 55 then
      displayAchievement(PILGRIMSPERILA,accountWide)
      displayAchievement(PILGRIMA,accountWide)
    end

  end
end

function WinterVeil(accountWide)
  OAFT(WINTERVEILNEUTRAL,accountWide)
  local playerlevel = UnitLevel("player");
  if CHECKMISSINGACHIEVEMENTS then
    playerlevel = 120
  end
--all seem to rely on the WV quest
  if UnitFactionGroup("player") == "Horde" then
    displayAchievement (SCROOGEH,accountWide)
    if playerlevel >= 70 then
      displayAchievement (BROSBEFOREHOHOHOSH,accountWide)
      displayAchievement (ACAROLINGWEWILLGOH,accountWide)
      displayAchievement (BBKINGH,accountWide)
    end
  else
    displayAchievement (SCROOGEA,accountWide)
    if playerlevel >= 20 then
      displayAchievement (BROSBEFOREHOHOHOSA,accountWide)
    end
    if playerlevel >= 70 then
      displayAchievement (ACAROLINGWEWILLGOA,accountWide)
      displayAchievement (BBKINGA,accountWide)
    end
  end

end

function LunarFestival(accountwide)
--iterate through list of achievements, set by side and level.
  OAFT(LUNARFESTIVALNEUTRAL,accountwide)
--  OAFT(KALIMDOREXPLOREACHIEVEMENTS,accountwide)
end



function HallowsEnd(accountwide)
--iterate through list of achievements, set by side and level.
  OAFT(HALLOWSENDNEUTRAL,accountwide)
  if UnitFactionGroup("player") == "Alliance" then
    OAFT(HALLOWSENDALLIANCE,accountwide)
  elseif UnitFactionGroup("player") == "Horde" then
    OAFT(HALLOWSENDHORDE,accountwide)
  end
end


function LoveIsInTheAir(accountwide)
--iterate through list of achievements, set by side and level.
  OAFT(LOVEISINTHEAIRNEUTRAL,accountwide)
  if UnitFactionGroup("player") == "Alliance" then
    OAFT(LOVEISINTHEAIRALLIANCE,accountwide)
  elseif UnitFactionGroup("player") == "Horde" then
    OAFT(LOVEISINTHEAIRHORDE,accountwide)
  end
end