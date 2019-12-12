
--[[ Day 10: Blasted Asteroids! ]]

print("---------------- Day 10 ----------------")

require "TableDumper"

local INPUT = {}
for line in io.lines("input.txt") do
  table.insert(INPUT, line)
end


TESTA = {".#..#",".....","#####","....#","...##"}

TESTA = {
"......#.#.",
"#..#.#....",
"..#######.",
".#.#.###..",
".#..#.....",
"..#....#.#",
"#..#....#.",
".##.#..###",
"##...#..#.",
".#....####",
}

TESTA = {
".#....#####...#..",
"##...##.#####..##",
"##...#...#.#####.",
"..#.....#...###..",
"..#.#.....#....##",
}

TESTA = {
".#..##.###...#######",
"##.############..##.",
".#.######.########.#",
".###.#######.####.#.",
"#####.##.#.##.###.##",
"..#####..#.#########",
"####################",
"#.####....###.#.#.##",
"##.#################",
"#####.##.###..####..",
"..######..##.#######",
"####.##.####...##..#",
".#####..#.######.###",
"##...#.##########...",
"#.##########.#######",
".####.#.###.###.#.##",
"....##.##.###..#####",
".#.#.###########.###",
"#.#.#.#####.####.###",
"###.##.####.##.#..##",
}

function loadChars(input)
  local map = {}
  local y, x = 0, 0
  for _, line in pairs(input) do
    x = 0
    y = y + 1
    map[y] = {}
    for c in line:gmatch("(.)") do
      x = x + 1
      map[y][x] = c
    end
  end
  return map, x, y
end

local map, width, height = loadChars(INPUT)

-- Calculate the angle from each # to each other #, count 1 per angle...
-- rise/run == angle...

local count, numasteroids = {}, 0
for y = 1, height do
  for x = 1, width do
    if (map[y][x] == "#") then
      numasteroids = numasteroids + 1 
      count[y] = count[y] or {}
      count[y][x] = {}
      for j = 1, height do
        for i = 1, width do
          if (i ~= x or j ~= y) and (map[j][i] == "#") then
            -- Calculate angle
            local rise = j - y
            local run = i - x
            local angle = math.deg(math.atan2(run ,rise* -1))
            if (angle < 0) then
              angle = 360+angle -- Convert to 0-360 deg
            end
            --print(x .. ", " .. y .. " ---> " .. i .. "," .. j .. " : " .. run .. "/" .. rise .. " -> " .. angle)
            count[y][x][angle] = count[y][x][angle] or {}
            count[y][x][angle][i-1 .. "," .. j-1] = math.abs(y - j) + math.abs(x - i) -- Store distance by 0-based coords...
          end
        end
      end
    end
  end
end

-- Find max visible for station location...
local max, maxx, maxy = 0, 0, 0
for y = 1, height do
  for x = 1, width do
    if (count[y]) then
      if (count[y][x]) then
        local mycount = 0
        for angle, tab in pairs(count[y][x]) do
          mycount = mycount + 1
        end
        if (mycount > max) then
          max, maxx, maxy = mycount, x, y
        end
      end
    end
  end
end

print(maxx -1 .. "," .. maxy -1 .. " : " .. max .. " visible / " .. numasteroids - 1 .. " Total") -- Print out in 0-base...

local mymap = count[maxy][maxx]

-- PiL 19.3
function pairsByKeys (t, f)
  local a = {}
  for n in pairs(t) do table.insert(a, n) end
  table.sort(a, f)
  local i = 0
  local iter = function ()
    i = i + 1
    if a[i] == nil then return nil
    else return a[i], t[a[i]]
    end
  end
  return iter
end

-- Find each 'closest' at each angle, remove as we go...
local done = false
local count = 0
local fmt = string.format
while (not done) do
  done = true
  for angle, coords in pairsByKeys(mymap) do
    local closest, closestcoord = 1000000, ""
    for coord, dist in pairs(coords) do
      if (dist < closest) then
        done = false
        closest, closestcord = dist, coord
      end
    end
    if (not done) and (coords[closestcord]) then
      count = count + 1
      print(fmt("%3s", count) .. "> Destroy: " .. fmt("%06s", closestcord) .. "  @  [Angle: " .. fmt("%8s", fmt("%0.3f", angle) .. "]"))
      coords[closestcord] = nil
    end
  end
end

