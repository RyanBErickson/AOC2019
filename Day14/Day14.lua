
--[[ Day 14: Let's Make Some Fuel! ]]

print("---------------- Day 14 ----------------")

require "TableDumper"

local INPUT = {}
for line in io.lines("input.txt") do
  table.insert(INPUT, line)
end


TESTA = {
  "10 ORE => 10 A",
  "1 ORE => 1 B",
  "7 A, 1 B => 1 C",
  "7 A, 1 C => 1 D",
  "7 A, 1 D => 1 E",
  "7 A, 1 E => 1 FUEL",
}

TESTA = {
  "9 ORE => 2 A",
  "8 ORE => 3 B",
  "7 ORE => 5 C",
  "3 A, 4 B => 1 AB",
  "5 B, 7 C => 1 BC",
  "4 C, 1 A => 1 CA",
  "2 AB, 3 BC, 4 CA => 1 FUEL",
}

TESTA = {
  "157 ORE => 5 NZVS",
  "165 ORE => 6 DCFZ",
  "44 XJWVT, 5 KHKGT, 1 QDVJ, 29 NZVS, 9 GPVTF, 48 HKGWZ => 1 FUEL",
  "12 HKGWZ, 1 GPVTF, 8 PSHF => 9 QDVJ",
  "179 ORE => 7 PSHF",
  "177 ORE => 5 HKGWZ",
  "7 DCFZ, 7 PSHF => 2 XJWVT",
  "165 ORE => 2 GPVTF",
  "3 DCFZ, 7 NZVS, 5 HKGWZ, 10 PSHF => 8 KHKGT",
}

TESTA = {
  "2 VPVL, 7 FWMGM, 2 CXFTF, 11 MNCFX => 1 STKFG",
  "17 NVRVD, 3 JNWZP => 8 VPVL",
  "53 STKFG, 6 MNCFX, 46 VJHF, 81 HVMC, 68 CXFTF, 25 GNMV => 1 FUEL",
  "22 VJHF, 37 MNCFX => 5 FWMGM",
  "139 ORE => 4 NVRVD",
  "144 ORE => 7 JNWZP",
  "5 MNCFX, 7 RFSQX, 2 FWMGM, 2 VPVL, 19 CXFTF => 3 HVMC",
  "5 VJHF, 7 MNCFX, 9 VPVL, 37 CXFTF => 6 GNMV",
  "145 ORE => 6 MNCFX",
  "1 NVRVD => 8 CXFTF",
  "1 VJHF, 6 MNCFX => 4 RFSQX",
  "176 ORE => 6 VJHF",
}

--[[
TESTA = {
  "171 ORE => 8 CNZTR",
  "7 ZLQW, 3 BMBT, 9 XCVML, 26 XMNCP, 1 WPTQ, 2 MZWV, 1 RJRHP => 4 PLWSL",
  "114 ORE => 4 BHXH",
  "14 VRPVC => 6 BMBT",
  "6 BHXH, 18 KTJDG, 12 WPTQ, 7 PLWSL, 31 FHTLT, 37 ZDVW => 1 FUEL",
  "6 WPTQ, 2 BMBT, 8 ZLQW, 18 KTJDG, 1 XMNCP, 6 MZWV, 1 RJRHP => 6 FHTLT",
  "15 XDBXC, 2 LTCX, 1 VRPVC => 6 ZLQW",
  "13 WPTQ, 10 LTCX, 3 RJRHP, 14 XMNCP, 2 MZWV, 1 ZLQW => 1 ZDVW",
  "5 BMBT => 4 WPTQ",
  "189 ORE => 9 KTJDG",
  "1 MZWV, 17 XDBXC, 3 XCVML => 2 XMNCP",
  "12 VRPVC, 27 CNZTR => 2 XDBXC",
  "15 KTJDG, 12 BHXH => 5 XCVML",
  "3 BHXH, 2 VRPVC => 7 MZWV",
  "121 ORE => 7 VRPVC",
  "7 XCVML => 6 RJRHP",
  "5 BHXH, 4 VRPVC => 5 LTCX",
}
]]

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

  --print("=================================")
  --dump(reactions)
  --print("=================================")
  return reactions
end

-- Use Available until gone, produce new set of X when needed... (except ORE, which we will count into negatives...)



dbg = print


function MakeComponent(component, number)
  --dbg("MakeComponent(" .. component .. "," .. number .. ")")
  local ore = 0
  
  local reaction = reactions[component]
  local multiplier = math.ceil(number / reaction.produces)
  --print(component .. " multiplier: " .. multiplier .. " number: " .. number)

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
  --dbg(component .. " ore: " .. ore)
  return ore
end


-- PartA
reactions = loadReactions(INPUT)
local ore_used = MakeComponent("FUEL", 1)
print("Part A ore_used: " .. ore_used)


-- PartB
-- Binary Search for solution that is 'fit'...
-- NOTE: Still possibly off-by-one, but I don't have time to fix ATM...

local low = 1
local high = 1000000000
local cur_pos

while (high - low > 2) do
  cur_pos = math.ceil((high - low) / 2) + low
  --print("LOW: " .. low .. " CUR: " .. cur_pos .. " HIGH: " .. high)

  reactions = loadReactions(INPUT)
  local ore_used = MakeComponent("FUEL", cur_pos)
  if (ore_used > 1000000000000) then
    --print("TOO HIGH")
    high = cur_pos
  else
    --print("TOO LOW")
    low = cur_pos
  end
end
print("Part B max fuel produced: " .. cur_pos)

