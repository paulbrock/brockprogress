--currency types
DARKMOONTARGET = 0
DARKMOONTICKETS = 515

function checkDarkmoonTickets()
  if getCurrencyLevel(DARKMOONTICKETS) >= DARKMOONTARGET then
    addLine("spend Darkmoon tickets! Balance:"..getCurrencyLevel(DARKMOONTICKETS))
  end
end


function checkCurrencies()
--only one for now, darkmoon tickets
  --checkDarkmoonTickets()
end

-- CAN ALSO GET WEEKLY CAPS
function getCurrencyLevel(currType)
  name, currentAmount = GetCurrencyInfo(currType);
  return currentAmount;

end
