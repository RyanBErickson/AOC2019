
--[[ Day 15: More Intcode???  ]]

-- NOTE: You're going to scratch your head at this one.
--   I never got my path finding functionality to work, I divined the map via random paths until it finished mapping... :)

require("TableDumper")

print("---------------- Day 15 ----------------")

--local INPUT
--for line in io.lines("input.txt") do
  --INPUT = line
--end

local INPUT = {

  3,1033,1008,1033,1,1032,1005,1032,31,1008,1033,2,1032,1005,1032,58,1008,1033,3,1032,1005,1032,81,1008,1033,4,1032,1005,1032,104,99,101,0,1034,1039,1001,1036,0,1041,1001,1035,-1,1040,1008,1038,0,1043,102,-1,1043,1032,1,1037,1032,1042,1106,0,124,101,0,1034,1039,101,0,1036,1041,1001,1035,1,1040,1008,1038,0,1043,1,1037,1038,1042,1105,1,124,1001,1034,-1,1039,1008,1036,0,1041,1002,1035,1,1040,1001,1038,0,1043,1002,1037,1,1042,1106,0,124,1001,1034,1,1039,1008,1036,0,1041,102,1,1035,1040,1001,1038,0,1043,102,1,1037,1042,1006,1039,217,1006,1040,217,1008,1039,40,1032,1005,1032,217,1008,1040,40,1032,1005,1032,217,1008,1039,39,1032,1006,1032,165,1008,1040,39,1032,1006,1032,165,1101,2,0,1044,1106,0,224,2,1041,1043,1032,1006,1032,179,1102,1,1,1044,1106,0,224,1,1041,1043,1032,1006,1032,217,1,1042,1043,1032,1001,1032,-1,1032,1002,1032,39,1032,1,1032,1039,1032,101,-1,1032,1032,101,252,1032,211,1007,0,59,1044,1106,0,224,1101,0,0,1044,1106,0,224,1006,1044,247,101,0,1039,1034,1001,1040,0,1035,1002,1041,1,1036,102,1,1043,1038,101,0,1042,1037,4,1044,1105,1,0,33,20,19,43,28,91,62,55,96,28,52,9,24,99,11,45,80,58,96,2,8,76,1,37,5,95,18,6,97,67,47,4,19,29,74,57,45,65,17,43,93,33,71,93,26,2,86,11,31,74,85,36,94,20,89,68,45,99,43,21,3,92,69,95,8,30,84,45,10,64,95,49,60,60,45,30,94,36,17,97,90,39,4,97,76,28,80,92,5,66,20,69,95,43,95,35,30,67,67,87,36,44,11,83,62,73,42,80,20,99,79,46,1,75,85,24,5,84,47,78,91,91,38,74,16,31,96,37,60,69,12,96,2,5,83,24,67,42,7,67,94,77,34,6,75,2,61,37,15,11,65,13,63,39,42,93,22,12,89,58,98,28,69,13,98,68,34,13,93,56,85,28,92,45,84,79,70,12,27,85,1,86,94,57,64,30,75,78,49,91,19,94,77,34,40,15,64,26,34,31,70,65,34,65,7,73,61,8,23,82,55,78,36,93,10,29,64,42,99,34,91,17,33,98,45,44,74,98,60,76,6,44,73,11,13,11,73,92,55,90,3,54,23,75,28,36,82,89,84,6,39,31,39,98,34,61,21,93,48,71,80,7,46,76,71,17,7,91,6,22,76,70,27,98,35,29,69,93,42,81,62,46,87,47,51,66,2,60,3,76,68,68,74,70,3,89,18,2,57,74,79,97,16,5,73,19,90,49,6,41,88,83,34,63,52,84,14,19,76,78,88,19,92,90,34,16,69,45,85,30,71,16,77,30,43,65,85,66,11,2,72,3,83,84,14,86,90,74,79,35,33,29,78,9,92,35,64,32,30,66,9,65,30,85,81,44,95,41,22,16,28,75,63,72,23,5,73,24,89,80,25,40,88,62,3,68,6,80,6,39,17,76,24,78,6,90,79,38,44,78,85,29,48,25,75,27,76,92,19,93,21,61,56,13,64,92,52,77,12,33,77,41,75,86,29,34,65,38,66,17,15,95,50,87,52,64,72,73,6,26,80,71,8,86,1,23,67,10,72,89,9,95,60,20,46,64,99,34,46,65,14,54,93,84,4,13,86,12,26,68,56,33,83,12,93,42,74,9,99,62,22,20,83,75,13,71,96,53,96,41,8,15,76,97,55,8,78,85,57,79,30,87,17,46,62,85,14,70,63,82,28,46,96,35,89,6,9,27,44,86,93,28,9,97,73,14,7,84,64,15,62,14,17,88,92,82,11,47,63,73,13,94,98,88,15,37,38,11,2,74,20,73,94,26,96,64,56,80,53,48,85,85,35,15,90,63,9,42,99,81,97,26,94,32,24,96,61,38,18,57,22,76,7,5,43,55,97,74,35,99,86,24,25,8,60,75,18,61,14,97,52,64,97,45,29,69,91,43,40,99,58,72,73,70,45,5,97,37,89,77,32,92,94,6,33,72,64,35,75,14,32,99,64,54,78,1,92,35,30,71,11,48,82,61,49,12,46,75,54,52,33,92,24,11,72,72,16,17,57,72,68,46,15,85,58,74,55,54,87,97,44,94,16,84,57,56,96,33,79,7,70,50,23,98,91,6,62,51,73,68,17,83,93,56,15,81,99,88,15,13,93,53,48,69,2,14,83,86,39,4,54,69,52,42,60,79,92,38,68,90,48,77,46,77,16,89,3,96,77,11,77,23,73,98,35,3,1,97,48,62,36,74,13,93,19,71,23,70,64,64,14,71,86,98,20,95,1,97,30,92,16,98,63,94,56,90,49,94,28,88,43,84,38,74,83,62,4,98,63,69,0,0,21,21,1,10,1,0,0,0,0,0,0
}


dbg = print

function printgrid(grid, minx, maxx, miny, maxy, lookup, x, y)
  lookup = lookup or {}
  local out, tins = {}, table.insert
  for row = miny, maxy do
    local outrow = {}
    grid[row] = grid[row] or {}
    for col = minx, maxx do
      if (y and (row == y)) and (x and (col == x)) then
        tins(outrow, '*')
      else
        tins(outrow, (lookup[grid[row][col]] or grid[row][col] or ' '))
      end
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
  --input[0] = 2 -- partb

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

MAP = {
" ##### ####### ####### ### ### ####### # ",
"#.....#.......#.......#...#...#.......#.#",
"#.#.#.#####.#.#.#####.#.#.#.###.#.###.#.#",
"#.#.#...#...#.#.#.......#...#...#.#...#.#",
"#.#.###.#.###.#.#####.#####.#.###.###.#.#",
"#.#...#...#.#.#.....#.#...#.#.#.#...#...#",
"#.###.#####.#.#####.###.#.###.#.###.###.#",
"#...#.....#.#.....#.#...#...#.#...#.#...#",
" ########.#.#####.#.#.## ##.#.#.#.#.#.## ",
"#.........#.........#...#.#.....#.#.#...#",
"#.#########.###########.#.#######.#.###.#",
"#.#...#.....#.........#.#.#.....#.#...#.#",
"#.#.#.#######.#######.#.#.#.###.## ##.#.#",
"#...#.#...#...#.....#.#.#.#...#...#...#.#",
"#.###.#.#.#.#####.#.#.#.#.###.###.#.###.#",
"#...#...#.#.......#.#.......#...#.#...#.#",
" ##.#####.#.#############.#####.#.#.#.## ",
"#.#.#...#...#...........#.#.....#.#.#...#",
"#.#.#.#######.#########.###.#####.#####.#",
"#.#.#.#.......#.#.....#...#.#...#.......#",
"#.#.#.#.#######.#.#.## ##.#.###.#######.#",
"#.#.#.#...#.......#.#*#...#.#.....#.....#",
"#.#.#.###.###.#####.#.#.###.#.#####.#### ",
"#.......#...#.....#.#...#...#.....#...#.#",
"#.#########.#####.#.#####.###.###.###.#.#",
"#.#.........#...#.#.......#...#.#.#...#.#",
"#.#.#########.###.#####.###.###.#.#.###.#",
"#.#...#.#.....#...#...#.#...#...#...#...#",
" ####.#.#.#.###.###.###.#.#####.#### ##.#",
"#...#.#...#.#...#...#...#.....#.....#...#",
"#.#.#.#####.#.###.###.#######.###.#.#.#.#",
"#.#...#...#.......#...#.....#...#.#...#.#",
"#.#####.#.#########.###.#### ##.#.#####.#",
"#.#.....#.......#...#...#...#...#...#...#",
"#.#####.#######.#.###.#.#.#.#.###.#.###.#",
"#.....#.......#.#.#...#.#.#...#...#...#.#",
" ####.#######.#.#.#.###.#.#####.#####.#.#",
"#.#...#...#...#...#.#.#.#.#.....#...#.#.#",
"#.#.###.#.#.#######.#.#.#.#######.#.#.#.#",
"#.......#...#.........#...........#...#O#",
" ####### ### ######### ########### ### # ",
}



function Day15(INPUT, keyinput, partb)
  local intcode = coroutine.create(Intcode)

  local grid, x, y = {}, 1, 1
  local status = ""
  local retval, out
  local minx, maxx, miny, maxy = 20000, -20000, 20000, -20000

  UP = 1
  DOWN = 2
  LEFT = 3
  RIGHT = 4

  opposite = { [UP] = DOWN, [DOWN] = UP, [RIGHT] = LEFT, [LEFT] = RIGHT }

  --math.randomseed(2) -- RYANE TODO: Set to random value...
  math.randomseed(os.time()) -- RYANE TODO: Set to random value...

  BACKSTACK = {}

  grid[y] = {}
  grid[y][x] = 'X' -- Visited...

  local lastcommand = UP
  nextinput = { lastcommand }
  dbg = print

  local count = 10000000 -- 156 is backtrack
  while (status == "suspended" or status == "") and (count > 0) do
    count = count - 1
    if ((count % 100) == 0) then
       printgrid(grid, minmax.minx, minmax.maxx, minmax.miny, minmax.maxy, nil, 1, 1)
    end
    lastcommand = nextinput[1]
    --table.insert(BACKSTACK, 1, opposite[lastcommand]) -- Push Stack

    --dbg("x: " .. tostring(x) .. " y: " .. tostring(y) .. " next input: " .. tostring(nextinput[1]))
    if (status == "") then
      retval, out = coroutine.resume(intcode, INPUT, nextinput)
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
        --print("status: " .. status .. " out: " .. out)

        if ((ignore or 0) > 0) then
          dbg("IGNORING...")
          ignore = ignore - 1
        else
          if (out == 0) then
            --table.remove(BACKSTACK, 1)

            -- Hit a wall, didn't move...
            if (lastcommand == UP) then
              local i, j = x, y-1
              grid[j] = grid[j] or {}
              grid[j][i] = '#'
              minmax.track(i,j)
            end
            if (lastcommand == DOWN) then
              local i, j = x, y+1
              grid[j] = grid[j] or {}
              grid[j][i] = '#'
              minmax.track(i,j)
            end
            if (lastcommand == LEFT) then
              local i, j = x-1, y
              grid[j] = grid[j] or {}
              grid[j][i] = '#'
              minmax.track(i,j)
            end
            if (lastcommand == RIGHT) then
              local i, j = x+1, y
              grid[j] = grid[j] or {}
              grid[j][i] = '#'
              minmax.track(i,j)
            end
          end

          if (out == 1) then
            if (lastcommand == UP) then
              x, y = x, y-1
              grid[y] = grid[y] or {}
              grid[y][x] = '.'
              minmax.track(x,y)
            end
            if (lastcommand == DOWN) then
              x, y = x, y+1
              grid[y] = grid[y] or {}
              grid[y][x] = '.'
              minmax.track(x,y)
            end
            if (lastcommand == LEFT) then
              x, y = x-1, y
              grid[y] = grid[y] or {}
              grid[y][x] = '.'
              minmax.track(x,y)
            end
            if (lastcommand == RIGHT) then
              x, y = x+1, y
              grid[y] = grid[y] or {}
              grid[y][x] = '.'
              minmax.track(x,y)
            end
          end

          if (out == 2) then
            if (lastcommand == UP) then
              x, y = x, y-1
              grid[y] = grid[y] or {}
              grid[y][x] = 'O'
              minmax.track(x,y)
            end
            if (lastcommand == DOWN) then
              x, y = x, y+1
              grid[y] = grid[y] or {}
              grid[y][x] = 'O'
              minmax.track(x,y)
            end
            if (lastcommand == LEFT) then
              x, y = x-1, y
              grid[y] = grid[y] or {}
              grid[y][x] = 'O'
              minmax.track(x,y)
            end
            if (lastcommand == RIGHT) then
              x, y = x+1, y
              grid[y] = grid[y] or {}
              grid[y][x] = 'O'
              minmax.track(x,y)
            end
            -- Found Oxygen System!!!
            --print("FOUND OXY SYSTEM at " .. x .. "," .. y)
            --printgrid(grid, minmax.minx, minmax.maxx, minmax.miny, minmax.maxy, nil, 1, 1)
            --os.exit()
          end

  function anyempty(minmax)
    local count = 0
    if (minmax.maxx - minmax.minx < 40) then
      return false
    end
    if (minmax.maxy - minmax.miny < 40) then
      return false
    end
    for y = minmax.miny, minmax.maxy do
      for x = minmax.minx, minmax.maxx do
        if (((grid[y] or {})[x] or '?') == '?') then
          count = count + 1
          if (count > 1) then return false end
        end
      end
    end
    return true
  end

          -- Check around... If one way is not blocked and not '.', pick that... If not, pick a not blocked route...
          -- If all gone, go same direction as previously...
          function checkblocked(x, y)
            --dbg("checkblocked [" .. x .. "," .. y .. "]")
            local newdirections = {}
            grid[y] = grid[y] or {}
            grid[y-1] = grid[y-1] or {}
            grid[y+1] = grid[y+1] or {}
            if (not grid[y][x-1]) then
              table.insert(newdirections, LEFT)
            end
            if (not grid[y][x+1]) then
              table.insert(newdirections, RIGHT)
            end
            if (not grid[y-1][x]) then
              table.insert(newdirections, UP)
            end
            if (not grid[y+1][x]) then
              table.insert(newdirections, DOWN)
            end
            --else
              --if (((grid[y] or {})[x-1] or '.') ~= '.') then
              --newdirection = LEFT
              --elseif (((grid[y] or {})[x+1] or '.') ~= '.') then
              --newdirection = RIGHT
              --elseif (((grid[y-1] or {})[x] or '.') ~= '.') then
              --newdirection = UP
              --elseif (((grid[y+1] or {})[x] or '.') ~= '.') then
              --newdirection = DOWN
              --end
            --end
            return newdirections
          end

          local newdirections = checkblocked(x,y)
          --dump(newdirections)
          nextinput = { newdirections[math.random(#newdirections)] }
          if (#nextinput) then
            nextinput = { ({ UP, DOWN, LEFT, RIGHT })[math.random(4)] }
          end

          if (anyempty(minmax) == true) then
            printgrid(grid, minmax.minx, minmax.maxx, minmax.miny, minmax.maxy, nil, 1, 1)
            os.exit()
          end

          --[[
          local i, j = x, y
          local count1 = 20
          while ((not checkblocked(i,j)) and (count1 > 0)) do
            count1 = count1 - 1

            -- Try previous 'back' move...
            local ch = table.remove(BACKSTACK, 1)
            if (ch) then
              table.insert(nextinput, ch)

              if (ch == UP) then
                dbg("BACKTRACK UP")
                j = j - 1
              elseif (ch == DOWN) then
                dbg("BACKTRACK DOWN")
                j = j + 1
              elseif (ch == RIGHT) then
                dbg("BACKTRACK RIGHT")
                i = i + 1
              elseif (ch == LEFT) then
                dbg("BACKTRACK LEFT")
                i = i - 1
              end
            end
          end

          if (#nextinput > 0) then
            ignore = #nextinput
          else
            nextinput = { checkblocked(i,j) }
          end
          ]]

          -- Track min/max for grid printing purposes...
          --minmax.track(x,y)

          --printgrid(grid, minmax.minx, minmax.maxx, minmax.miny, minmax.maxy, nil, x, y)

          --[[
          for i = 1, 10 do
            if (BACKSTACK[i]) then
              print(BACKSTACK[i])
            end
          end
          ]]

          --if (not nextinput) then nextinput = { UP } end
          --dump(nextinput)
        end
      end
    end
  end
  --printgrid(grid, minmax.minx, minmax.maxx, minmax.miny, minmax.maxy)
end

-- No assertion on this one, since I'd have to capture multiple outs...

--Day15(INPUT)
--minmax.clear()
--Day11(INPUT, nil, true)

function Day15b(input)

  -- Load up map...
  local map = {}
  local y = 0
  local x = 0
  for _, line in pairs(input) do
    y = y + 1
    map[y] = map[y] or {}
    x = 0
    for c in line:gfind("(.)") do
      x = x + 1
      map[y][x] = c
    end
  end
  local maxx = x
  local maxy = y

  print("maxx: " .. maxx .. " maxy: " .. maxy)
  print("ZERO STATE...")
  printgrid(map, 1, maxx, 1, maxy)

  function anydot()
    for y = 1, maxy do
      for x = 1, maxx do
        if (map[y][x] == '.') then
          return true
        end
      end
    end
  end

  function advance()
    for y = 1, maxy do
      for x = 1, maxx do
        if (map[y][x] == 'O') then
          if ((map[y][x-1] or '') == '.') then
            map[y][x-1] = 'X'
          end
          if ((map[y][x+1] or '') == '.') then
            map[y][x+1] = 'X'
          end
          if (((map[y+1] or {})[x] or '') == '.') then
            map[y+1][x] = 'X'
          end
          if (((map[y-1] or {})[x]  or '')== '.') then
            map[y-1][x] = 'X'
          end
        end
      end
    end
    for y = 1, maxy do
      for x = 1, maxx do
        if (map[y][x] == 'X') then
          map[y][x] = 'O'
        end
      end
    end
  end

  local done = false
  local count = 0
  while not done do
    if (anydot() and (count < 2000)) then
      count = count + 1
      advance()
      print(count .. " HOURS LATER...")
      printgrid(map, 1, maxx, 1, maxy)
    else
      done = true
    end
  end

end

Day15b(MAP)

