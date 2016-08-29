  
function DKinStartZone()
 -- if class == dk and level == 58 then return true
 if UnitClass("player") == "Death Knight" and UnitLevel("player") < 58 then

   return true
 else  
   return false
 end
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

function getQuestTarget(playerlevel)
  if (playerlevel < 10) then  
    return 50
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
        if (outputcounter-startcount) >= lines then
           return
        else
		  displayAchievement(currachievement,accountwide)
		end
      end 
  end
end
 

function OutputAchievementsFromTable(table, accountwide, lines)
  OAFT(table,accountwide, lines);
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
