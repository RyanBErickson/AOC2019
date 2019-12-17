
--[[ Day 14: Let's Make Some Fuel! ]]

print("---------------- Day 14 ----------------")

require "TableDumper"

local INPUT = {}
for line in io.lines("input.txt") do
  table.insert(INPUT, line)
end


TESTA = {
}


function trim(s)
  if (type(s) ~= "string") then return "" end
  return s:gsub("^%s*(.-)%s*$", "%1") -- Trim Whitespace...
end


function loadReactions(input)
  local reactions = {}

  for _, v in pairs(input) do
    --print("v: " .. v)
    local _, _, inputs, output = v:find("(.-)=>(.+)")
    inputs = trim(inputs)
    output = trim(output)
    
    -- Parse number / type..
    --print("Inputs:" .. inputs)
    --print("Outputs:" .. output)
    local _, _, number, out_type = output:find("(%d+) (.+)")
    --print("Output: " .. out_type .. " (" .. number .. ")")
    reactions[out_type] = {}
    reactions[out_type].produces = tonumber(number) or -1
    reactions[out_type].inventory = 0
    reactions[out_type].requires = {}

    -- Parse inputs
    inputs = inputs .. ','
    for inp in inputs:gfind("(.-),") do
      inp = trim(inp)
      --print("Input: " .. inp)
      local _, _, number, in_type = inp:find("(%d+) (.+)")
      --print("Input: " .. in_type .. " (" .. number .. ")")
      reactions[out_type].requires[in_type] = tonumber(number) or -1
    end
  end

  print("=================================")
  dump(reactions)
  print("=================================")
  return reactions
end

-- Use Available until gone, produce new set of X when needed... (except ORE, which we will count into negatives...)



dbg = print


function MakeComponent(component, number)
  dbg("MakeComponent(" .. component .. "," .. number .. ")")
  local ore = 0
  
  local reaction = reactions[component]
  local multiplier = math.ceil(number / reaction.produces)
  print(component .. " multiplier: " .. multiplier .. " number: " .. number)

  for needed, count in pairs(reaction.requires) do
    --dbg("needed: " .. needed .. " count: " .. count)
    if (needed == "ORE") then
      ore = ore + (multiplier * count)
    else
      if (reactions[needed].inventory < (multiplier * count)) then
        ore = ore + MakeComponent(needed, (multiplier * count) - reactions[needed].inventory)
      end
      reactions[needed].inventory = reactions[needed].inventory - (multiplier * count)
    end
  end
  if (component ~= "ORE") then
    reactions[component].inventory = reactions[component].inventory + (multiplier * reaction.produces)
  end
  dbg(component .. " ore: " .. ore)
  return ore
end

--MakeComponent("FUEL", 1)
--dump(reactions)
--print(ORE_COUNT)

--reactions = loadReactions(TESTA)

-- Manual search for right amount...
reactions = loadReactions(INPUT)
local ore_used = MakeComponent("FUEL", 3209254)
if (ore_used > 1000000000000) then
  print("TOO MUCH")
else
  print("TOO LITTLE")
end

