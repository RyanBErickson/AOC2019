
--[[ Day 7: Amplifiers... ]]

require("TableDumper")

print("---------------- Day 7b ----------------")

-- Zero-based array... Put first value in pos [0] manually... NOTE: Can't ipairs on this correctly...
local INPUT = {
  8,1001,8,10,8,105,1,0,0,21,42,67,88,105,114,195,276,357,438,99999,3,9,101,4,9,9,102,3,9,9,1001,9,2,9,102,4,9,9,4,9,99,3,9,1001,9,4,9,102,4,9,9,101,2,9,9,1002,9,5,9,1001,9,2,9,4,9,99,3,9,1001,9,4,9,1002,9,4,9,101,2,9,9,1002,9,2,9,4,9,99,3,9,101,4,9,9,102,3,9,9,1001,9,5,9,4,9,99,3,9,102,5,9,9,4,9,99,3,9,102,2,9,9,4,9,3,9,101,1,9,9,4,9,3,9,101,2,9,9,4,9,3,9,1001,9,2,9,4,9,3,9,102,2,9,9,4,9,3,9,1002,9,2,9,4,9,3,9,1001,9,1,9,4,9,3,9,102,2,9,9,4,9,3,9,102,2,9,9,4,9,3,9,101,2,9,9,4,9,99,3,9,1002,9,2,9,4,9,3,9,1001,9,2,9,4,9,3,9,102,2,9,9,4,9,3,9,102,2,9,9,4,9,3,9,102,2,9,9,4,9,3,9,102,2,9,9,4,9,3,9,1001,9,1,9,4,9,3,9,101,1,9,9,4,9,3,9,101,1,9,9,4,9,3,9,1002,9,2,9,4,9,99,3,9,102,2,9,9,4,9,3,9,101,1,9,9,4,9,3,9,1002,9,2,9,4,9,3,9,1002,9,2,9,4,9,3,9,1002,9,2,9,4,9,3,9,102,2,9,9,4,9,3,9,101,2,9,9,4,9,3,9,102,2,9,9,4,9,3,9,1001,9,2,9,4,9,3,9,1001,9,1,9,4,9,99,3,9,1002,9,2,9,4,9,3,9,1001,9,1,9,4,9,3,9,101,2,9,9,4,9,3,9,1001,9,1,9,4,9,3,9,101,2,9,9,4,9,3,9,1001,9,1,9,4,9,3,9,102,2,9,9,4,9,3,9,1002,9,2,9,4,9,3,9,1002,9,2,9,4,9,3,9,1001,9,2,9,4,9,99,3,9,1002,9,2,9,4,9,3,9,101,1,9,9,4,9,3,9,1002,9,2,9,4,9,3,9,102,2,9,9,4,9,3,9,1001,9,1,9,4,9,3,9,1002,9,2,9,4,9,3,9,1001,9,1,9,4,9,3,9,101,2,9,9,4,9,3,9,1001,9,1,9,4,9,3,9,1002,9,2,9,4,9,99
}
INPUT[0] = 3

--local INPUT = {52,1001,52,-5,52,3,53,1,52,56,54,1007,54,5,55,1005,55,26,1001,54,5,54,1105,1,12,1,53,54,53,1008,54,0,55,1001,55,1,55,2,53,55,53,4,53,1001,56,-1,56,1005,56,6,99,0,0,0,0,10}
--INPUT[0] = 3

dbg = print

local function Intcode(INPUT, keyinput) -- INPUT, keyinput gets filled on first coroutine.resume
  local pos = 0

  -- Make local copy of input
  local input = {}
  for k,v in pairs(INPUT) do
    input[k] = v
  end

  local modes = {}
  local OUTPUT, POSITIONAL, IMMEDIATE = true, "0", "1"

  local function param(id, bOutput)
    local val = input[pos+id]
    if (bOutput) then return val end

    if (modes[id] == POSITIONAL) then -- Position
      return input[val]
    elseif (modes[id] == IMMEDIATE) then -- Immediate (value)
      return val
    else
      dbg("Invalid Mode: " .. mode)
    end
  end

  local last_output = ""

  repeat

    local _, _, mode3, mode2, mode1, op = (string.format("%05d", input[pos])):find("(%d)(%d)(%d)(%d%d)") -- Decode op...
    modes = {mode1, mode2, mode3}
    op = tonumber(op)

    local len = 0
    if (op == 1) then -- 1 == Addition
      input[param(3, OUTPUT)] = param(1) + param(2)
      len = 4

    elseif (op == 2) then -- 2 == Multiplication
      input[param(3, OUTPUT)] = param(1) * param(2)
      len = 4

    elseif (op == 3) then -- 3 == Input Value, store at X
      local BAD_INPUT = -123456789
      local inp = BAD_INPUT
      local key = table.remove((keyinput or {}), 1)
      if (key) then
        inp = tonumber(key) or BAD_INPUT
      end
      while (inp == BAD_INPUT) do
        io.write("Input: ")
        io.flush()
        inp = tonumber(io.read()) or BAD_INPUT
      end
      input[param(1, OUTPUT)] = inp
      len = 2

    elseif (op == 4) then -- 4 == Output Value, from X
      last_output = param(1)
      keyinput = coroutine.yield(last_output)
      len = 2

    elseif (op == 5) then -- Jump-if-true (param 1 non-zero)
      local val, newpos = param(1), param(2)
      len = 3
      if (val ~= 0) then
        len, pos = 0, newpos
      end

    elseif (op == 6) then -- Jump-if-not-true (param 1 zero)
      local val, newpos = param(1), param(2)
      len = 3
      if (val == 0) then
        len, pos = 0, newpos
      end

    elseif (op == 7) then -- Less Than
      local val1, val2 = param(1), param(2)
      input[param(3, OUTPUT)] = 0
      if (val1 < val2) then
        input[param(3, OUTPUT)] = 1
      end
      len = 4

    elseif (op == 8) then -- Equals
      local val1, val2 = param(1), param(2)
      input[param(3, OUTPUT)] = 0
      if (val1 == val2) then
        input[param(3, OUTPUT)] = 1
      end
      len = 4

    elseif (op == 99) then
      return last_output
    else
      dbg("Invalid opcode: " .. tostring(op))
      len = 10
    end

    pos = pos + len

    until op == 99
end


-- Calculate permutations of input array...  Use as iterator (for p in perm({"a", "b", "c"}) do dump(p) end
-- From PiL 9.3: https://www.lua.org/pil/9.3.html
function perm(a)
  local function permgen (a, n)
    if n == 0 then
      coroutine.yield(a)
    else
      for i = 1, n do
        a[n], a[i] = a[i], a[n] -- put i-th element as the last one
        permgen(a, n - 1)       -- generate all permutations of the other elements
        a[n], a[i] = a[i], a[n] -- restore i-th element
      end
    end
  end

  local co = coroutine.create(function() permgen(a, table.getn(a)) end)
  return function()
    return select(2, coroutine.resume(co))
  end
end

for p in perm{1, 2} do
  print('{' .. p[1] .. ',' .. p[2] .. '}')
end

function Day7b(INPUT)
  local largest = 0
  for p in perm({5,6,7,8,9}) do

    local amplifiers = {}
    for a = 1, 5 do
      amplifiers[a] = coroutine.create(Intcode)
    end

    local status, out = "", 0
    local first = true
    while (status == "suspended") or (status == "") do
      for i = 1, 5 do
        if (first) then
          status, out = coroutine.resume(amplifiers[i], INPUT, {p[i], out})
        else
          status, out = coroutine.resume(amplifiers[i], {out})
        end
      end
      first = false
      status = coroutine.status(amplifiers[1])
    end
    if (out > largest) then largest = out end
  end

  print("max_thruster: " .. largest)
  return largest
end

assert(Day7b(INPUT) == 21844737)

