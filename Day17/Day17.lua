
--[[ Day 11: More Intcode  ]]

require("TableDumper")

print("---------------- Day 11 ----------------")

--local INPUT
--for line in io.lines("input.txt") do
  --INPUT = line
--end

local INPUT = {
2,330,331,332,109,3170,1102,1182,1,16,1101,0,1469,24,102,1,0,570,1006,570,36,1002,571,1,0,1001,570,-1,570,1001,24,1,24,1106,0,18,1008,571,0,571,1001,16,1,16,1008,16,1469,570,1006,570,14,21102,1,58,0,1105,1,786,1006,332,62,99,21102,1,333,1,21101,0,73,0,1105,1,579,1101,0,0,572,1102,1,0,573,3,574,101,1,573,573,1007,574,65,570,1005,570,151,107,67,574,570,1005,570,151,1001,574,-64,574,1002,574,-1,574,1001,572,1,572,1007,572,11,570,1006,570,165,101,1182,572,127,1002,574,1,0,3,574,101,1,573,573,1008,574,10,570,1005,570,189,1008,574,44,570,1006,570,158,1106,0,81,21101,340,0,1,1106,0,177,21101,0,477,1,1106,0,177,21102,1,514,1,21102,1,176,0,1106,0,579,99,21101,0,184,0,1106,0,579,4,574,104,10,99,1007,573,22,570,1006,570,165,101,0,572,1182,21102,1,375,1,21101,0,211,0,1106,0,579,21101,1182,11,1,21102,1,222,0,1106,0,979,21102,1,388,1,21101,233,0,0,1105,1,579,21101,1182,22,1,21101,244,0,0,1105,1,979,21101,0,401,1,21102,1,255,0,1106,0,579,21101,1182,33,1,21101,0,266,0,1106,0,979,21102,414,1,1,21101,277,0,0,1106,0,579,3,575,1008,575,89,570,1008,575,121,575,1,575,570,575,3,574,1008,574,10,570,1006,570,291,104,10,21101,1182,0,1,21101,0,313,0,1105,1,622,1005,575,327,1102,1,1,575,21101,0,327,0,1105,1,786,4,438,99,0,1,1,6,77,97,105,110,58,10,33,10,69,120,112,101,99,116,101,100,32,102,117,110,99,116,105,111,110,32,110,97,109,101,32,98,117,116,32,103,111,116,58,32,0,12,70,117,110,99,116,105,111,110,32,65,58,10,12,70,117,110,99,116,105,111,110,32,66,58,10,12,70,117,110,99,116,105,111,110,32,67,58,10,23,67,111,110,116,105,110,117,111,117,115,32,118,105,100,101,111,32,102,101,101,100,63,10,0,37,10,69,120,112,101,99,116,101,100,32,82,44,32,76,44,32,111,114,32,100,105,115,116,97,110,99,101,32,98,117,116,32,103,111,116,58,32,36,10,69,120,112,101,99,116,101,100,32,99,111,109,109,97,32,111,114,32,110,101,119,108,105,110,101,32,98,117,116,32,103,111,116,58,32,43,10,68,101,102,105,110,105,116,105,111,110,115,32,109,97,121,32,98,101,32,97,116,32,109,111,115,116,32,50,48,32,99,104,97,114,97,99,116,101,114,115,33,10,94,62,118,60,0,1,0,-1,-1,0,1,0,0,0,0,0,0,1,8,22,0,109,4,1202,-3,1,587,20102,1,0,-1,22101,1,-3,-3,21101,0,0,-2,2208,-2,-1,570,1005,570,617,2201,-3,-2,609,4,0,21201,-2,1,-2,1105,1,597,109,-4,2106,0,0,109,5,1202,-4,1,630,20102,1,0,-2,22101,1,-4,-4,21101,0,0,-3,2208,-3,-2,570,1005,570,781,2201,-4,-3,653,20101,0,0,-1,1208,-1,-4,570,1005,570,709,1208,-1,-5,570,1005,570,734,1207,-1,0,570,1005,570,759,1206,-1,774,1001,578,562,684,1,0,576,576,1001,578,566,692,1,0,577,577,21101,0,702,0,1106,0,786,21201,-1,-1,-1,1105,1,676,1001,578,1,578,1008,578,4,570,1006,570,724,1001,578,-4,578,21102,1,731,0,1106,0,786,1106,0,774,1001,578,-1,578,1008,578,-1,570,1006,570,749,1001,578,4,578,21102,756,1,0,1106,0,786,1106,0,774,21202,-1,-11,1,22101,1182,1,1,21102,1,774,0,1106,0,622,21201,-3,1,-3,1105,1,640,109,-5,2106,0,0,109,7,1005,575,802,21001,576,0,-6,20101,0,577,-5,1106,0,814,21102,1,0,-1,21102,1,0,-5,21101,0,0,-6,20208,-6,576,-2,208,-5,577,570,22002,570,-2,-2,21202,-5,63,-3,22201,-6,-3,-3,22101,1469,-3,-3,1202,-3,1,843,1005,0,863,21202,-2,42,-4,22101,46,-4,-4,1206,-2,924,21101,0,1,-1,1105,1,924,1205,-2,873,21102,35,1,-4,1105,1,924,2102,1,-3,878,1008,0,1,570,1006,570,916,1001,374,1,374,2101,0,-3,895,1102,2,1,0,1202,-3,1,902,1001,438,0,438,2202,-6,-5,570,1,570,374,570,1,570,438,438,1001,578,558,921,21002,0,1,-4,1006,575,959,204,-4,22101,1,-6,-6,1208,-6,63,570,1006,570,814,104,10,22101,1,-5,-5,1208,-5,27,570,1006,570,810,104,10,1206,-1,974,99,1206,-1,974,1101,0,1,575,21101,0,973,0,1106,0,786,99,109,-7,2106,0,0,109,6,21101,0,0,-4,21101,0,0,-3,203,-2,22101,1,-3,-3,21208,-2,82,-1,1205,-1,1030,21208,-2,76,-1,1205,-1,1037,21207,-2,48,-1,1205,-1,1124,22107,57,-2,-1,1205,-1,1124,21201,-2,-48,-2,1106,0,1041,21101,-4,0,-2,1106,0,1041,21101,-5,0,-2,21201,-4,1,-4,21207,-4,11,-1,1206,-1,1138,2201,-5,-4,1059,2102,1,-2,0,203,-2,22101,1,-3,-3,21207,-2,48,-1,1205,-1,1107,22107,57,-2,-1,1205,-1,1107,21201,-2,-48,-2,2201,-5,-4,1090,20102,10,0,-1,22201,-2,-1,-2,2201,-5,-4,1103,2101,0,-2,0,1105,1,1060,21208,-2,10,-1,1205,-1,1162,21208,-2,44,-1,1206,-1,1131,1106,0,989,21102,1,439,1,1106,0,1150,21101,0,477,1,1106,0,1150,21102,1,514,1,21101,1149,0,0,1106,0,579,99,21102,1,1157,0,1105,1,579,204,-2,104,10,99,21207,-3,22,-1,1206,-1,1138,1201,-5,0,1176,1202,-4,1,0,109,-6,2106,0,0,12,13,50,1,11,1,50,1,1,13,48,1,1,1,9,1,1,1,48,1,1,1,7,7,46,1,1,1,9,1,1,1,1,1,46,1,1,1,9,1,1,1,1,1,23,11,12,1,1,1,9,1,1,1,1,1,23,1,9,1,2,11,1,1,9,1,1,1,1,1,23,1,9,1,2,1,11,1,9,1,1,1,1,1,23,1,9,14,1,1,9,1,1,1,1,1,23,1,9,2,1,1,9,1,1,1,9,1,1,1,1,1,23,1,9,2,1,1,9,1,1,11,1,11,5,11,9,2,1,1,9,1,15,1,7,1,5,1,19,2,1,1,9,1,15,11,1,11,11,2,1,1,9,1,23,1,1,1,1,1,1,1,7,1,11,2,1,1,9,1,23,1,1,1,1,1,1,1,7,1,11,2,1,1,9,1,23,1,1,1,1,1,1,1,7,1,11,2,1,1,9,1,23,1,1,1,1,1,1,1,7,1,1,12,1,1,9,1,23,1,1,1,1,1,1,1,7,1,1,1,10,1,1,11,23,1,1,1,1,1,1,1,7,1,1,1,10,1,35,1,1,1,1,1,1,1,7,1,1,1,10,9,27,7,7,1,1,1,48,1,1,1,9,1,1,1,48,13,1,1,50,1,11,1,50,13,10}


dbg = print

function printgrid(grid, minx, maxx, miny, maxy, lookup)
  lookup = lookup or {}
  local out, tins = {}, table.insert
  for row = miny, maxy do
    local outrow = {}
    grid[row] = grid[row] or {}
    for col = minx, maxx do
      --tins(outrow, (lookup[grid[row][col]] or '.'))
      tins(outrow, grid[row][col])
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
  input[0] = 2 -- partb

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

function Day17(INPUT, keyinput, partb)
  local intcode = coroutine.create(Intcode)

  --local grid, x, y, tile_id, score = {}, nil, nil, nil, 0
  local status = ""
  local retval, out
  local minx, maxx, miny, maxy = 20000, -20000, 20000, -20000

  local grid = {}
  local y = 1
  local x = 1
  minx = 1
  miny = 1
  while (status == "suspended" or status == "") do
    if (status == "") then
      retval, out = coroutine.resume(intcode, INPUT, {})
    else
      retval, out = coroutine.resume(intcode, (nextinput or {0}))
      nextinput = {}
    end

    print(out)
    local mychar = string.char(tonumber(out))
    if (out == 10) then
      y = y + 1
      if (y > maxy) then maxy = y end
      x = 1
    else
      grid[y] = grid[y] or {} 
      grid[y][x] = string.char(tonumber(out))

      if (grid[y][x] == ':') and (grid[y][x-1] == 'n') then
        print("FOUND MAIN!!!")
        -- Solve for intersections
        local alignmenttotal = 0
        for j = 1, maxy do
          for i = 1, maxx do
            if (grid[j][i] == '#') and

              ((grid[j][i-1] or '') == '#') and
              ((grid[j][i+1] or '') == '#') and
              (((grid[j-1] or {})[i] or '') == '#') and
              (((grid[j+1] or {})[i] or '') == '#') then
              alignmenttotal = alignmenttotal + (j-1)*(i-1)
              grid[j][i] = 'O'
            end
          end
        end
        print("TOTAL: " .. alignmenttotal)
      end

      x = x + 1
      if (x > maxx) then maxx = x end

    end


    if (retval == false) then -- pcall error case...
      print(out)
      dbg('exiting...')
      os.exit()
    else
      status = coroutine.status(intcode)
      if (status ~= "dead") then
        printgrid(grid, minx, maxx, miny, maxy)
        --printgrid(grid, 1, 100, 1, 100)
        --print("out: " .. out)
        --[[
        if (x == nil) then
          x = out
        elseif (y == nil) then
          y = out
        else
          if (x == -1) and (y == 0) then
            score = out
            x, y, tile_id = nil, nil, nil
          else
            tile_id = out
            if (tile_id == 2) then
              count = (count or 0) + 1
            end

            -- store color choice, add to count if first color...
            grid[y] = grid[y] or {}
            grid[y][x] = tile_id
            local tile_type = {'wall','block','paddle','ball'} tile_type[0] = 'empty'
            --dbg(tostring(tile_id))
            --dbg("[" .. tostring(x) .. "," .. tostring(y) .. "] " .. tile_type[tile_id] .. " Tile: " .. (count or 0))

            if (tile_id == 3) or (tile_id == 4) then
              if (tile_id == 4) then ballx = x end
              if (tile_id == 3) then paddlex = x end
              if (ballx and paddlex) then
                os.execute('clear')
                printgrid(grid, minmax.minx, minmax.maxx, minmax.miny, minmax.maxy, {[0] = ' ', [1] = '█', [2] = 'B', [3] = '_', [4] = "*" })
                print(ballx, paddlex)
                print("SCORE: " .. score)
                if (ballx > paddlex) then
                  nextinput = {1}
                elseif (ballx < paddlex) then
                  nextinput = {-1}
                else
                  nextinput = {0}
                end
              end
            end

            -- Track min/max for grid printing purposes...
            minmax.track(x,y)
            x, y, tile_id = nil, nil, nil
          end
        end
        ]]
      end
    end
  end
  --print("SCORE: " .. score)
  --printgrid(grid, minmax.minx, minmax.maxx, minmax.miny, minmax.maxy, {[0] = ' ', [1] = '█', [2] = 'B', [3] = '_', [4] = "*" })
end

-- No assertion on this one, since I'd have to capture multiple outs...
--assert(Day9(INPUT, {2}) == 84513)

Day17(INPUT)
--minmax.clear()
--Day11(INPUT, nil, true)

