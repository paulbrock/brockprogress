


function displayArchaeology(target)
  if not DKinStartZone() then
    local currskill= getArchaeologySkill();
    if currskill < target then
      local prof1,prof2,archaeology,fishing,cooking,firstAid=GetProfessions();
      local maxskill = getmaxProfSkill(archaeology);
      if (maxskill - 25) < currskill then
         addLine("Archaeology:"..currskill.."/"..target.. " (train up)");
      else
         addLine("Archaeology:"..currskill.."/"..target);
      end
    end
  end
end

function displayFirstAid(target)
  local currskill= getFirstAidSkill();
  if currskill < target then
    local prof1,prof2,archaeology,fishing,cooking,firstAid=GetProfessions();
    local maxskill = getmaxProfSkill(firstAid);
    if (maxskill - 25) < currskill then
       addLine("First Aid:"..currskill.."/"..target.. " (train up)");
    else
       addLine("First Aid:"..currskill.."/"..target);
    end
  end

end

function getSecondaryTarget(playerlevel)
--can be used for fishing, first aid, cooking as always the same scale
  if (playerlevel < 5) then  
    return 0
  elseif (playerlevel < 8) then  
    return 25
  elseif (playerlevel >= 8) and (playerlevel < 10) then  
    return 50
  elseif (playerlevel >= 10) and (playerlevel < 15) then  
    return 75
  elseif (playerlevel >= 15) and (playerlevel < 25) then  
    return 113
  elseif (playerlevel >= 25) and (playerlevel < 30) then  
    return 150
  elseif (playerlevel >= 30) and (playerlevel < 40) then  
    return 175
  elseif (playerlevel >= 40) and (playerlevel < 45) then  
    return 200
  elseif (playerlevel >= 45) and (playerlevel < 65) then  
    return 300
  elseif (playerlevel >= 65) and (playerlevel < 75) then  
    return 375
  elseif (playerlevel >= 75) and (playerlevel < 80) then  
    return 450
  elseif (playerlevel >= 80) and (playerlevel < 85) then  
    return 525
  elseif (playerlevel >= 85) and (playerlevel < 90) then  
    return 600
  elseif (playerlevel >= 90) and (playerlevel < 92) then  
    return 650
  elseif (playerlevel >= 92) and (playerlevel < 95) then  
    return 700
  else   -- >= 45
    addLine("unknown profession target");
    return 700
  end
end


function getArchaeologyTarget(playerlevel)
 if (playerlevel < 20) then
   return 0
 elseif (playerlevel >= 20) and (playerlevel < 25) then
   return 1
elseif (playerlevel >= 25) and (playerlevel < 30) then
   return 45
elseif (playerlevel >= 30) and (playerlevel < 40) then
   return 90
elseif (playerlevel >= 40) and (playerlevel < 45) then
   return 150
elseif (playerlevel >= 45) and (playerlevel < 50) then
   return 250
elseif (playerlevel >= 50) and (playerlevel < 65) then
   return 300
elseif (playerlevel >= 65) and (playerlevel < 70) then
   return 375
  elseif (playerlevel >= 70) and (playerlevel < 80) then  
    return 450
  elseif (playerlevel >= 80) and (playerlevel < 85) then  
    return 525
  elseif (playerlevel >= 85) and (playerlevel < 90) then  
    return 600
  elseif (playerlevel >= 90) and (playerlevel < 92) then  
    return 650
  elseif (playerlevel >= 92) and (playerlevel < 95) then  
    return 700
 else -- >= 50
    addLine("unknown archy target");
   return 700
 end
end 



function checkSecondaryProfessions()
   if not pandaInStartZone() and not DKinStartZone() then
       local target = getSecondaryTarget(UnitLevel("player") )
       displayFishing(target)
       displayCooking(target)
       displayFirstAid(target)
       target = getArchaeologyTarget(UnitLevel("player"))
       displayArchaeology(target)
   end
end

function checkPrimaryProfessions()
  local target=getSecondaryTarget(UnitLevel("player") )
  displayProfessions(target)
end


function displayFishing(target)
  local currskill= getFishingSkill();
  if currskill < target then
    local prof1,prof2,archaeology,fishing,cooking,firstAid=GetProfessions();
    local maxskill = getmaxProfSkill(fishing);
    if (maxskill - 25) < currskill then
      addLine("Fishing:"..currskill.."/"..target.. " (train up)");
    else
      addLine("Fishing:"..currskill.."/"..target);
    end
  end
end

function displayCooking(target)
  local currskill= getCookingSkill();
  if currskill < target then
    local prof1,prof2,archaeology,fishing,cooking,firstAid=GetProfessions();
    local maxskill = getmaxProfSkill(cooking);
    if (maxskill - 25) < currskill then
       addLine("Cooking:"..currskill.."/"..target.. " (train up)");
    else
       addLine("Cooking:"..currskill.."/"..target);
    end
  end
end


function displayProfessions(target)
local prof1,prof2,archaeology,fishing,cooking,firstAid=GetProfessions();
if prof1 ~= nil then
  local profname, icon, skillLevel = GetProfessionInfo(prof1)
  if (not inBattleground()) and target > skillLevel then
    local maxskill = getmaxProfSkill(prof1);
    if (maxskill - 25) < skillLevel then

      addLine(profname..":"..skillLevel.."/"..target.." (train up)");
    else
      addLine(profname..":"..skillLevel.."/"..target);
    end
  end
end
if prof2 ~= nil then
  local profname, icon, skillLevel = GetProfessionInfo(prof2)
    local maxskill = getmaxProfSkill(prof2);
  if (not inBattleground()) and target > skillLevel then
    if (maxskill - 25) < skillLevel then
      addLine(profname..":"..skillLevel.."/"..target.." (train up)");
    else
      addLine(profname..":"..skillLevel.."/"..target);
    end
  end
end

end

function getArchaeologySkill()
local prof1,prof2,archaeology,fishing,cooking,firstAid=GetProfessions();
return getProfSkill(archaeology);
end


function getFishingSkill()
local prof1,prof2,archaeology,fishing,cooking,firstAid=GetProfessions();
local skill = getProfSkill(fishing);
return skill;
end

function getCookingSkill()
local prof1,prof2,archaeology,fishing,cooking,firstAid=GetProfessions();
return getProfSkill(cooking);
end

function getFirstAidSkill()
local prof1,prof2,archaeology,fishing,cooking,firstAid=GetProfessions();
return getProfSkill(firstAid);
end

function getProfSkill(profindex)
if profindex == nil then
  return 0;
end
name, icon, skillLevel = GetProfessionInfo(profindex)
return skillLevel
end


function getmaxProfSkill(profindex)
if profindex == nil then
  return 0;
end
name, icon, skillLevel, maxskill = GetProfessionInfo(profindex)
return maxskill
end

function archaeologyAchievements(accountWide)
  OAFT(ARCHAEOLOGYACHS,accountWide)
  --maybe do something here on archy level.   maybe even base it entirely on prof level, 
  --or a combo of this and player level
end