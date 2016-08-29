
--should char do cata content in full?
function doCataclysm()
  if CHECKMISSINGACHIEVEMENTS then
   return true
 end

   local discard, playerclass = UnitClass("player");
   if (playerclass == "HUNTER") or (playerclass == "DRUID") or CHECKMISSINGACHIEVEMENTS then
     return true
   else 
     return false
   end 
end



function Cataclysm()
  return doCataclysm()
end


function CataQuests(accountwide)
  OAFT(CATAQUESTS,accountwide)
  if Alliance() then
    OAFT(CATAQUESTSALLY,accountwide)
  else
    OAFT(CATAQUESTSHORDE,accountwide)
  end
end


function allCataAchievements(accountwide)
  OAFT(CATACLYSMACHS,accountwide);
  CataQuests(accountwide)
  
  displayAchievement(CATADUNGEONHERO,includesOtherCharacters)
  displayAchievement(DEFENDEROFSHATTEREDWORLD,includesOtherCharacters)
  displayAchievement(GLORYOFCATAHERO,includesOtherCharacters)
  displayAchievement(GLORYOFCATARAIDER,includesOtherCharacters)
end