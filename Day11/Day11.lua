
--[[ Day 11: More Intcode  ]]

require("TableDumper")

print("---------------- Day 11 ----------------")

--local INPUT
--for line in io.lines("input.txt") do
  --INPUT = line
--end

local INPUT = {
3,8,1005,8,314,1106,0,11,0,0,0,104,1,104,0,3,8,1002,8,-1,10,1001,10,1,10,4,10,108,1,8,10,4,10,1002,8,1,28,2,2,16,10,1,1108,7,10,1006,0,10,1,5,14,10,3,8,102,-1,8,10,101,1,10,10,4,10,108,1,8,10,4,10,102,1,8,65,1006,0,59,2,109,1,10,1006,0,51,2,1003,12,10,3,8,102,-1,8,10,1001,10,1,10,4,10,108,1,8,10,4,10,1001,8,0,101,1006,0,34,1,1106,0,10,1,1101,17,10,3,8,102,-1,8,10,101,1,10,10,4,10,1008,8,0,10,4,10,1001,8,0,135,3,8,1002,8,-1,10,101,1,10,10,4,10,108,0,8,10,4,10,1001,8,0,156,3,8,1002,8,-1,10,101,1,10,10,4,10,108,0,8,10,4,10,1001,8,0,178,1,108,19,10,3,8,102,-1,8,10,101,1,10,10,4,10,108,0,8,10,4,10,1002,8,1,204,1,1006,17,10,3,8,102,-1,8,10,101,1,10,10,4,10,108,1,8,10,4,10,102,1,8,230,1006,0,67,1,103,11,10,1,1009,19,10,1,109,10,10,3,8,102,-1,8,10,101,1,10,10,4,10,1008,8,0,10,4,10,101,0,8,268,3,8,102,-1,8,10,101,1,10,10,4,10,1008,8,1,10,4,10,1002,8,1,290,2,108,13,10,101,1,9,9,1007,9,989,10,1005,10,15,99,109,636,104,0,104,1,21101,48210224024,0,1,21101,0,331,0,1105,1,435,21101,0,937264165644,1,21101,0,342,0,1105,1,435,3,10,104,0,104,1,3,10,104,0,104,0,3,10,104,0,104,1,3,10,104,0,104,1,3,10,104,0,104,0,3,10,104,0,104,1,21101,235354025051,0,1,21101,389,0,0,1105,1,435,21102,29166169280,1,1,21102,400,1,0,1105,1,435,3,10,104,0,104,0,3,10,104,0,104,0,21102,709475849060,1,1,21102,1,423,0,1106,0,435,21102,868498428684,1,1,21101,434,0,0,1105,1,435,99,109,2,21201,-1,0,1,21101,0,40,2,21102,1,466,3,21101,456,0,0,1105,1,499,109,-2,2105,1,0,0,1,0,0,1,109,2,3,10,204,-1,1001,461,462,477,4,0,1001,461,1,461,108,4,461,10,1006,10,493,1101,0,0,461,109,-2,2106,0,0,0,109,4,2102,1,-1,498,1207,-3,0,10,1006,10,516,21102,1,0,-3,21201,-3,0,1,21201,-2,0,2,21102,1,1,3,21102,535,1,0,1106,0,540,109,-4,2106,0,0,109,5,1207,-3,1,10,1006,10,563,2207,-4,-2,10,1006,10,563,21202,-4,1,-4,1106,0,631,21201,-4,0,1,21201,-3,-1,2,21202,-2,2,3,21101,582,0,0,1105,1,540,22102,1,1,-4,21102,1,1,-1,2207,-4,-2,10,1006,10,601,21101,0,0,-1,22202,-2,-1,-2,2107,0,-3,10,1006,10,623,22102,1,-1,1,21101,623,0,0,105,1,498,21202,-2,-1,-2,22201,-4,-2,-4,109,-5,2105,1,0
}


dbg = print

function printgrid(grid, minx, maxx, miny, maxy, lookup)
  lookup = lookup or {}
  local out, tins = {}, table.insert
  for row = miny, maxy do
    local outrow = {}
    grid[row] = grid[row] or {}
    for col = minx, maxx do
      tins(outrow, (lookup[grid[row][col]] or '.'))
    end
    tins(out, table.concat(outrow))
  end
  print(table.concat(out, '\n'))
end


local function Intcode(INPUT, keyinput) -- INPUT, keyinput gets filled on first coroutine.resume
  local pos = 0

  -- Make local copy of input
  local input = {}
  for k,v in pairs(INPUT) do
    input[k] = v
  end
  input[0] = table.remove(input, 1)

  local modes = {}
  local OUTPUT, POSITIONAL, IMMEDIATE, RELATIVE = true, "0", "1", "2"
  local relative_base = 0

  -- Out parameter needs to be 'un-dereferenced', to allow to write...  Probably some way to combine these...
  local function out_param(id)
    local val = input[pos+id]

    if (modes[id] == POSITIONAL) then -- Position
      return val
    elseif (modes[id] == RELATIVE) then -- Relative (value)
      return val + relative_base
    else
      dbg("Invalid Mode: " .. modes[id])
    end
  end

  local function param(id)
    local val = input[pos+id]
    if (modes[id] == IMMEDIATE) then return val end

    return(input[out_param(id)] or 0)
  end

  local last_output = ""

  repeat
    local _, _, mode3, mode2, mode1, op = (string.format("%05d", input[pos])):find("(%d)(%d)(%d)(%d%d)") -- Decode op...
    modes = {mode1, mode2, mode3}
    op = tonumber(op)

    local len = 0
    if (op == 1) then -- 1 == Addition
      input[out_param(3)] = param(1) + param(2)
      len = 4

    elseif (op == 2) then -- 2 == Multiplication
      input[out_param(3)] = param(1) * param(2)
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
      input[out_param(1)] = inp
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
      input[out_param(3)] = 0
      if (val1 < val2) then
        input[out_param(3)] = 1
      end
      len = 4

    elseif (op == 8) then -- Equals
      local val1, val2 = param(1), param(2)
      input[out_param(3)] = 0
      if (val1 == val2) then
        input[out_param(3)] = 1
      end
      len = 4
    elseif (op == 9) then -- 9 == Adjust Relative Base
      relative_base_delta = param(1)
      relative_base = relative_base + relative_base_delta
      -- Do something with relative base...
      len = 2
    elseif (op == 99) then
      return last_output
    else
      dbg("Invalid opcode: " .. tostring(op))
      len = 10
    end

    pos = pos + len

    until op == 99
end


minmax = {
  minx, maxx, miny, maxy,

  track = function(x,y)
    minmax.maxx = minmax.maxx or -math.huge
    if (x > minmax.maxx) then minmax.maxx = x end
    minmax.minx = minmax.minx or math.huge
    if (x < minmax.minx) then minmax.minx = x end
    minmax.maxy = minmax.maxy or -math.huge
    if (y > minmax.maxy) then minmax.maxy = y end
    minmax.miny = minmax.miny or math.huge
    if (y < minmax.miny) then minmax.miny = y end
  end,

  clear = function()
    minmax.maxx = -math.huge
    minmax.minx = math.huge
    minmax.maxy = -math.huge
    minmax.miny = math.huge
  end
}

minmax.clear()

function Day11(INPUT, keyinput, partb)
  local intcode = coroutine.create(Intcode)

  local grid, x, y, direction = {}, 1, 1, 'U'
  local status = ""
  local retval, out
  local minx, maxx, miny, maxy = 20000, -20000, 20000, -20000

  painted_count = 0

  grid[y] = grid[y] or {}
  if (partb) then grid[y][x] = 1 end

  local color = grid[y][x] or 0  -- black
  local nextinput = {}  
  local nextcolor = nil
  local rotation = nil

  while (status == "suspended" or status == "") do
    if (status == "") then
      retval, out = coroutine.resume(intcode, INPUT, {color})
    else
      retval, out = coroutine.resume(intcode, nextinput)
      nextinput = {}
    end

    if (retval == false) then -- pcall error case...
      print(out)
      dbg('exiting...')
      os.exit()
    else
      status = coroutine.status(intcode)
      if (status ~= "dead") then
        if (nextcolor == nil) then
          nextcolor = out
        elseif (rotation == nil) then
          rotation = out

          -- store color choice, add to count if first color...
          grid[y] = grid[y] or {}
          if (grid[y][x] == nil) then
            painted_count = painted_count + 1
          end

          -- Paint it...
          grid[y][x] = nextcolor

          -- calculate rotation and next x,y
          Directions = { [0] = {U = 'L', L = 'D', D = 'R', R = 'U'}, [1] = {U = 'R', R = 'D', D = 'L', L = 'U'},
                         MVMT = {U = {0, -1}, D = {0, 1}, L = {-1, 0}, R = {1, 0}} }
          direction = Directions[rotation][direction]
          local chg = Directions.MVMT[direction]
          x = x + chg[1]
          y = y + chg[2]

          -- Track min/max for grid printing purposes...
          minmax.track(x,y)

          -- read color at location, store for next input...
          nextinput = { (grid[y] or {})[x] or 0 }
          nextcolor = nil
          rotation = nil
        end
      end
    end
  end
  if (not partb) then
    print(painted_count .. " Painted Squares.")
  else
    printgrid(grid, minmax.minx, minmax.maxx, minmax.miny, minmax.maxy, {[0] = ' ', [1] = '█' })
  end
end

-- No assertion on this one, since I'd have to capture multiple outs...
--assert(Day9(INPUT, {2}) == 84513)

Day11(INPUT)
minmax.clear()
Day11(INPUT, nil, true)

