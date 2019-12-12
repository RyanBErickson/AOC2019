
--[[ Day 8: ???... ]]

print("---------------- Day 8 ----------------")

local INPUT
for line in io.lines("input.txt") do
  INPUT = line
end

local TESTA = "123456789012"
local TESTB = "0222112222120000"

function load(input, w, h)
  local layers = {}

  local layer = 1
  local count = 0
  for c in input:gmatch("(.)") do
    layers[layer] = layers[layer] or {}
    table.insert(layers[layer], tonumber(c))
    count = count + 1
    if (count == (w*h)) then
      layer = layer + 1
      count = 0
    end
  end
  return layers
end

local width = 25
local height = 6

local layers = load(INPUT, width, height)

local output = {}
for i = #layers, 1, -1 do
  for j = 1, #layers[i] do
    if (layers[i][j] ~= 2)  then
      output[j] = layers[i][j]
    end
  end
end

VALID = {}
VALID[1] = "███  █  █ ███  ████ █  █ "
VALID[2] = "█  █ █  █ █  █ █    █  █ "
VALID[3] = "█  █ ████ █  █ ███  █  █ "
VALID[4] = "███  █  █ ███  █    █  █ "
VALID[5] = "█    █  █ █    █    █  █ "
VALID[6] = "█    █  █ █    ████  ██  "


for y = 1, height do
  local line = ""
  for x = 1, width do
    if (output[(y - 1) * width + x] == 1) then
      line = line .. "█"
    end
    if (output[(y - 1) * width + x] == 0) then
      line = line .. " "
    end
  end
  assert(line == VALID[y])
  print(line)
end


--[[

-- PART A CRUFT...

local min, minlayer = 20000, 0
for i = 1, #layers do
  count = 0
  for j = 1, #layers[i] do
    if (layers[i][j] == 0) then
      count = count + 1
    end
  end
  print("Layer: " .. i .. " Count 0's: " .. count)
  if (count < (min or count)) then min = count minlayer = i end
end

print("min layer: " .. minlayer)

  local count1, count2 = 0, 0
  for j = 1, #layers[minlayer] do
    if (layers[minlayer][j] == 1) then
      count1 = count1 + 1
    end
    if (layers[minlayer][j] == 2) then
      count2 = count2 + 1
    end
  end
  print("count1: " .. count1 .. " count2: " .. count2 .. " mult: " .. count1 * count2)

]]

