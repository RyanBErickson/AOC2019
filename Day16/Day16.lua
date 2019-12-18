
--[[ Day 16: ??? ]]

print("---------------- Day 16 ----------------")

require "TableDumper"
memoize = require "memoize"

--local INPUT = {}
--for line in io.lines("input.txt") do
  --table.insert(INPUT, line)
--end


TESTA = "80871224585914546619083218645595"
TESTA = "19617804207202209144916044189917"
TESTA = "69317163492948606335995924319873"



INPUT = "59754835304279095723667830764559994207668723615273907123832849523285892960990393495763064170399328763959561728553125232713663009161639789035331160605704223863754174835946381029543455581717775283582638013183215312822018348826709095340993876483418084566769957325454646682224309983510781204738662326823284208246064957584474684120465225052336374823382738788573365821572559301715471129142028462682986045997614184200503304763967364026464055684787169501819241361777789595715281841253470186857857671012867285957360755646446993278909888646724963166642032217322712337954157163771552371824741783496515778370667935574438315692768492954716331430001072240959235708"


function trim(s)
  if (type(s) ~= "string") then return "" end
  return s:gsub("^%s*(.-)%s*$", "%1") -- Trim Whitespace...
end


function gen_pattern_nocache(num_repeat, num)
  local start_pattern = {0, 1, 0, -1}
  local pattern = {}
  while (#pattern < num) do
    for _, val in pairs(start_pattern) do
      for j = 1, num_repeat do
        table.insert(pattern, val)
      end
    end
  end

  -- Offset by 1
  local first = table.remove(pattern, 1)
  table.insert(pattern, first)
  return pattern
end


--dump(gen_pattern_nocache(2, 30))

gen_pattern = memoize(gen_pattern_nocache)

function Day16(input, phases)

  -- Multiply all inputs, using pattern until done, then take right digit...
  local num_phases = phases
  local output
  for x = 1, num_phases do
    output = {}
    for out_i = 1, #input do
      local pattern = gen_pattern(out_i)
      local total = 0
      local pat_index = 0
      for i = 1, #input do
        pat_index = pat_index + 1
        if (not pattern[pat_index]) then
          pat_index = 1
        end

        local toadd = pattern[pat_index] * input[i]
        total = total + toadd
        --print("add: " .. toadd .. " total: " .. total)
      end
      output[out_i] = tonumber(select(3,string.format('%d', total):find('.*(%d)')))
      --print(total, output[out_i])
    end
    dump(output)
    input = output
  end
  return output
end

function Day16b(input, phases, max_size)

  -- Multiply all inputs, using pattern until done, then take right digit...
  local num_phases = phases
  local output
  for x = 1, num_phases do
    print("phase: " .. x)
    output = {}
    for out_i = 1, #input do
      print(out_i)

      local pattern = gen_pattern_nocache(out_i, #input)
      local total = 0
      --local pat_index = 0
      --print("out_i: " .. out_i)
      for i = out_i, #input do

        --pat_index = pat_index + 1
        --if (not pattern[pat_index]) then
          --pat_index = 1
        --end

        local toadd = pattern[i] * input[i]
        total = total + toadd
        --print(i .. " add: " .. toadd .. " total: " .. total)
      end
      output[out_i] = tonumber(select(3,string.format('%d', total):find('.*(%d)')))
    end
    --dump(output)
    input = output
  end
  return output
end

dbg = print

--Day16({1, 2, 3, 4, 5, 6, 7, 8}, 4)
function load(str, numtimes)
  local out, ins = {}, table.insert
dbg("str: " .. str)
  for i = 1, (numtimes or 1) do
    for n in str:gmatch('(%d)') do
      ins(out, tonumber(n))
    end
  end
  return out
end

--dump(Day16b(load("80871224585914546619083218645595"), 100))
--dump(Day16b(load("19617804207202209144916044189917"), 100))
dump(Day16b(load("69317163492948606335995924319873"), 100))
--Day16(load("19617804207202209144916044189917"), 100)
--dump(Day16b(load("69317163492948606335995924319873"), 100))
--dump(Day16(load(INPUT), 100))

--Day16(load("12345678"), 4)

--[[
local inp = load("03036732577212944063491565474664",10000)
local max_size = #inp + 20

print("loaded... max_size: " .. max_size)
local out = Day16b(inp, 100, max_size)
local offset = 0303673
for i = offset, offset + 8 do
  print(out[i])
end
]]
