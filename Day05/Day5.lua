
--[[

Day 5: Update Opcode computer...

]]


print("---------------- Day 5 ----------------")


-- Zero-based array... Put first value in pos [0] manually... NOTE: Can't ipairs on this correctly...
INPUT = {
225,1,225,6,6,1100,1,238,225,104,0,1101,65,39,225,2,14,169,224,101,-2340,224,224,4,224,1002,223,8,223,101,7,224,224,1,224,223,223,1001,144,70,224,101,-96,224,224,4,224,1002,223,8,223,1001,224,2,224,1,223,224,223,1101,92,65,225,1102,42,8,225,1002,61,84,224,101,-7728,224,224,4,224,102,8,223,223,1001,224,5,224,1,223,224,223,1102,67,73,224,1001,224,-4891,224,4,224,102,8,223,223,101,4,224,224,1,224,223,223,1102,54,12,225,102,67,114,224,101,-804,224,224,4,224,102,8,223,223,1001,224,3,224,1,224,223,223,1101,19,79,225,1101,62,26,225,101,57,139,224,1001,224,-76,224,4,224,1002,223,8,223,1001,224,2,224,1,224,223,223,1102,60,47,225,1101,20,62,225,1101,47,44,224,1001,224,-91,224,4,224,1002,223,8,223,101,2,224,224,1,224,223,223,1,66,174,224,101,-70,224,224,4,224,102,8,223,223,1001,224,6,224,1,223,224,223,4,223,99,0,0,0,677,0,0,0,0,0,0,0,0,0,0,0,1105,0,99999,1105,227,247,1105,1,99999,1005,227,99999,1005,0,256,1105,1,99999,1106,227,99999,1106,0,265,1105,1,99999,1006,0,99999,1006,227,274,1105,1,99999,1105,1,280,1105,1,99999,1,225,225,225,1101,294,0,0,105,1,0,1105,1,99999,1106,0,300,1105,1,99999,1,225,225,225,1101,314,0,0,106,0,0,1105,1,99999,108,226,226,224,102,2,223,223,1005,224,329,101,1,223,223,1107,226,677,224,1002,223,2,223,1005,224,344,101,1,223,223,8,226,677,224,102,2,223,223,1006,224,359,101,1,223,223,108,677,677,224,1002,223,2,223,1005,224,374,1001,223,1,223,1108,226,677,224,1002,223,2,223,1005,224,389,101,1,223,223,1007,677,677,224,1002,223,2,223,1006,224,404,1001,223,1,223,1108,677,677,224,102,2,223,223,1006,224,419,1001,223,1,223,1008,226,677,224,102,2,223,223,1005,224,434,101,1,223,223,107,677,677,224,102,2,223,223,1006,224,449,1001,223,1,223,1007,226,677,224,102,2,223,223,1005,224,464,101,1,223,223,7,677,226,224,102,2,223,223,1005,224,479,101,1,223,223,1007,226,226,224,102,2,223,223,1005,224,494,101,1,223,223,7,677,677,224,102,2,223,223,1006,224,509,101,1,223,223,1008,677,677,224,1002,223,2,223,1006,224,524,1001,223,1,223,108,226,677,224,1002,223,2,223,1006,224,539,101,1,223,223,8,226,226,224,102,2,223,223,1006,224,554,101,1,223,223,8,677,226,224,102,2,223,223,1005,224,569,1001,223,1,223,1108,677,226,224,1002,223,2,223,1006,224,584,101,1,223,223,1107,677,226,224,1002,223,2,223,1005,224,599,101,1,223,223,107,226,226,224,102,2,223,223,1006,224,614,1001,223,1,223,7,226,677,224,102,2,223,223,1005,224,629,1001,223,1,223,107,677,226,224,1002,223,2,223,1005,224,644,1001,223,1,223,1107,677,677,224,102,2,223,223,1006,224,659,101,1,223,223,1008,226,226,224,1002,223,2,223,1006,224,674,1001,223,1,223,4,223,99,226
}
INPUT[0] = 3

dbg = print

function Day5(input, keyinput)
  local pos = 0

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
      print("Output: " .. last_output)
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
local SAVED_INPUT = {}
for k,v in pairs(INPUT) do SAVED_INPUT[k] = v end

assert(Day5(INPUT, {1}) == 15386262)

for k,v in pairs(SAVED_INPUT) do INPUT[k] = v end -- Reset input...
assert(Day5(INPUT, {5}) == 10376124)

