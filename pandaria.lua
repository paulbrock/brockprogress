
--should char do panda content in full?
function doPandaria()
  if CHECKMISSINGACHIEVEMENTS then
   return true
 end

   local discard, playerclass = UnitClass("player");
   if (playerclass == "WARLOCK") or CHECKMISSINGACHIEVEMENTS then
     return true
   else 
     return false
   end 
end



function PandaAchievements(includesOtherCharacters)

  displayAchievement(LEVEL90,includesOtherCharacters)

  OAFT(PANDARIAACHS,includesOtherCharacters)
  OAFT(PANDARIASCENARIOS,includesOtherCharacters)
  OAFT(PANDARIAREP,includesOtherCharacters)
  displayAchievement(QUEUEINGSPREE, includesOtherCharacters)
if Alliance() then
  OAFT(PANDARIAACHSALLY,includesOtherCharacters)
  OAFT(PANDARIAREPALLY,includesOtherCharacters)
  OAFT(PANDARIAALLYSCENARIOS,includesOtherCharacters)
else
  OAFT(PANDARIAACHSHORDE,includesOtherCharacters)
  OAFT(PANDARIAREPHORDE,includesOtherCharacters)
  OAFT(PANDARIAHORDESCENARIOS,includesOtherCharacters)
end
  displayAchievement(PANDARENCUISINE,includesOtherCharacters)
  displayAchievement(PANDARENDELICACIES,includesOtherCharacters)
  displayAchievement(GLORYOFPANDARIAHERO,includesOtherCharacters)
  displayAchievement(GLORYOFPANDARIARAIDER,includesOtherCharacters)
  displayAchievement(PANDARIADUNGEONHERO,includesOtherCharacters)
  OAFT(TIMELESSISLEACHS,includesOtherCharacters)

end