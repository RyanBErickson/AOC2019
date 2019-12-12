
--[[

Day 7: Amplifiers...

]]


print("---------------- Day 7 ----------------")


-- Zero-based array... Put first value in pos [0] manually... NOTE: Can't ipairs on this correctly...
INPUT = {
8,1001,8,10,8,105,1,0,0,21,42,67,88,105,114,195,276,357,438,99999,3,9,101,4,9,9,102,3,9,9,1001,9,2,9,102,4,9,9,4,9,99,3,9,1001,9,4,9,102,4,9,9,101,2,9,9,1002,9,5,9,1001,9,2,9,4,9,99,3,9,1001,9,4,9,1002,9,4,9,101,2,9,9,1002,9,2,9,4,9,99,3,9,101,4,9,9,102,3,9,9,1001,9,5,9,4,9,99,3,9,102,5,9,9,4,9,99,3,9,102,2,9,9,4,9,3,9,101,1,9,9,4,9,3,9,101,2,9,9,4,9,3,9,1001,9,2,9,4,9,3,9,102,2,9,9,4,9,3,9,1002,9,2,9,4,9,3,9,1001,9,1,9,4,9,3,9,102,2,9,9,4,9,3,9,102,2,9,9,4,9,3,9,101,2,9,9,4,9,99,3,9,1002,9,2,9,4,9,3,9,1001,9,2,9,4,9,3,9,102,2,9,9,4,9,3,9,102,2,9,9,4,9,3,9,102,2,9,9,4,9,3,9,102,2,9,9,4,9,3,9,1001,9,1,9,4,9,3,9,101,1,9,9,4,9,3,9,101,1,9,9,4,9,3,9,1002,9,2,9,4,9,99,3,9,102,2,9,9,4,9,3,9,101,1,9,9,4,9,3,9,1002,9,2,9,4,9,3,9,1002,9,2,9,4,9,3,9,1002,9,2,9,4,9,3,9,102,2,9,9,4,9,3,9,101,2,9,9,4,9,3,9,102,2,9,9,4,9,3,9,1001,9,2,9,4,9,3,9,1001,9,1,9,4,9,99,3,9,1002,9,2,9,4,9,3,9,1001,9,1,9,4,9,3,9,101,2,9,9,4,9,3,9,1001,9,1,9,4,9,3,9,101,2,9,9,4,9,3,9,1001,9,1,9,4,9,3,9,102,2,9,9,4,9,3,9,1002,9,2,9,4,9,3,9,1002,9,2,9,4,9,3,9,1001,9,2,9,4,9,99,3,9,1002,9,2,9,4,9,3,9,101,1,9,9,4,9,3,9,1002,9,2,9,4,9,3,9,102,2,9,9,4,9,3,9,1001,9,1,9,4,9,3,9,1002,9,2,9,4,9,3,9,1001,9,1,9,4,9,3,9,101,2,9,9,4,9,3,9,1001,9,1,9,4,9,3,9,1002,9,2,9,4,9,99
}

INPUT[0] = 3

gInp = {}

function clear()
  gInp = {}
  for i = 1, 5 do
    gInp[i] = {}
    for k,v in pairs(INPUT) do
      gInp[i][k] = v
    end
  end
end

dbg = print

function Day7(amplifier_id, keyinput)
  local pos = 0

  local input = gInp[amplifier_id]

  local lookup = function(mode, val)
    if (mode == "0") then -- Position
      return input[val]
    elseif (mode == "1") then -- Immediate (value)
      return val
    else
      dbg("Invalid Mode: " .. mode)
    end
  end

  local BAD_VALUE = -123456789
  -- Get First...
  local orig_op = string.format("%05d", input[pos])
  local _, _, mode3, mode2, mode1, op = orig_op:find("(%d)(%d)(%d)(%d%d)") -- Decode op...
  local last_output = ""

  op = tonumber(op)
  while op ~= 99 do

    local len = 0
    if (op == 1) then
      -- 1 == Addition
      local val1, val2, out = lookup(mode1, input[pos + 1]), lookup(mode2, input[pos + 2]), input[pos + 3]
      input[out] = val1 + val2
      len = 4
    elseif (op == 2) then
      -- 2 == Multiplication
      local val1, val2, out = lookup(mode1, input[pos + 1]), lookup(mode2, input[pos + 2]), input[pos + 3]
      input[out] = val1 * val2
      len = 4
    elseif (op == 3) then
      -- 3 == Input Value, store at X
      local out = input[pos + 1]
      local inp = BAD_VALUE
      local key = table.remove((keyinput or {}), 1)
      if (key) then
	      inp = tonumber(key) or BAD_VALUE
      end
	      while (inp == BAD_VALUE) do
		      io.write("Input: ")
		      io.flush()
		      inp = tonumber(io.read()) or BAD_VALUE
	      end
	      input[out] = inp
      len = 2
    elseif (op == 4) then
      -- 4 == Output Value, from X
      last_output = lookup(mode1, input[pos + 1])
      --print("Output: " .. last_output)
      len = 2
    elseif (op == 5) then
      -- Jump-if-true
      local val = lookup(mode1, input[pos + 1])
      local newpos = lookup(mode2, input[pos + 2])
      len = 3
      if (val ~= 0) then
        len = 0
        pos = newpos
      end
    elseif (op == 6) then
      -- Jump-if-not-true
      local val = lookup(mode1, input[pos + 1])
      local newpos = lookup(mode2, input[pos + 2])
      len = 3
      if (val == 0) then
        len = 0
        pos = newpos
      end
    elseif (op == 7) then
      -- Less Than
      local val1, val2, out = lookup(mode1, input[pos + 1]), lookup(mode2, input[pos + 2]), input[pos + 3]
      input[out] = 0
      if (val1 < val2) then
        input[out] = 1
      end
      len = 4
    elseif (op == 8) then
      -- Equals
      local val1, val2, out = lookup(mode1, input[pos + 1]), lookup(mode2, input[pos + 2]), input[pos + 3]
      input[out] = 0
      if (val1 == val2) then
	input[out] = 1
      end
      len = 4
    else
      dbg("Invalid opcode: " .. tostring(op))
      len = 10
    end
    if (len > 0) then
      pos = pos + len
    end

    -- Get Next...
    orig_op = string.format("%05d", input[pos])
    _, _, mode3, mode2, mode1, op = orig_op:find("(%d)(%d)(%d)(%d%d)") -- Decode op...
    op = tonumber(op)
  end
  return last_output
end


-- Save input for multiple runs...
-- Try each combination of 0-4, without repeating using digits...
-- 0 - 1 - 2 - 3 - 4

local pieces = {0, 1, 2, 3, 4}
local largest = 0
function permgen (a, n)
	if n == 0 then
		print(a[1],a[2],a[3],a[4],a[5])
clear()
local out = 0
out = Day7(1, {a[1], out})
out = Day7(2, {a[2], out})
out = Day7(3, {a[3], out})
out = Day7(4, {a[4], out})
out = Day7(5, {a[5], out})
print(out)
if (out > largest) then largest = out end

	else
		for i=1,n do

			-- put i-th element as the last one
			a[n], a[i] = a[i], a[n]

			-- generate all permutations of the other elements
			permgen(a, n - 1)

			-- restore i-th element
			a[n], a[i] = a[i], a[n]

		end
	end
end


permgen({0, 1, 2, 3, 4}, 5)

print("largest: " .. largest)


