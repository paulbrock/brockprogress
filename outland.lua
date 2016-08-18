


--which chars will do outlands.  
function CharacterDoingOutlands()
 if CHECKMISSINGACHIEVEMENTS then
   return true
 end
 if UnitLevel("player") >= 71 then
   return false
 else   
    --get class
   local discard, playerclass = UnitClass("player");
   if (playerclass == "SHAMAN") or
      (playerclass == "PALADIN") or CHECKMISSINGACHIEVEMENTS then
     return true
   else 
     return false
   end 
 end
end
