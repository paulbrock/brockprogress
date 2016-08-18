  
function DKinStartZone()
 -- if class == dk and level == 58 then return true
 if UnitClass("player") == "Death Knight" and UnitLevel("player") < 58 then

   return true
 else  
   return false
 end
end

function Quests()
   displayPartAchievement(THREETHOUSANDQUESTS,getQuestTarget(UnitLevel("player")))
end

function pandaInStartZone()
 if UnitRace("player") == "Pandaren" and UnitFactionGroup("player") == "Neutral" then
   return true
 else  
   return false
 end
end




function Alliance()
 return (UnitFactionGroup("player") == "Alliance")
end

function Horde()
 return (UnitFactionGroup("player") == "Horde")
end

function allGeneral()
  displayAchievement(SHAVEANDAHAIRCUT) --might as well dump it here
  displayAchievement(GOINGDOWN)
  displayAchievement(STABLEKEEPER) --everyone has this
  displayAchievement(FILLINGUPTHEBARN) --everyone has this
end



--need to do this by pet level really. but how?
function allPetBattleAchievements(accountwide)
--only if not trial account
  startcount = outputcounter; --can we see outputcounter?
  lines = 2
  
avgpetlevel = GetAveragePetLevel(1)  -- only for current selected pets
playerlevel = UnitLevel("player") 

if CHECKMISSINGACHIEVEMENTS then
  playerlevel = 120
  avgpetlevel = 999
end
OAFT(COLLECTPETACHS,accountwide,2)
OAFT(BATTLINGPETBATTLEACHS,accountwide,2)
OAFT(LEVELLINGPETBATTLEACHS,accountwide,2)



if (not IsTrialAccount() and not DKinStartZone()) or CHECKMISSINGACHIEVEMENTS then 
  if Alliance() then
       displayAchievement(TAMINGEK,accountwide)
  else 
       displayAchievement(TAMINGKALIMDOR,accountwide)
  end

  for currachievement,currlevel in pairs(PETBATTLEACHS) do
     -- if table level < player level then display achievement
      if currlevel <= avgpetlevel then
        if playerlevel >= PETBATTLEACHSPLAYER[currachievement] and (outputcounter-startcount) < lines then
          displayAchievement(currachievement,accountwide)
          
        end
      end 
  end
end

end


function GetAveragePetLevel(duffnumber)
totallevel = 0;
for i=1,3 do
  currentpetID = C_PetJournal.GetPetLoadOutInfo(i);
  if currentpetID == nil then
    return 0;
  end
  speciesID, customname, petlevel = C_PetJournal.GetPetInfoByPetID(currentpetID);
  totallevel = totallevel + petlevel;
end

return (totallevel/3)

end

function checkQuests(includesOtherCharacters)
  if CharacterDoingVanilla() then
    OutputVanillaAchievements(includesOtherCharacters)
  end
 if CharacterDoingOutlands() or CHECKMISSINGACHIEVEMENTS then
   OutputAchievementsFromTable(OUTLANDACHS,includesOtherCharacters)
   if Alliance() then
      OutputAchievementsFromTable(OUTLANDALLIANCEACHS,includesOtherCharacters) 
   else 
      OutputAchievementsFromTable(OUTLANDHORDEACHS,includesOtherCharacters) 
   end
  end 
  if Northrend() then  
    OutputAchievementsFromTable(WRATHQUESTS, includesOtherCharacters, 5)
   if Alliance() then
      OutputAchievementsFromTable(WRATHALLYQUESTS,includesOtherCharacters) 
   else 
      OutputAchievementsFromTable(WRATHHORDEQUESTS,includesOtherCharacters) 
   end
  end
  if Cataclysm() then
    CataQuests(includesOtherCharacters)
  end
  if (doPandaria() and UnitLevel("player") > 80) or CHECKMISSINGACHIEVEMENTS then
    PandaAchievements(includesOtherCharacters)
  end
  checkDraenorQuests(includesOtherCharacters)
end

function level10(includesOtherCharacters)
  displayRep(getHomeFaction(),HONORED)
  local startzone = getStartzone()
  if startzone ~= nil then
    displayAchievement(startzone, includesOtherCharacters)
  end
  if PVP() and (includesOtherCharacters) then 
    HonorableKills(1)
  end
  if CharacterDoingVanilla() then
    OutputVanillaAchievements(includesOtherCharacters)
  end
  OutputAchievementsFromTable(LEVELTENACHIEVEMENTS, includesOtherCharacters,20)
  if Alliance() then
    OutputAchievementsFromTable(LEVELTENALLIANCEACHIEVEMENTS,includesOtherCharacters)
  elseif Horde() then
    OutputAchievementsFromTable(LEVELTENHORDEACHIEVEMENTS,includesOtherCharacters)
  end
  
end


function level15(includesOtherCharacters)
  GeneralDungeons()
  displayRep(getHomeFaction(),REVERED)
  checkProvingGrounds(includesOtherCharacters) -- leave here for now as 15+ supposed to get ach
end


function checkProvingGrounds(includesOtherCharacters)
if not IsTrialAccount()  then 
   --is char a tank class?
   --is char a heal class?
   --is char a dps class (all)

   OutputAchievementsFromTable(PROVINGGROUNDSTANK,includesOtherCharacters,1)
   OutputAchievementsFromTable(PROVINGGROUNDSHEAL,includesOtherCharacters,1)
   OutputAchievementsFromTable(PROVINGGROUNDSACHS,includesOtherCharacters,3)
end
end


function level60(includesOtherCharacters)
--time for a new set of checks.  (and more checks when new expansion)
if CharacterDoingVanilla() then
  vanillaRep()
end
--should be 58 really
  if CharacterDoingOutlands() or CHECKMISSINGACHIEVEMENTS then
   displayAchievement(MEDIUMRARE,includesOtherCharacters)
   displayAchievement(BLOODYRARE,includesOtherCharacters)
   
  end

  checkItemLevel(80);
  displayAchievement(SAFEDEPOSIT,includesOtherCharacters)
--feats
  displayAchievement(THEBREADWINNER,includesOtherCharacters)
  if CharacterDoingVanilla() then
    vanillaRaids(includesOtherCharacters)
  end
  if CharacterDoingOutlands() then
    OAFT(OUTLANDREPACHS,includesOtherCharacters)
	
  end
-- lots need sorting here
   displayAchievement(GOTMYMINDHUNDRED,includesOtherCharacters)
end

function level70(includesOtherCharacters)
  checkItemLevel(100);
if Northrend() or CHECKMISSINGACHIEVEMENTS then
  allNorthrendAchievements()
end

displayAchievement(WORKINGDAYANDNIGHT,includesOtherCharacters)
displayAchievement(PROFESSIONALGRANDMASTER,includesOtherCharacters)
displayAchievement(SKILLSTOPAYTHEBILLS,includesOtherCharacters)
displayAchievement(JUSTLYREWARDED,includesOtherCharacters)
   
--feats for all sorts
displayAchievement(TIMEFLIESWHENYOUREHAVINGFUN,includesOtherCharacters)

displayAchievement(CRITTERGITTER,includesOtherCharacters)

displayAchievement(HEMETNESINGWARYTHECOLLECTEDQUESTS,includesOtherCharacters)
displayAchievement(THOUSANDCONQUESTPOINTS,includesOtherCharacters)
displayAchievement(FIVETHOUSANDHONORABLEKILLS,includesOtherCharacters)

displayAchievement(FRIENDORFOWL,includesOtherCharacters) --northrend

displayAchievement(TRAVELERSTUNDRAMAMMOTH,includesOtherCharacters)
displayAchievement(GETTOTHECHOPPA,includesOtherCharacters)
displayAchievement(RINGOFTHEKIRINTOR,includesOtherCharacters)
displayAchievement(SQUIRRELSWHOSHAREDMYLIFE,includesOtherCharacters) --northrend
displayAchievement(SQUIRRELSWHOCAREDFORME,includesOtherCharacters) -- cata
displayAchievement(ARMOREDBROWNBEAR,includesOtherCharacters)
displayAchievement(WOOLYMAMMOTH,includesOtherCharacters)
displayAchievement(MYSTICALLYSUPERIOR,includesOtherCharacters)
displayAchievement(MYSTICALLYEPIC,includesOtherCharacters)

    AllArenaAchievements(includesOtherCharacters)
displayAchievement(CATACLYSMICALLYSUPERIOR,includesOtherCharacters)
displayAchievement(CATACLYSMICALLYEPIC,includesOtherCharacters)
displayAchievement(NOWIAMTHEMASTER,includesOtherCharacters)
displayAchievement(VIALOFTHESANDS,includesOtherCharacters)

displayAchievement(OFBLOODANDANGUISH,includesOtherCharacters)
displayAchievement(PROFESSIONALILLUSTRIOUSGRANDMASTER,includesOtherCharacters)
displayAchievement(JACKOFALLTRADES,includesOtherCharacters)
displayAchievement(EPIC,includesOtherCharacters)
displayAchievement(SUPERIOR,includesOtherCharacters) -- item level 187.  need wrath gear
   displayAchievement(WGVICTORY)
--add argent tourney here


displayAchievement(GREEDY,includesOtherCharacters)
displayAchievement(NEEDY,includesOtherCharacters)

displayAchievement(DOUBLEAGENT)
displayAchievement(DYNAMICDUO)

--not really needed
  allGeneral()

end


function level80(includesOtherCharacters)
--feats
  displayAchievement(THOUSANDVALORPOINTS,includesOtherCharacters)
displayAchievement(GRANDEXPEDITIONYAK,includesOtherCharacters)

displayAchievement(FIFTEENEXALTED,includesOtherCharacters)
displayAchievement(TENTABARDS,includesOtherCharacters)
displayAchievement(BREAKINGTHESOUNDBARRIER,includesOtherCharacters)
displayAchievement(THEIMMORTAL)
displayAchievement(THEUNDYING)
displayAchievement(GRANDBLACKWARMAMMOTH) --level80

displayAchievement(CHAMPIONOFULDUAR)
displayAchievement(CONQUEROROFULDUAR)
displayAchievement(SCOUREROFTHEETERNALSANDS,includesOtherCharacters)
displayAchievement(DRAGONWRATH,includesOtherCharacters) --level 85
displayAchievement(FANGSOFTHEFATHER,includesOtherCharacters) --85

displayAchievement(MYSACKISGIGANTIQUE,includesOtherCharacters)
displayAchievement(ATRIBUTETODEDICATEDINSANITY)
displayAchievement(ATRIBUTETOIMMORTALITYA)
displayAchievement(ATRIBUTETOIMMORTALITYH)
displayAchievement(ATRIBUTETOINSANITY10)
displayAchievement(ATRIBUTETOINSANITY25)
displayAchievement(ATRIBUTETOMADSKILL10)
displayAchievement(ATRIBUTETOMADSKILL25)
displayAchievement(ATRIBUTETOSKILL10)
displayAchievement(ATRIBUTETOSKILL25)

displayAchievement(THECATACLYSMICGOURMET)
displayAchievement(THEPANDARENGOURMET)
displayAchievement(THELOREMASTER)
displayAchievement(CITYDEFENDER)
displayAchievement(CALLTOARMS)
displayAchievement(WRATHOFTHEHORDE)
displayAchievement(STORMINGSTORMWIND)
displayAchievement(OVERTHROWTHECOUNCIL)
displayAchievement(IMMORTALNOMORE)
displayAchievement(PUTTINGOUTTHELIGHT)
displayAchievement(FORTHEHORDE)
displayAchievement(THECONQUEROR)
displayAchievement(SQUIRRELSIONCECARESSED,includesOtherCharacters) -- panda

displayAchievement(ONEHUMPORTWO)
--cata
if Cataclysm() or CHECKMISSINGACHIEVEMENTS then
  allCataAchievements()
end
  --coming down the mountain
  --
displayAchievement(LEVEL85)
end




function level85()
 displayAchievement(ICANTHEARYOUOVERTHESOUNDOFHOWAWESOMEIAM,includesOtherCharacters)
  displayAchievement(GLORYOFFIRELANDSRAIDER,includesOtherCharacters)
  displayAchievement(GLORYOFDRAGONSOULRAIDER,includesOtherCharacters)
  displayAchievement(TRANQUILMASTER,includesOtherCharacters)

--crazy achs
displayAchievement(INSANEINTHEMEMBRANE)


   displayAchievement(DEADMINES) --as doing too heroic
   displayAchievement(SHADOWFANG) --as doing heroic too
   displayAchievement(CATACLYSMDUNGEONHERO)
  OAFT(GARRISONFOLLOWERSACHS,includesOtherCharacters)
  OAFT(MOUNTACHS,includesOtherCharacters)
end

function getQuestTarget(playerlevel)
  if (playerlevel < 10) then  
    return 1
  elseif (playerlevel >= 10) and (playerlevel < 15) then  
    return 100
  elseif (playerlevel < 25) then  
    return 250
  elseif (playerlevel >= 25) and (playerlevel < 30) then  
    return 400
  elseif (playerlevel >= 30) and (playerlevel < 35) then  
    return 500
  elseif (playerlevel >= 35) and (playerlevel < 40) then  
    return 600
  elseif (playerlevel >= 40) and (playerlevel < 50) then  
    return 700
  elseif (playerlevel >= 50) and (playerlevel < 60) then  
    return 800
  else   -- >= 50
    return 2000
  end
end


--so depending on the value of Seed, we only output a couple of non-essential achievements;should tie in with bg of the day really...
function AchOfTheDay(includesOtherCharacters)
--menu.  

--1generic PVP. 
--2 professions
--3 pets 
--4 archeology
--5cooking
--7 pvp general
--6  first aid
--11 Well Read.  
--10 Squirrels. Pest Control. 
--9 Dailies.  
--8 Gold

--to add
--12
--13
--14

 local playerlevel = UnitLevel("player");

if Seed == 1 then
  if playerlevel > 15 and PVP() then
    OutputAchievementsFromTable(LEVELTENPVPACHIEVEMENTS, includesOtherCharacters,2)
  end
elseif Seed == 2 then
  if includesOtherCharacters then  --only do it once
      checkSecondaryProfessions()
      checkPrimaryProfessions()
   end
 elseif Seed == 3 then
   allPetBattleAchievements(includesOtherCharacters) 
 elseif Seed == 4 then
   archaeologyAchievements(includesOtherCharacters) 
elseif Seed == 14 then
  if playerlevel > 20 and PVP() then
    OutputAchievementsFromTable(SILVERSHARDACHS, includesOtherCharacters,3) 
    OAFT(KOTMOGUACHS, includesOtherCharacters)
  end
elseif Seed == 5 then --cooking
  if playerlevel > 15 then
      displayPartAchievement(TASTESLIKECHICKEN,15)
	  OAFT(COOKINGACHS,includesOtherCharacters)
  end
  if playerlevel > 20 then
     displayPartAchievement(TASTESLIKECHICKEN,25)
  end
  if playerlevel > 50 then
     displayAchievement(TASTESLIKECHICKEN, includesOtherCharacters)
     displayAchievement(ITSHAPPYHOUR,includesOtherCharacters)
  end
elseif Seed == 6 then  
  if playerlevel > 40 then --dont really care about these
        displayAchievement(STOCKINGUP,includesOtherCharacters)
        displayAchievement(PREPARINGFORDISASTER,includesOtherCharacters)
		displayAchievement(ULTIMATETRIAGE,includesOtherCharacters)
  end
elseif Seed == 7 then
  if playerlevel > 20 and PVP() then
    if Alliance() then
      OutputAchievementsFromTable(PVPALLIANCEACHIEVEMENTS, includesOtherCharacters,4)
    else
      OutputAchievementsFromTable(PVPHORDEACHS, includesOtherCharacters,4)
    end
    if includesOtherCharacters then
       HonorableKills(100) 
    end
  end
  if playerlevel > 30 and PVP() and includesOtherCharacters then
     HonorableKills(250)
  end
  if playerlevel > 35 and PVP() and includesOtherCharacters then
    HonorableKills(500)
  end
  if playerlevel > 50 and PVP() and includesOtherCharacters then
    HonorableKills(1000)
  end
elseif Seed == 11 then
  if playerlevel > 25 and includesOtherCharacters then
    displayPartAchievement(WELLREAD,11)
  end
  if playerlevel > 30 and includesOtherCharacters then
    displayPartAchievement(WELLREAD,16)
  end
  if playerlevel > 50 and includesOtherCharacters then
   displayPartAchievement(WELLREAD,21)
  end
  if playerlevel > 60 then
   displayAchievement(WELLREAD,includesOtherCharacters)
  end
  
elseif Seed == 10 then
  if playerlevel > 35 and includesOtherCharacters then
     displayPartAchievement(TOALLTHESQUIRRELSIVELOVED,6)
     displayPartAchievement(PESTCONTROL,5)
  end
  if playerlevel > 40 and includesOtherCharacters then
     displayPartAchievement(TOALLTHESQUIRRELSIVELOVED,9)
     displayPartAchievement(PESTCONTROL,9)
  end
  if playerlevel > 60 and includesOtherCharacters then
--50
   displayAchievement(PESTCONTROL,includesOtherCharacters)
   displayPartAchievement(TOALLTHESQUIRRELSIVELOVED,11)
  end
  if playerlevel > 70 then
   displayAchievement(TOALLTHESQUIRRELSIVELOVED,includesOtherCharacters)
  end


elseif Seed == 9 then
  Quests()
  if playerlevel > 60 then
      displayAchievement(TWOHUNDREDDAILIES,includesOtherCharacters)
  elseif playerlevel > 45 then
     displayPartAchievement(TWOHUNDREDDAILIES,100,includesOtherCharacters)
  end

elseif Seed == 8 then
   if (playerlevel > 45) and includesOtherCharacters then
     Gold(500000)
   end
elseif Seed == 12 then
   OAFT(FISHINGACHS,includesOtherCharacters)
else
    ChatFrame1:AddMessage("no match for seed "..Seed)
  --error message
end
   

if CHECKMISSINGACHIEVEMENTS then -- just do all anyway;NEEDS updating; ok as all pvp are picked up in bg zone check
    OutputAchievementsFromTable(LEVELTENPVPACHIEVEMENTS, includesOtherCharacters)
    OutputAchievementsFromTable(WARSONGGULCHACH, includesOtherCharacters)
    OutputAchievementsFromTable(ARATHIBASINACH, includesOtherCharacters)
    OutputAchievementsFromTable(EOTSACH, includesOtherCharacters)
    OutputAchievementsFromTable(AVACH, includesOtherCharacters)
    OutputAchievementsFromTable(STRANDACHS,includesOtherCharacters)
    OutputAchievementsFromTable(GILNEASACHS, includesOtherCharacters)
    OutputAchievementsFromTable(TWINPEAKSACHS, includesOtherCharacters)
    OutputAchievementsFromTable(SILVERSHARDACHS, includesOtherCharacters) 
    OutputAchievementsFromTable(DEEPWINDGORGEACHS, includesOtherCharacters)
	OAFT(KOTMOGUACHS, includesOtherCharacters)
	OAFT(FISHINGACHS,includesOtherCharacters)
	OAFT(COOKINGACHS,includesOtherCharacters)
	archaeologyAchievements(includesOtherCharacters) 
    IsleOfConquest(includesOtherCharacters) -- 55
    allPetBattleAchievements(includesOtherCharacters) 
    displayPartAchievement(TASTESLIKECHICKEN,25)
    if Alliance() then
      OutputAchievementsFromTable(PVPALLIANCEACHIEVEMENTS)
    else
      OutputAchievementsFromTable(PVPHORDEACHS)
    end
    displayPartAchievement(WELLREAD,16)
     displayPartAchievement(TOALLTHESQUIRRELSIVELOVED,9)
     displayPartAchievement(PESTCONTROL,9)
     Quests()
     displayPartAchievement(TWOHUNDREDDAILIES,100)
     Gold(500000)
end
end



-- output acheivements from table
function OAFT(table,accountwide, lines)

   startcount = outputcounter; --can we see outputcounter?
  if lines == nil then
    lines = 10
  end
  if CHECKMISSINGACHIEVEMENTS then
    lines = 9999
  end
  if table == nil then
    ChatFrame1:AddMessage("OAFT passed nil table")
    return
  end
     -- get player level
  local playerlevel = UnitLevel("player");
  if CHECKMISSINGACHIEVEMENTS then
    playerlevel = 120
  end
  for currachievement,currlevel in pairs(table) do
     -- if table level < player level then display achievement
      if currlevel <= playerlevel then
        displayAchievement(currachievement,accountwide)
        if (outputcounter-startcount) >= lines then
           return
        end
      end 
  end
end
 

function OutputAchievementsFromTable(table, accountwide, lines)
  OAFT(table,accountwide, lines);
end


local MINPERCENT = 90
--achievements close to being hit
function nearlies()
  -- calculate % complete
  -- only output the closest to popping - nearly
  -- that way will already know its coming
  -- random thought - can we just do this for ALL achievements then maybe exclude some...
local idTable = GetCategoryList()


--need a hack for holiday conditions
  -- loop through selected achievements 
  --what about quests in a series - e.g. mind on my money, number of quests etc
  --exclude some as well e.g. holiday, raids etc
  for x,currentcategory in pairs(idTable) do --for each category
    if currentcategory == 155 or currentcategory== 168 or 
	 currentcategory == 14805 or currentcategory==14778 or 
	  currentcategory==14861 or
	 currentcategory == 14777 or currentcategory==160 or 
	 currentcategory == 187 or currentcategory==15069 then
	--skipit - holidays, bc dungeons& raids, vanilla explore
	else
	--this takes too long when gained a new level - crashes
    local numberOfAchs = GetCategoryNumAchievements(currentcategory)
    for i=1,numberOfAchs do
      local id,name = GetAchievementInfo(currentcategory,i)
	     if id == nil then
		 --ChatFrame1:AddMessage("nearlies- cat"..currentcategory.."id=nil")	   get lots so reduce spam
		 else
      --only interested in ones which some progress has been made
  	      criteriarequired = comprehensiveCriteriaRequired(id)
		  criteriacomplete = CriteriaComplete(id) 	
	      if (criteriacomplete > 0 and criteriarequired > 1) and (criteriacomplete < criteriarequired) then 
		     percent = criteriacomplete/criteriarequired *100;
		     if percent > 85 or (((criteriarequired-criteriacomplete) == 1) and criteriarequired > 3) then
		       ChatFrame1:AddMessage(name.." is "..percent.."% complete")
		     end
          end
		 end 
    end
	end
  end
  QuestNearlies()
  DailyQuestNearlies()
  MoneyNearlies()
  HonorableKillsNearlies()
  FishingNearlies()
  ArchaeologyNearlies()
  
 end
  
  function QuestNearlies()
   local target = 0;
  local currenttotal = 0;
  
  MAXACH = 978; --10000 dailies
  
  --what is the current total
  tempstring,temptype,completed,currenttotal,reqQuantity = GetAchievementCriteriaInfo(MAXACH,1)
  
  --what is the next level to hit
    if currenttotal < 50 then
	  target = 50
  elseif currenttotal < 100 then
	  target = 100
  elseif currenttotal < 250 then
	  target = 250
  elseif currenttotal < 500 then
	  target = 500
  elseif currenttotal < 1000 then
	  target = 1000
  elseif currenttotal < 1500 then
	  target = 1500
  elseif currenttotal < 2000 then
	  target = 2000
  elseif currenttotal < 3000 then
	  target = 3000
  else
    return
	end
	  
  
  --output if it meets 80% criteria 
  percent = currenttotal/target*100;
  if percent > MINPERCENT then
  	     ChatFrame1:AddMessage("Quests is "..percent.."% complete")
  end
    
  
  --what is the current total
  --what is the next level to hit
  --output if it meets 80% criteria 
    
  end
  
  
  function DailyQuestNearlies()
  local target = 0;
  local currenttotal = 0;
  
  MAXACH = 7411; --10000 dailies
  
  --what is the current total
  tempstring,temptype,completed,currenttotal,reqQuantity = GetAchievementCriteriaInfo(MAXACH,1)
  
  --what is the next level to hit
  	if currenttotal < 5 then 
	  target = 5
	elseif currenttotal < 50 then
	  target = 50
  elseif currenttotal < 200 then
	  target = 200
  elseif currenttotal < 500 then
	  target = 500
  elseif currenttotal < 1000 then
	  target = 1000
  elseif currenttotal < 2500 then
	  target = 2500
  elseif currenttotal < 5000 then
	  target = 5000
  elseif currenttotal < 10000 then
	  target = 10000  
  else
    return
	end
	  
  
  --output if it meets 80% criteria 
  percent = currenttotal/target*100;
  if percent > MINPERCENT then
  	     ChatFrame1:AddMessage("Daily Quests is "..percent.."% complete")
  end
    
  end
  
  
  function MoneyNearlies()
   local target = 0;
  local currenttotal = 0;
  
  MAXACH = 1178;
  
  --what is the current total
  tempstring,temptype,completed,currenttotal,reqQuantity = GetAchievementCriteriaInfo(MAXACH,1)
  
  --what is the next level to hit
    if currenttotal < 100000 then 
	  target = 100000
	elseif currenttotal < 1000000 then 
	  target = 1000000
	elseif currenttotal < 10000000 then
	  target = 10000000
  elseif currenttotal < 50000000 then
	  target = 50000000
  elseif currenttotal < 100000000 then
	  target = 100000000
  elseif currenttotal < 250000000 then
	  target = 250000000
  elseif currenttotal < 500000000 then
	  target = 500000000
  elseif currenttotal < 1000000000 then
	  target = 1000000000
  elseif currenttotal < 2000000000 then
	  target = 2000000000
  else
    return
	end
	  
  
  --output if it meets 80% criteria 
  percent = currenttotal/target*100;
  if percent > MINPERCENT then
  	     ChatFrame1:AddMessage("Mind on my money is "..percent.."% complete")
  end
    
    
  end
  

  function HonorableKillsNearlies()
   local target = 0;
  local currenttotal = 0;
  
  MAXACH = FIVETHOUSANDHONORABLEKILLS;  -- does this work?
  
  --what is the current total
  tempstring,temptype,completed,currenttotal,reqQuantity = GetAchievementCriteriaInfo(MAXACH,1)
  
  --what is the next level to hit
    if currenttotal < 100 then 
	  target = 100
  elseif currenttotal < 500 then
	  target = 500
  elseif currenttotal < 1000 then
	  target = 1000
  elseif currenttotal < 5000 then
	  target = 5000
  elseif currenttotal < 10000 then
	  target = 10000
  elseif currenttotal < 25000 then
	  target = 25000
  elseif currenttotal < 50000 then
	  target = 50000
  elseif currenttotal < 100000 then
	  target = 100000
  elseif currenttotal < 250000 then
	  target = 250000
	else
    return
	end
	  
  
  --output if it meets 80% criteria 
  percent = currenttotal/target*100;
  if percent > MINPERCENT then
  	     ChatFrame1:AddMessage("Honorable Kills is "..percent.."% complete")
  end
    
	
    
  end
  
  
  --all professions should have this
  function ArchaeologyNearlies() -- might as well abstract out to all? will it screw up achs?
                                -- call sub functions instead 
  local target = 0;
  local currenttotal = 0;
  
  --what is the current total
  currenttotal = getArchaeologySkill();
  --what is the next level to hit
  	if currenttotal < 150 then 
	  target = 150
	elseif currenttotal < 225 then
	  target = 225
  elseif currenttotal < 300 then
	  target = 300
  elseif currenttotal < 375 then
	  target = 375
  elseif currenttotal < 450 then
	  target = 450
  elseif currenttotal < 525 then
	  target = 525
  elseif currenttotal < 600 then
	  target = 600
  elseif currenttotal < 700 then
	  target = 700  
  else
    return
	end
	  
  
  --output if it meets 80% criteria 
  percent = currenttotal/target*100;
  if percent > MINPERCENT then
  	     ChatFrame1:AddMessage("Archaeology is "..percent.."% to next level")
  end
    
  end
  
  
  --all professions should have this
  function FishingNearlies() -- might as well abstract out to all? will it screw up achs?
                                -- call sub functions instead 
  local target = 0;
  local currenttotal = 0;
  
  --what is the current total
  currenttotal = getFishingSkill();
  --what is the next level to hit
  	if currenttotal < 150 then 
	  target = 150
	elseif currenttotal < 225 then
	  target = 225
  elseif currenttotal < 300 then
	  target = 300
  elseif currenttotal < 375 then
	  target = 375
  elseif currenttotal < 450 then
	  target = 450
  elseif currenttotal < 525 then
	  target = 525
  elseif currenttotal < 600 then
	  target = 600
  elseif currenttotal < 700 then
	  target = 700  
  else
    return
	end
	  
  
  --output if it meets 80% criteria 
  percent = currenttotal/target*100;
  if percent > MINPERCENT then
  	     ChatFrame1:AddMessage("Fishing is "..percent.."% to next level")
  end
    
	
  MAXACH = 1561; --1000 fish
  
  --what is the current total
  tempstring,temptype,completed,currenttotal,reqQuantity = GetAchievementCriteriaInfo(MAXACH,1)
  
	
  --what is the current total
  currenttotal = getFishingSkill();
  --what is the next level to hit
  	if currenttotal < 25 then 
	  target = 25
	elseif currenttotal < 50 then
	  target = 50
  elseif currenttotal < 100 then
	  target = 100
  elseif currenttotal < 250 then
	  target = 250
  elseif currenttotal < 500 then
	  target = 500
  elseif currenttotal < 1000 then
	  target = 1000
  else
    return
	end
	  
  --output if it meets 80% criteria 
  percent = currenttotal/target*100;
  if percent > MINPERCENT then
  	     ChatFrame1:AddMessage("Fish caught is "..percent.."% to next level")
  end
    
	
	
  end
  
  
  
  
  
  --all professions should have this
  function FirstAidNearlies() -- might as well abstract out to all? will it screw up achs?
                                -- call sub functions instead 
  local target = 0;
  local currenttotal = 0;
  
  --what is the current total
  currenttotal = getFirstAidSkill();
  --what is the next level to hit
  	if currenttotal < 150 then 
	  target = 150
	elseif currenttotal < 225 then
	  target = 225
  elseif currenttotal < 300 then
	  target = 300
  elseif currenttotal < 375 then
	  target = 375
  elseif currenttotal < 450 then
	  target = 450
  elseif currenttotal < 525 then
	  target = 525
  elseif currenttotal < 600 then
	  target = 600
  elseif currenttotal < 700 then
	  target = 700  
  else
    return
	end
	  
  
  --output if it meets 80% criteria 
  percent = currenttotal/target*100;
  if percent > MINPERCENT then
  	     ChatFrame1:AddMessage("First Aid is "..percent.."% to next level")
  end
    
  end