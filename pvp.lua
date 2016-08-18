



function IsleOfConquest(accountWide)
displayAchievement(ISLEOFCONQUESTVICTORY)
displayAchievement(RESOURCEGLUTH)
displayAchievement(BACKDOORJOB)
displayAchievement(CONQUESTVETERAN)
displayAchievement(CONQUESTALLSTAR)
displayAchievement(MINEH)
displayAchievement(FOURCARGARAGE)
displayAchievement(ABOMBINABLE)
displayAchievement(ABOMBINATION)
displayAchievement(MOWEDDOWN)
displayAchievement(CUTTHEBLUEWIRE)
displayAchievement(ALLOVERTHEISLE)
displayAchievement(DEMOLITIONDERBYH)
displayAchievement(GLAIVEGRAVE)
displayAchievement(MASTERCONQUESTH)
displayAchievement(RESOURCEGLUTA)
displayAchievement(MINEA)
displayAchievement(DEMOLITIONDERBYA)
displayAchievement(MASTERCONQUESTA)
end

function AllWintergraspAchievements()
displayAchievement(BLACKWARMAMMOTH)
displayAchievement(TORAVON10)
displayAchievement(DESTRUCTIONDERBYH)
displayAchievement(DESTRUCTIONDERBYA)
displayAchievement(WINTERGRASPVETERAN)
displayAchievement(WITHINOURGRASP)
displayAchievement(WINTERGRASPRANGER)
displayAchievement(VEHICULARGNOMESLAUGHTER)
displayAchievement(LEANINGTOWER)
displayAchievement(DIDNTSTANDACHANCE)
displayAchievement(ARCHAVON10)
displayAchievement(ARCHAVON25)
displayAchievement(EMALON10)
displayAchievement(EMALON25)
displayAchievement(KORALON10)
displayAchievement(KORALON25)
displayAchievement(TORAVON25)
displayAchievement(MASTEROFWINTERGRASP)
end

function   AllTolBaradAchievements()

displayAchievement(TOLBARADVICTORY)
displayAchievement(JUSTANOTHERDAYINTOLBARADH)
displayAchievement(TOLBARADVETERANH)
displayAchievement(TOWERPLOWER)
displayAchievement(TOWERSOFPOWER)
displayAchievement(TOLBARADSABOTEUR)
displayAchievement(TOLBARADALLSTAR)
displayAchievement(PITLORDARGALOTH)
displayAchievement(OCCUTHAR)
displayAchievement(ALIZABAL)
displayAchievement(MASTEROFTOLBARADH)
displayAchievement(JUSTANOTHERDAYINTOLBARADA)
displayAchievement(TOLBARADVETERANA)
displayAchievement(MASTEROFTOLBARADA)
end

--ALL RANKED MATCHES
function AllArenaAchievements(accountwide)
OutputAchievementsFromTable(ARENAACHS,accountwide)
end

function AllRatedBGAchievements()
displayAchievement(INSERVICEOFTHEHORDE)
displayAchievement(VETERANOFTHEHORDE)
displayAchievement(SCOUT)
displayAchievement(GRUNT)
displayAchievement(SERGEANTH)
displayAchievement(SENIORSERGEANT)
displayAchievement(FIRSTSERGEANT)
displayAchievement(STONEGUARD)
displayAchievement(BLOODGUARD)
displayAchievement(LEGIONNAIRE)
displayAchievement(CENTURION)
displayAchievement(CHAMPION)
displayAchievement(LIEUTENANTGENERAL)
displayAchievement(GENERAL)
displayAchievement(WARLORD)
displayAchievement(HIGHWARLORD)
displayAchievement(HEROOFTHEHORDE)
displayAchievement(INSERVICEOFTHEALLIANCE) --others also
displayAchievement(VETERANOFTHEALLIANCE)--others also
displayAchievement(PRIVATE)
displayAchievement(CORPORAL)
displayAchievement(SERGEANTA)
displayAchievement(MASTERSERGEANT)
displayAchievement(SERGEANTMAJOR)
displayAchievement(KNIGHT)
displayAchievement(KNIGHTLIEUTENANT)
displayAchievement(KNIGHTCAPTAIN)
displayAchievement(KNIGHTCHAMPION)
displayAchievement(LIEUTENANTCOMMANDER)
displayAchievement(COMMANDER)
displayAchievement(MARSHAL)
displayAchievement(FIELDMARSHAL)
displayAchievement(GRANDMARSHAL)
displayAchievement(HEROOFTHEALLIANCE)

end



function inBattleground()
  local isInstance, instanceType = IsInInstance()
 if isInstance and (instanceType == "pvp") then
   BGdailyflag = false;
   return true
 else
   return false
  end

end

--should we show PVP achs right now?
function PVP()

   -- not if in dungeon instance
   inInstance, instancetype = IsInInstance();
   if inInstance then
     return (instancetype ~= "party")
   elseif GetZoneText() == "The Wandering Isle" then 
     return false
   else
     return true
   end

end 
                     -- should really call separate function if possible to make sure up to date...

function BattlegroundUpdateFrame()
  for i=1,2 do -- check once with all characters, once without
    if i==1 then
       includesOtherCharacters=true
    else
       if not AchsCheckingProperly() then
          addLine("character specific Achievements can't be checked")
          return
       end
       includesOtherCharacters=false
    end
    checkPVPHolidays(includesOtherCharacters) --holiday achievements in battlegrounds
    local playerlevel = UnitLevel("player");
    if playerlevel >= 10 then
      if (includesOtherCharacters) then 
        HonorableKills(1)
      end
    end
    if playerlevel >= 15 then
       OutputAchievementsFromTable(LEVELTENPVPACHIEVEMENTS, includesOtherCharacters)
    end

    if playerlevel >= 20 then
      if Alliance() then
         OutputAchievementsFromTable(PVPALLIANCEACHIEVEMENTS)
      else
         OutputAchievementsFromTable(PVPHORDEACHS)
      end
      if (includesOtherCharacters)  then
        HonorableKills(100)
      end
    end
    if playerlevel >= 25 and (includesOtherCharacters) then
      HonorableKills(250)
    end
    if playerlevel >= 35 and (includesOtherCharacters) then
      HonorableKills(500)
    end
   -- get zone name
   -- match zone name to ach
    zoneName = GetZoneText()
    if zoneName == WARSONGGULCH or zoneName == WARSONGGULCH1 then
      OutputAchievementsFromTable(WARSONGGULCHACH, includesOtherCharacters)
    elseif zoneName == ARATHIBASIN then
      OutputAchievementsFromTable(ARATHIBASINACH, includesOtherCharacters)
    elseif zoneName == EOTS then
      OutputAchievementsFromTable(EOTSACH, includesOtherCharacters)
    elseif zoneName == ALTERACVALLEY then
       OutputAchievementsFromTable(AVACH, includesOtherCharacters)
    elseif zoneName == STRANDOFTHEANCIENTS then
       OutputAchievementsFromTable(STRANDACHS, includesOtherCharacters)
    elseif zoneName == DEEPWINDGORGE then
       OutputAchievementsFromTable(DEEPWINDGORGEACHS, includesOtherCharacters)
    elseif zoneName == ISLEOFCONQUEST then
       IsleOfConquest(includesOtherCharacters)
    elseif zoneName == BATTLEFORGILNEAS then
       OutputAchievementsFromTable(GILNEASACHS, includesOtherCharacters)
    elseif zoneName == TWINPEAKS then
       OutputAchievementsFromTable(TWINPEAKSACHS, includesOtherCharacters)
    else
      ChatFrame1:AddMessage("BrockProgress - unknown battleground "..zoneName);
    end
  end
end


--done one battleground today; suggest one but not compulsory
function DailyBattleground()
--check flag.  will be set upon entering a battleground
--if not set, then, draw up a list of eligible battlegrounds
--roll dice and display suggestsed

if BGdailyflag then 
  if UnitLevel("player") > 30 then -- can just do random
    addLine("Daily Battleground:random") --what about arena???
  else
    dailybg = pickRandomBattleground(UnitLevel("player"))
    if dailybg ~= nil then
      addLine("Daily Battleground:"..dailybg.."(or random)")
    else
      addLine("Daily Battleground failed")
    end
   end
end

end


function pickRandomBattleground(playerlevel)
 --need to determine odds per bg, then pick one.  can we do this dynamically? yes
 local BGcount = countavailablebattlegrounds(playerlevel);
 if BGcount == 0 then
   return nil;
 end
 local BGoftheday = math.ceil(Seed * BGcount/MAXSEED); -- this needs to return a number between 1 and (BGcount).
 local count=1;
  for bg, minlevel in pairs (BGMINLEVEL) do
     if minlevel <= playerlevel then
        if count==BGoftheday then
          return bg
        end
        count= count+1;
     end
  end
  ChatFrame1:AddMessage("ERROR BrockProgress:pick daily bg failed")



end

function countavailablebattlegrounds(playerlevel)
  --iterate through BGMINLEVEL and see how many are level or below
local count=0;
  for bg, minlevel in pairs (BGMINLEVEL) do
     if minlevel <= playerlevel then
        count= count+1;
     end
  end
return count;
end