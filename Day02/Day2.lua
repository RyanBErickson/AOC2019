
--[[

Day 2: Write Opcode computer...

]]


print("---------------- Day 2 ----------------")


-- Read Test A Inputs
TESTA = {1,9,10,3,2,3,11,0,99,30,40,50}

INPUT = {1,12,2,3,1,1,2,3,1,3,4,3,1,5,0,3,2,1,9,19,1,10,19,23,2,9,23,27,1,6,27,31,2,31,9,35,1,5,35,39,1,10,39,43,1,10,43,47,2,13,47,51,1,10,51,55,2,55,10,59,1,9,59,63,2,6,63,67,1,5,67,71,1,71,5,75,1,5,75,79,2,79,13,83,1,83,5,87,2,6,87,91,1,5,91,95,1,95,9,99,1,99,6,103,1,103,13,107,1,107,5,111,2,111,13,115,1,115,6,119,1,6,119,123,2,123,13,127,1,10,127,131,1,131,2,135,1,135,5,0,99,2,14,0,0}

-- Read Test B Inputs
TESTB = {}
table.insert(TESTB, "")

-- Read Real Inputs...
--INPUT = {}
--for line in io.lines("input") do
  --table.insert(INPUT, line)
--end

function dumpit(input)
  local out = {}
  for _, v in ipairs(input) do
    table.insert(out, v)
  end
  print(table.concat(out, ','))
end

function Day2A(input)
  local pos = 1
  local op, val1, val2, out = input[pos], input[pos+1], input[pos+2], input[pos+3]
  while op ~= 99 do
    if (op == 1) then
      local out_val = input[val1+1] + input[val2+1]
      --print(val1+1 .. " (" .. input[val1+1] .. ")" .. " + " .. val2+1 .. " (" .. input[val2+1] .. ")" .. " -> " .. out+1 .. " (" .. out_val .. ")")
      input[out+1] = out_val
      --dumpit(input)
    elseif (op == 2) then
      local out_val = input[val1+1] * input[val2+1]
      --print(val1+1 .. " (" .. input[val1+1] .. ")" .. " * " .. val2+1 .. " (" .. input[val2+1] .. ")" .. " -> " .. out+1 .. " (" .. out_val .. ")")
      input[out+1] = out_val
      --dumpit(input)
    end
    pos = pos + 4
    op, val1, val2, out = input[pos], input[pos+1], input[pos+2], input[pos+3]
  end
  --print("op: " .. op)
  --dumpit(input)
  --print("[1]: " .. input[1])
  return input[1]
end


local inp = {}
-- Test PartA assertions
--Day2A({1,0,0,0,99})
--Day2A({2,3,0,3,99})
--Day2A({2,4,4,5,99,0})
--Day2A({1,1,1,4,99,5,6,0,99})
for k, v in ipairs(INPUT) do inp[k] = v end
assert(Day2A(inp) == 3760627)

-- Test PartB assertions
for i = 0, 99 do
  for j = 0, 99 do
    inp = {}
    for k, v in ipairs(INPUT) do inp[k] = v end
    inp[2] = i
    inp[3] = j
    if (Day2A(inp) == 19690720) then
      print(i * 100 + j)
      os.exit()
    end
  end
end

