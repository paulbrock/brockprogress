--currency types
HONOR = 392
HONORTARGET = 2175
DARKMOONTARGET = 0
DARKMOONTICKETS = 515

function checkDarkmoonTickets()
  if getCurrencyLevel(DARKMOONTICKETS) >= DARKMOONTARGET then
    addLine("spend Darkmoon tickets! Balance:"..getCurrencyLevel(DARKMOONTICKETS))
  end
end


function checkCurrencies()
--only two for now, honor and darkmoon tickets
  if getCurrencyLevel(HONOR) >= HONORTARGET then
    addLine("spend honor! Balance:"..getCurrencyLevel(HONOR))
  end
  --checkDarkmoonTickets()
end

-- CAN ALSO GET WEEKLY CAPS
function getCurrencyLevel(currType)
  name, currentAmount = GetCurrencyInfo(currType);
  return currentAmount;

end