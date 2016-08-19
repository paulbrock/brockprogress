CHECKMISSINGACHIEVEMENTS = false;--debugging
MAXSEED = 14;
MAXOUTPUTCOUNTER = 30; --normally 12
MINIMUMLEVELFORMACHECK = 5; -- checking missing achs
Seed = 0;
outputFrame = nil;
outputshown = nil;
BGdailyflag = true;

BrockProgress1 = nil;
BrockProgress2 = nil;
BrockProgress3 = nil;
BrockProgress4 = nil;
BrockProgress5 = nil;
BrockProgress6 = nil;
BrockProgress7 = nil;
BrockProgress8 = nil;
BrockProgress9 = nil;
BrockProgress10 = nil;
BrockProgress11 = nil;
BrockProgress12 = nil;
BrockProgress13 = nil;


STORMWIND = "Stormwind";
ORGRIMMAR = "Orgrimmar";
IRONFORGE = "Ironforge";
GNOMEREGANREP = "Gnomeregan";
DARNASSUS = "Darnassus";
GILNEAS = "Gilneas";
EXODAR = "Exodar";
UNDERCITY = "Undercity";
THUNDERBLUFF = "Thunder Bluff";
SILVERMOON = "Silvermoon City";
TROLL = "Darkspear Trolls";
BILGEWATER = "Bilgewater Cartel";
TUSHUI = "Tushui Pandaren";
HUOJIN = "Huojin Pandaren";

homefaction = {};
homefaction["Human"]= STORMWIND
homefaction["Orc"]= ORGRIMMAR
homefaction["Dwarf"]= IRONFORGE
homefaction["Gnome"]= GNOMEREGANREP
homefaction["Night Elf"]= DARNASSUS
homefaction["Worgen"]= GILNEAS
homefaction["Draenei"]= EXODAR
homefaction["Undead"]= UNDERCITY
homefaction["Tauren"]= THUNDERBLUFF
homefaction["Blood Elf"]= SILVERMOON
homefaction["Troll"]= TROLL
homefaction["Goblin"]= BILGEWATER
homefaction["PandarenA"] = TUSHUI
homefaction["PandarenH"] = HUOJIN


--number is amount to hit,one below wiki
HONORED = 6000;
REVERED = 18000


checkedAchievements = {}

outputcounter = 0;

SLASH_BROCKPROGRESS1 = '/progress';

function SlashCmdList.BROCKPROGRESS(msg,editbox)
  if outputshown then
    ChatFrame1:AddMessage("BrockProgress hide")
    --outputFrame:Hide()
    clearBrockFrame()    
    outputshown=false;
  else
    ChatFrame1:AddMessage("BrockProgress show")
    outputFrame:Show()
    outputshown=true
  end
end

function SetSeedOfTheDay()
  -- do random stuff here. number from 1-13

  Seed = math.random(MAXSEED);
end


function BrockProgress_OnLoad()
    BrockProgressFrame:RegisterEvent("CHAT_MSG_SKILL")
    BrockProgressFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
    BrockProgressFrame:RegisterEvent("ACHIEVEMENT_EARNED")
    BrockProgressFrame:RegisterEvent("PLAYER_LEVEL_UP")
    BrockProgressFrame:RegisterEvent("ZONE_CHANGED")
    SetSeedOfTheDay()
    ChatFrame1:AddMessage("BrockProgress initialised")
    initFrame();
	if CHECKMISSINGACHIEVEMENTS then
      MissingAchievementsCheck();
    end
--initialise box
end


function MissingAchievementsCheck()
--holiday categories
  ChatFrame1:AddMessage("missing achs check")
  local holidaycats = {}
--and vanilla
  holidaycats[81] = true; --feats of strength
  holidaycats[15269] = true; --feats of strength
  holidaycats[15274] = true; --feats of strength
  holidaycats[15234]= true; -- legacy achievements
  holidaycats[15268]= true; -- legacy achievements
  holidaycats[15277]= true; -- legacy achievements
  holidaycats[15278]= true; -- legacy achievements
  
  
  
  holidaycats[15259] = true; -- fashion
  holidaycats[15119] = true; --pet battles
  holidaycats[15118] = true; --pet battles
  holidaycats[96] =true; --quests
  holidaycats[15266] = true; --pvp
  
  
  
--RAIDS
  holidaycats[15068] = true; --cata raids - 62
  holidaycats[15107] = true; --panda raids - 107
holidaycats[14922] = true; --lK raid - 271
  
--also panda stuff I cba with right now 
 
-- tried once already
 holidaycats[170] = true; --cooking? --54
-- holidaycats[96] = true; --quests? --25
 holidaycats[171] = true; --fishing? --55
 holidaycats[172] = true; --fiRSTAID
 holidaycats[95] = true; --pvp 61
 holidaycats[92] = true; --general stuff should already be on
 holidaycats[168]= true; --raid general 34
 holidaycats[15071] = true; --archaeology - lots of panda - 94
  --holidaycats[14941] = true; --argent tournament -35 

--draenor
  holidaycats[169] = true; --professions general -24
  holidaycats[15220] = true; --quests -82

  holidaycats[15238] = true; --garrison buildings -51
  --holidaycats[92] = true; --general 60
  holidaycats[15250] = true; --shipyard -27
  holidaycats[15246] = true; --collections
 
--max level draenor
  holidaycats[15231] = true; --raids - 75
  --holidaycats[15202] = true; --brawlers guild (min level 90) - 19
  holidaycats[15241] = true; --ashran - pvp - 21
  holidaycats[15115] = true; --challenge mode -36
  holidaycats[15222] = true; --proving grounds
  

 --legion
  holidaycats[15254] = true; --dungeons
  holidaycats[15275] = true; --class hall
  holidaycats[15276] = true; --class hall
  holidaycats[15256] = true; --class hall
  holidaycats[15255] = true; --raid
  holidaycats[15258] = true; --reputation
  holidaycats[15252] = true; --quests
  holidaycats[15267] = true; --quests
holidaycats[15257] = true; --explore
holidaycats[97] = true; --explore
holidaycats[11138] = true; --first aid

  
--no point if not at least lvl 60 - is this cos some are hidden? more because
-- lots of checks are level dependent.  shouldn't be for debug
  ChatFrame1:AddMessage("BrockProgress missing ach check start")
  if UnitLevel("player") >= MINIMUMLEVELFORMACHECK then

--iterate through achs and look for missing ones
  local idTable = GetCategoryList()

--need a hack for holiday conditions
  for x,currentcategory in pairs(idTable) do --for each category
    if holidaycats[currentcategory] then
  --do nothing
    else
    local numberOfAchs = GetCategoryNumAchievements(currentcategory)
    for i=1,numberOfAchs do
      local id,name = GetAchievementInfo(currentcategory,i)
	  if id==nil then
	    --ChatFrame1:AddMessage("BrockProgess:achievement no name nil ID missing, category "..currentcategory)
	  elseif not checkedAchievements[id] then
        ChatFrame1:AddMessage("BrockProgess:achievement "..name.." "..id.." missing, category "..currentcategory)
      end
    end
    end
  end
 end

  ChatFrame1:AddMessage("BrockProgress missing ach check finish")
  

end




function initFrame()
    outputFrame = CreateFrame("Frame","BrockProgressFrame",UIParent);
    outputFrame:SetFrameStrata("HIGH");
    outputFrame:SetWidth(128);
    outputFrame:SetHeight(100);
    outputFrame:SetMovable(True);
    outputFrame:SetPoint("CENTER",400,-150);
    BrockProgress1 = outputFrame:CreateFontString();
--    outputFrame:CreateFontString("BrockProgress1");
    BrockProgress1:SetFont("Fonts\\FRIZQT__.TTF", 11);
    BrockProgress1:SetPoint("CENTER",0,0);
    BrockProgress1:SetText("Init");
--    BrockProgress2 = outputFrame:CreateFontString();
    outputFrame:CreateFontString("BrockProgress2");
    BrockProgress2:SetFont("Fonts\\FRIZQT__.TTF", 11);
    BrockProgress2:SetPoint("CENTER",0,-20);
    BrockProgress2:SetText("Init");
    BrockProgress3 = outputFrame:CreateFontString();
--    outputFrame:CreateFontString("BrockProgress3");
    BrockProgress3:SetFont("Fonts\\FRIZQT__.TTF", 11);
    BrockProgress3:SetPoint("CENTER",0,-40);
    BrockProgress3:SetText("Init");
    BrockProgress4 = outputFrame:CreateFontString();
    BrockProgress4:SetFont("Fonts\\FRIZQT__.TTF", 11);
    BrockProgress4:SetPoint("CENTER",0,-60);
    outputFrame:CreateFontString("BrockProgress5");
    BrockProgress5:SetFont("Fonts\\FRIZQT__.TTF", 11);
    BrockProgress5:SetPoint("CENTER",0,-80);
    BrockProgress6 = outputFrame:CreateFontString();
    BrockProgress6:SetFont("Fonts\\FRIZQT__.TTF", 11);
    BrockProgress6:SetPoint("CENTER",0,-100);
    BrockProgress7 = outputFrame:CreateFontString();
    BrockProgress7:SetFont("Fonts\\FRIZQT__.TTF", 11);
    BrockProgress7:SetPoint("CENTER",0,-120);
    BrockProgress8 = outputFrame:CreateFontString();
    BrockProgress8:SetFont("Fonts\\FRIZQT__.TTF", 11);
    BrockProgress8:SetPoint("CENTER",0,-140);
    BrockProgress9 = outputFrame:CreateFontString();
    BrockProgress9:SetFont("Fonts\\FRIZQT__.TTF", 11);
    BrockProgress9:SetPoint("CENTER",0,-160);
    BrockProgress10 = outputFrame:CreateFontString();
    BrockProgress10:SetFont("Fonts\\FRIZQT__.TTF", 11);
    BrockProgress10:SetPoint("CENTER",0,-180);
    BrockProgress11 = outputFrame:CreateFontString();
   BrockProgress11:SetFont("Fonts\\FRIZQT__.TTF", 11);
    BrockProgress11:SetPoint("CENTER",0,-200);
    BrockProgress12 = outputFrame:CreateFontString();
    BrockProgress12:SetFont("Fonts\\FRIZQT__.TTF", 11);
   BrockProgress12:SetPoint("CENTER",0,-220);
    BrockProgress13 = outputFrame:CreateFontString();
    BrockProgress13:SetFont("Fonts\\FRIZQT__.TTF", 11);
   BrockProgress13:SetPoint("CENTER",0,-240);
    outputcounter=0;
    outputshown=false;
end

function clearBrockFrame()
   outputcounter = 0;
   BrockProgress1:SetText(" ")
   BrockProgress2:SetText(" ")
   BrockProgress3:SetText(" ");
   BrockProgress4:SetText(" ")
   BrockProgress5:SetText(" ")
   BrockProgress6:SetText(" ")
   BrockProgress7:SetText(" ")
   BrockProgress8:SetText(" ")
   BrockProgress9:SetText(" ")
   BrockProgress10:SetText(" ")
   BrockProgress11:SetText(" ")
   BrockProgress12:SetText(" ")
   BrockProgress13:SetText(" ")
end


function checkItemLevel(target)
  if target > GetAverageItemLevel() then
     addLine("Item Level:"..floor(GetAverageItemLevel()).."/"..target);
  end
end



function addLine(newtext)
  addLine(newtext, 1,1,1)
end


function addLine(newtext,red,green,blue)
  if outputcounter <= 12 then
    if outputcounter == 0 then
      BrockProgress1:SetText(newtext)
    elseif outputcounter == 1 then
      BrockProgress2:SetText(newtext)
    elseif outputcounter == 2 then
      BrockProgress3:SetText(newtext)
    elseif outputcounter == 3 then
      BrockProgress4:SetText(newtext)
    elseif outputcounter == 4 then
      BrockProgress5:SetText(newtext)
    elseif outputcounter == 5 then
      BrockProgress6:SetText(newtext)
    elseif outputcounter == 6 then
      BrockProgress7:SetText(newtext)
    elseif outputcounter == 7 then
      BrockProgress8:SetText(newtext)
    elseif outputcounter == 8 then
      BrockProgress9:SetText(newtext)
    elseif outputcounter == 9 then
      BrockProgress10:SetText(newtext)
    elseif outputcounter == 10 then
      BrockProgress11:SetText(newtext)
    elseif outputcounter == 11 then
      BrockProgress12:SetText(newtext)
    elseif outputcounter == 12 then
      BrockProgress13:SetText(newtext)
    end
    outputcounter = outputcounter+1
  elseif outputcounter < MAXOUTPUTCOUNTER then
    outputcounter = outputcounter+1
    ChatFrame1:AddMessage(newtext)
 elseif outputcounter == MAXOUTPUTCOUNTER then
   outputcounter = outputcounter+1
   ChatFrame1:AddMessage("...more achievements")
  end
end

function getHomeFaction()
  local race=UnitRace("player");
  if (race == "Pandaren") then
    if Alliance() then 
      race = "PandarenA"
    else  -- bit naughty as doesn't allow for neutral
      race = "PandarenH"
    end
  end
  local factionname = homefaction[race];
--get player race
  if factionname == nil then
    ChatFrame1:AddMessage("BrockProgress:unknown home faction for "..race);
    return nil;
  end
--no way to get number of factions known
  for factionIndex = 1, 100 do
    name, _, _, _, _, _, _, _, isHeader, isCollapsed, hasRep, isWatched, isChild = GetFactionInfo(factionIndex)
    if name==factionname then
      return factionIndex
    end
  end
  ChatFrame1:AddMessage("BrockProgress:can't find faction: "..factionname);
  return nil;
end

function getStartzone()
  local race=UnitRace("player");

  if race=="Human" then
    return ELWYNN
  elseif race=="Orc" or race =="Troll" then 
    return DUROTAR    
  elseif race=="Dwarf" or race == "Gnome" then
    return DUNMOROGH
  elseif race=="Night Elf" then
    return TELDRASSIL
  elseif race=="Worgen" or race=="Goblin" then
    return nil
  elseif race=="Draenei" then
    return AZUREMYST
  elseif race=="Undead" then
    return TIRISFAL
  elseif race=="Tauren" then
    return MULGORE
  elseif race=="Blood Elf" then
    return BESTART
  elseif race=="Pandaren" then
    return nil
  --get player racE
  else
  ChatFrame1:AddMessage("BrockProgress:can't find race: "..race);
     return nil
  end  
end


function BrockProgress_OnEvent(self,event,...)
    if event=="CHAT_MSG_SKILL" or event=="ZONE_CHANGED" or event=="PLAYER_ENTERING_WORLD" or event=="ACHIEVEMENT_EARNED" or event=="PLAYER_LEVEL_UP" then
      updateFrame()
    end
    -- if event=="PLAYER_ENTERING_WORLD" then
	if event=="PLAYER_ENTERING_WORLD" and CHECKMISSINGACHIEVEMENTS then
       MissingAchievementsCheck()
    end
      
end


function AchsCheckingProperly()
local LEVEL10=6;

local ID,Name,Points,Completed,_,_,_,_,_,_,_,_,wasEarnedByMe,earnedby = GetAchievementInfo(LEVEL10);
if UnitLevel("player") < 10 then --cant check yet
  return true
end 
if wasEarnedByMe then
  return true
else 
  return false
end

end

function updateFrame()
  clearBrockFrame()
  --if in battleground, only show pvp ones.  

  if inBattleground() then
    BattlegroundUpdateFrame()
	
  elseif C_PetBattles.IsInBattle() then
	  allPetBattleAchievements(true)	  
  elseif inDungeon() then
    ChatFrame1:AddMessage("BrockProgress-in a dungeon!");
    DungeonUpdateFrame()
  else
    for i=1,2 do -- check once with all characters, once without
      if i==1 then
         includeOtherplayers=true
      else
         if not AchsCheckingProperly() then
            addLine("character specific Achievements can't be checked")
            return
         else
           includeOtherplayers=false
         end
      end
	  
	checkZoneForAchievements(includeOtherplayers)
    local playerlevel = UnitLevel("player");
	--ChatFrame1:AddMessage("BrockProgress-updateframe:calling check holidays");
      checkHolidays(includeOtherplayers,CHECKMISSINGACHIEVEMENTS)
      checkDungeons(includeOtherplayers) --includes other characters achs
	  checkQuests(includeOtherplayers)
      if includeOtherplayers and (playerlevel >= 10) then   -- only check these once
        DailyBattleground()
   --     ChatFrame1:AddMessage("BrockProgress:can't check currencies");
        checkCurrencies()
      end
    AchOfTheDay(includeOtherplayers)
    CMAFlag();
	if CHECKMISSINGACHIEVEMENTS then
      playerlevel = 120
    end
    --ChatFrame1:AddMessage("BrockProgress:levelscheck");
    if playerlevel >= 5 then
      level5(includeOtherplayers);
    end
    if playerlevel >= 10 then
      level10(includeOtherplayers);
    end
    if playerlevel >= 15 then
      level15(includeOtherplayers);
    end
    
    if playerlevel >= 60 then
      level60(includeOtherplayers)
    end
 
    if playerlevel >= 70 then
      level70(includeOtherplayers)
      if playerlevel >= 80 then
       level80(includeOtherplayers)
       AllWintergraspAchievements()
	   --ChatFrame1:AddMessage("BrockProgress:calling rated bg achs");
       AllRatedBGAchievements()
       AllTolBaradAchievements()
      end
      if playerlevel >= 85 then
        level85(includeOtherplayers)
      end
      if playerlevel >= 90 then
        checkDraenorAchievements(includeOtherplayers)
      end
    end 
	--ChatFrame1:AddMessage("BrockProgress:end of levelscheck");
  end -- end of for loop for account widee achs
end
--too slow, and needs refinement
--nearlies()
-- if no achs found, but a message anyway
if outputcounter==0 then
  addLine("No achievements available")
end
end


--only need to do part of an achievement

--if check for all and not earned by any then show
--if check for one and not earned by one then show
--if check for one and not earned by any then don't show!

function displayPartAchievement(achnumber,criteriarequired)
  displayPartAchievement(achnumber,criteriarequired,false);  --50% chance of being right!
end

function displayPartAchievement(achnumber,criteriarequired,includingOtherChars)
  local ID,Name,Points,Completed,_,_,_,_,_,_,_,_,wasEarnedByMe,earnedby = GetAchievementInfo(achnumber);
  if Completed and wasEarnedByMe then 
    return;
  end

  if not Completed and includingOtherChars then -- not by anybody
    return; --only output on one run thru
  end


  criteria = GetAchievementNumCriteria(achnumber);
  Name = GetAchievementLink(achnumber);
  checkedAchievements[achnumber] = true;
  if criteria == 0 then
    addLine(Name) --should never be called
  elseif CriteriaComplete(achnumber) < criteriarequired then
      addLine(Name..":"..CriteriaComplete(achnumber).."/"..criteriarequired);
      if outputcounter < 14 then --no need to do it if already spilled out of box
        ChatFrame1:AddMessage(Name)
      end
  end
end


--so don't have to worry about it expiring
function HonorableKills(target)
  displayPartAchievement(FIVETHOUSANDHONORABLEKILLS,target)
end

function Gold(target)
  displayPartAchievement(GOTMYMINDONMYMONEY5000,target)
end



--displays achievement if not complete
function displayAchievement(achnumber,includingOtherChars)
  if achnumber == 0 or achnumber == nil then
    ChatFrame1:AddMessage("BrockProgress:displayAchievement passed a 0 achnumber")
  end
  checkedAchievements[achnumber] = true;
  local ID,Name,Points,Completed,_,_,_,_,_,_,_,_,wasEarnedByMe,earnedby = GetAchievementInfo(achnumber);

  if Completed and wasEarnedByMe then 
    return;
  end

--probably can't check individual criteria if already gotten.
  if Completed then -- ie on another character
    criteria = 0
  else
    criteria = GetAchievementNumCriteria(achnumber);
  end

  Name = GetAchievementLink(achnumber);
 --debug

  if (Name == nil) then 
     ChatFrame1:AddMessage("no achievement found for achnumber "..achnumber);
     return;
  end

--possibilities.  
--current character completed it (already hit above and returned)
--no character completed it.  should output once for not inc alts, but not for the rest.
--current character not completed it, but alts have. - only output once.  ok

  if (not Completed) and includingOtherChars then -- by anyone, including alts. output for main character only
    if criteria == 1 then -- must be the case that no-one has it
      addLine(Name..":"..CriteriaComplete(achnumber).."/"..CriteriaRequired(achnumber));
    elseif criteria == 0 then
       addLine(Name)
    else
      addLine(Name..":"..CriteriaComplete(achnumber).."/"..criteria);
    end
  end

--otherwise been done on alt.  criteria must be 0.
    if Completed and (not includingOtherChars) then --only output on 2nd run
         addLine(Name.."(completed on alt)")
    end

  --also output achievementlinks in chat for clicking:

  if criteria == 0 and Completed and includingOtherChars then -- no need to output name as no ach displayed
    --do nothing
  elseif outputcounter < 14 then --no need to do it if already spilled out of box; sometimes outputs even if not needed
    ChatFrame1:AddMessage(Name)
  end

 end

--checks how many crtieria of the achievement are complete
function CriteriaComplete(achnumber)
  local numcriteria =GetAchievementNumCriteria(achnumber)
  if numcriteria == 0 then
    return 0
  elseif numcriteria == 1 then
     tempstring,temptype,completed,quantity,reqQuantity = GetAchievementCriteriaInfo(achnumber,1)
     return quantity;
  else
    returnval=0;

    for i=1,numcriteria do
      tempstring,temptype,completed,quantity,reqQuantity = GetAchievementCriteriaInfo(achnumber,i)
      if completed then
        returnval = returnval+1
      end
    end
    return returnval;
    end
end

function CriteriaRequired(achnumber)
     tempstring,temptype,completed,quantity,reqQuantity = GetAchievementCriteriaInfo(achnumber,1)
     return reqQuantity;
end  


function comprehensiveCriteriaRequired(achnumber)
  local numcriteria =GetAchievementNumCriteria(achnumber)
  if numcriteria == 0 then
    return 0
  elseif numcriteria == 1 then
     tempstring,temptype,completed,quantity,reqQuantity = GetAchievementCriteriaInfo(achnumber,1)
     return reqQuantity;
     --this is fine for only one criteron
  else
    return numcriteria;
   end	 
end  

function displayRep(faction,target)
--what is current rep
--display current and target
  if faction ~= nil then
    local name,description,standingId,bottom,top,earnedvalue=GetFactionInfo(faction)
     if target > earnedvalue then
        addLine(name..":"..earnedvalue.."/"..target);
     end
  else
    ChatFrame1:AddMessage("BrockProgress:displayRep passed nil faction"); 
  end
end


function CMAFlag()
  if CHECKMISSINGACHIEVEMENTS == nil then
    ChatFrame1:AddMessage("CMA Flag is nil")
  elseif CHECKMISSINGACHIEVEMENTS then
    ChatFrame1:AddMessage("CMA Flag is true")
  elseif CHECKMISSINGACHIEVEMENTS then
  	ChatFrame1:AddMessage("CMA Flag is neither nil nor true")
  end
end

function checkZoneForAchievements(includeOtherplayers)
    zoneName = GetZoneText()
	if zoneName == DARKMOONFAIREZONE then  
      OAFT(DARKMOONFAIRENEUTRAL,includeOtherplayers)
	elseif zoneName == GORGROND then
	  OAFT(GORGRONDACHS,includeOtherplayers)
	elseif zoneName == AZSHARAZONE then
	  OAFT(AZSHARAACHS,includeOtherplayers)
	elseif zoneName == STORMWINDCITY then
	  OAFT(STORMWINDCITYACHS,includeOtherplayers)
	elseif zoneName == SHADOWMOONVALLEY then
	  OAFT(SHADOWMOONVALLEYACHS,includeOtherplayers)
	elseif zoneName == SPIRESOFARAK then
	  OAFT(SPIRESOFARAKACHS,includeOtherplayers)
	elseif zoneName == EVERBLOOMWILDS then
	  OAFT(EVERBLOOMWILDSACHS,includeOtherplayers)
	elseif zoneName == BOREANTUNDRAZONE then
	  OAFT(BOREANTUNDRAACHS,includeOtherplayers)
	elseif zoneName == TERROKARZONE then
	  OAFT(TERROKARACHS,includeOtherplayers)
	elseif zoneName == DALARANZONE then
	  OAFT(DALARANACHS,includeOtherplayers)
	  --dalaran our daily bread
	else
	ChatFrame1:AddMessage("i'M IN "..zoneName.." why no achievements? :( ");
      -- add cities - cooking and fishing dailies.  add zones - quest and explore achs
	end
	--really we want to map to a 2d array rather than have a stack of if thens
	
	if CHECKMISSINGACHIEVEMENTS then
	--show all
      OAFT(DARKMOONFAIRENEUTRAL,includeOtherplayers)
	  OAFT(GORGRONDACHS,includeOtherplayers)
	  OAFT(AZSHARAACHS,includeOtherplayers)
	  OAFT(STORMWINDCITYACHS,includeOtherplayers)
	  OAFT(SHADOWMOONVALLEYACHS,includeOtherplayers)
	  OAFT(SPIRESOFARAKACHS,includeOtherplayers)
	  OAFT(EVERBLOOMWILDSACHS,includeOtherplayers)
	  OAFT(BOREANTUNDRAACHS,includeOtherplayers)
	  OAFT(TERROKARACHS,includeOtherplayers)
	  OAFT(DALARANACHS,includeOtherplayers)
	end
	end