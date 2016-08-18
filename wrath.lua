

function AllArgentTournamentAchievements()
displayAchievement(ARGENTVALOR)
displayAchievement(TILTED)
displayAchievement(LANCEALOT)
displayAchievement(ITSJUSTAFLESHWOUND)
displayAchievement(PONYUP)
displayAchievement(CHAMPIONOFORGRIMMAR)
displayAchievement(CHAMPIONOFSENJIN)
displayAchievement(CHAMPIONOFSILVERMOON)
displayAchievement(CHAMPIONOFTB)
displayAchievement(CHAMPIONOFUNDERCITY)
displayAchievement(CHAMPIONOFTHEHORDE)
displayAchievement(CHAMPIONOFTHEALLIANCE)
displayAchievement(SUNREAVERS)
displayAchievement(SWORDINTHESKULL)
displayAchievement(CHAMPIONOFDARNASSUS)
displayAchievement(CHAMPIONOFEXODAR)
displayAchievement(CHAMPIONOFGNOMEREGAN)
displayAchievement(CHAMPIONOFIRONFORGE)
displayAchievement(CHAMPIONOFSTORMWIND)
displayAchievement(ASILVERCONFIDANT)
end



function wrathRep(accountwide)
--wrath rep
displayAchievement(ARGENTCRUSADE,accountwide)
displayAchievement(WINDSOFTHENORTHH,accountwide)
displayAchievement(WINDSOFTHENORTHA,accountwide)
displayAchievement(KIRINTOR,accountwide)
displayAchievement(WYRMRESTACCORD,accountwide)
displayAchievement(TUSKARRMAGEDDON,accountwide)
displayAchievement(FRENZYHEARTTRIBE,accountwide)
displayAchievement(THEORACLES,accountwide)
displayAchievement(MERCENARYOFSHOLAZAR,accountwide)
displayAchievement(KNIGHTSOFTHEEBONBLADE,accountwide)
displayAchievement(NORTHRENDVANGUARD,accountwide)
displayAchievement(ICEMAMMOTH,accountwide)
displayAchievement(GRANDICEMAMMOTH,accountwide)
displayAchievement(ASHENVERDICT,accountwide)
end



function allNorthrendAchievements(accountwide)
--quests
--exploration
--dungeons
--rep
--cooking dailies
--fishing dailies
--archaeology?
     AllArgentTournamentAchievements()
OutputAchievementsFromTable(WRATHQUESTS, accountwide, 5)
wrathRep(accountwide)
displayAchievement(HIGHERLEARNING,accountwide)
NorthrendRaiding(accountwide) 
OutputAchievementsFromTable(WRATHRAIDS, accountwide)
  displayAchievement(ARGENTCHAMPION,accountwide) -- vanilla and wrath
  displayAchievement(OURDAILYBREADA,accountwide)
  displayAchievement(OURDAILYBREADH,accountwide)
  displayAchievement(ANDILLFORMTHEHEAD,accountwide)
  displayAchievement(HERALDOFTHETITANS,accountwide)
  displayAchievement(INVINCIBLESREINS,accountwide)


end


--SHOULD CHARACTER DO NORTHREND?
function Northrend()
    --get class
 if CHECKMISSINGACHIEVEMENTS then
   return true
 end

   local discard, playerclass = UnitClass("player");
   if (playerclass == "PALADIN") or (playerclass == "DEATHKNIGHT") or
      (playerclass == "WARRIOR") or CHECKMISSINGACHIEVEMENTS then
     return true
   else 
     return false
   end 
end


function NorthrendRaiding(includesOtherCharacters)
  displayAchievement(SHADOWMOURNE,includesOtherCharacters) --80
  displayAchievement(VALANYR,includesOtherCharacters) --80

  displayAchievement(HEFEEDSONYOURTEARS10,includesOtherCharacters)
  displayAchievement(HEFEEDSONYOURTEARS25,includesOtherCharacters)

  displayAchievement(GRIZZLEDVETERAN,includesOtherCharacters)
  displayAchievement(GLORYOFTHERAIDER10,includesOtherCharacters)
  displayAchievement(GLORYOFTHERAIDER25,includesOtherCharacters)
  displayAchievement(GLORYOFULDUARRAIDER10,includesOtherCharacters)
  displayAchievement(GLORYOFULDUARRAIDER25,includesOtherCharacters)
  displayAchievement(GLORYOFICECROWNRAIDER10,includesOtherCharacters)
  displayAchievement(GLORYOFICECROWNRAIDER25,includesOtherCharacters)
  displayAchievement(CHAMPIONOFTHEFROZENWASTES,includesOtherCharacters)
  displayAchievement(THENORTHRENDGOURMET,includesOtherCharacters)

end
