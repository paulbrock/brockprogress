
function vanillaRep()
displayAchievement(ARGENTDAWN)
displayAchievement(THEYLOVEMEINTHATTUNNEL)
displayAchievement(HYDRAXIANWATERLORDS)
displayAchievement(BROODOFNOZDORMU)
  if Alliance() then
    displayAchievement(WINTERSPRINGFROSTSABER,includesOtherCharacters) --50 min
  else
    displayAchievement(VENOMHIDERAVASAUR,includesOtherCharacters)
  end
    if UnitFactionGroup("player") == "Alliance" then
      displayAchievement(DIPLOMATA,includesOtherCharacters)
    else
      displayAchievement(DIPLOMATH,includesOtherCharacters)
    end
    displayAchievement(ARGENTCHAMPION,includesOtherCharacters) -- vanilla and wrath
    displayAchievement(GUARDIANOFCENARIUS,includesOtherCharacters)  -- bc and vanilla
    displayAchievement(AVASTYEADMIRAL)--requires 55
end


-- only doing vanilla if clothie and below level 80
function CharacterDoingVanilla()
 if IsTrialAccount() or CHECKMISSINGACHIEVEMENTS then
   return true
 end
-- level check disabled for missing achievements check
 if UnitLevel("player") >= 80 and not CHECKMISSINGACHIEVEMENTS then
   return false
 else   
    --get class
   local discard, playerclass = UnitClass("player");
   if (playerclass == "MAGE") or (playerclass == "WARLOCK") or
      (playerclass == "MONK") or CHECKMISSINGACHIEVEMENTS then
     return true
   else 
     return false
   end 
 end
end

         
function OutputVanillaAchievements(includesOtherCharacters)
    if Alliance() or CHECKMISSINGACHIEVEMENTS then                                
    --ChatFrame1:AddMessage("vanilla ally called")
       OutputAchievementsFromTable(EKALLIANCEACHIEVEMENTS, includesOtherCharacters,4)
      OutputAchievementsFromTable(KALIMDORALLIANCEACHIEVEMENTS, includesOtherCharacters,4)
      OutputAchievementsFromTable(EKALLIANCETWO, includesOtherCharacters,4)
      OutputAchievementsFromTable(KALIMDORALLIANCETWO, includesOtherCharacters,4)
                                  
    end
    if Horde() or CHECKMISSINGACHIEVEMENTS then
      --ChatFrame1:AddMessage("vanilla horde called")
      OutputAchievementsFromTable(EKHORDEACHIEVEMENTS, includesOtherCharacters,4)
      OutputAchievementsFromTable(KALIMDORHORDEACHIEVEMENTS, includesOtherCharacters,4)
    end
    OutputAchievementsFromTable(KALIMDOREXPLOREACHIEVEMENTS, includesOtherCharacters,20)
    OutputAchievementsFromTable(KALIMDORNEUTRALACHIEVEMENTS , includesOtherCharacters,20)
    OutputAchievementsFromTable(EKNEUTRALACHIEVEMENTS , includesOtherCharacters,20)
end


function vanillaRaids(includesOtherCharacters)
    displayAchievement(WHYBECAUSEITSRED,includesOtherCharacters)
    displayAchievement(BLACKWINGLAIR,includesOtherCharacters)
    displayAchievement(MOLTENCORE,includesOtherCharacters)
    displayAchievement(AQRUINS,includesOtherCharacters)
    displayAchievement(AQTEMPLE,includesOtherCharacters)
    displayAchievement(CLASSICRAIDER,includesOtherCharacters)
    displayAchievement(SULFURAS,includesOtherCharacters) --60
    displayAchievement(THUNDERFURY,includesOtherCharacters) --60
end

