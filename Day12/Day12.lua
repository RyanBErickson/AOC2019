
--[[ Day 12: Periodic Moons! ]]

require "TableDumper"

print("---------------- Day 12 ----------------")


MOONS = {
  {pos = {x=-14, y=-4, z=-11}, vel = {x = 0, y = 0, z = 0}},
  {pos ={x=-9, y=6, z=-7}, vel = {x = 0, y = 0, z = 0}},
  {pos ={x=4, y=1, z=4}, vel = {x = 0, y = 0, z = 0}},
  {pos ={x=2, y=-14, z=-9}, vel = {x = 0, y = 0, z = 0}},
}

TESTA = {
  {pos = {x=-1, y=0, z=2}, vel = {x = 0, y = 0, z = 0}},
  {pos ={x=2, y=-10, z=-7}, vel = {x = 0, y = 0, z = 0}},
  {pos ={x=4, y=-8, z=8}, vel = {x = 0, y = 0, z = 0}},
  {pos ={x=3, y=5, z=-1}, vel = {x = 0, y = 0, z = 0}},
}

dbg = print

input = MOONS

local initial = {}
for i = 1, #input do
  initial[i] = {x = input[i].pos.x, y = input[i].pos.y, z = input[i].pos.z}
end

local x_period, y_period, z_period

local function gcd( m, n )
  while n ~= 0 do
    local q = m
    m = n
    n = q % n
  end
  return m
end

local function lcm( m, n )
  return ( m ~= 0 and n ~= 0 ) and m * n / gcd( m, n ) or 0
end

local step = 0
local done = false
local abs = math.abs

repeat
  -- for each pair...
  for i = 1, #input do 
    for j = i+1, #input do 
      if (input[i].pos.x > input[j].pos.x) then input[i].vel.x = input[i].vel.x - 1 input[j].vel.x = input[j].vel.x + 1 end
      if (input[i].pos.x < input[j].pos.x) then input[j].vel.x = input[j].vel.x - 1 input[i].vel.x = input[i].vel.x + 1 end

      if (input[i].pos.y > input[j].pos.y) then input[i].vel.y = input[i].vel.y - 1 input[j].vel.y = input[j].vel.y + 1 end
      if (input[i].pos.y < input[j].pos.y) then input[j].vel.y = input[j].vel.y - 1 input[i].vel.y = input[i].vel.y + 1 end

      if (input[i].pos.z > input[j].pos.z) then input[i].vel.z = input[i].vel.z - 1 input[j].vel.z = input[j].vel.z + 1 end
      if (input[i].pos.z < input[j].pos.z) then input[j].vel.z = input[j].vel.z - 1 input[i].vel.z = input[i].vel.z + 1 end
    end
  end

  local total_potential = 0
  for i = 1, #input do 
    input[i].pos.x = input[i].pos.x + input[i].vel.x
    input[i].pos.y = input[i].pos.y + input[i].vel.y
    input[i].pos.z = input[i].pos.z + input[i].vel.z

    input[i].potential = (abs(input[i].pos.x) + abs(input[i].pos.y) + abs(input[i].pos.z)) *
                         (abs(input[i].vel.x) + abs(input[i].vel.y) + abs(input[i].vel.z))
    total_potential = total_potential + input[i].potential
  end

  step = step + 1

  -- Spoilers:
  -- Find when X, Y ,and Z periodize (return to initial state), print them out...
  -- find the LCM of those cycles...

  -- PartB calculations...
  local ok = not x_period
  for i = 1, #input do
    if (input[i].vel.x ~= 0) or (input[i].pos.x ~= initial[i].x) then ok = false end
  end
  if (ok) then x_period = step end

  ok = not y_period
  for i = 1, #input do
    if (input[i].vel.y ~= 0) or (input[i].pos.y ~= initial[i].y) then ok = false end
  end
  if (ok) then y_period = step end

  local ok = not z_period
  for i = 1, #input do
    if (input[i].vel.z ~= 0) or (input[i].pos.z ~= initial[i].z) then ok = false end
  end
  if (ok) then z_period = step end

  -- Find LCM of X/Y/Z periods...
  if (x_period and y_period and z_period) then
    print("Answer: " .. string.format("%d", lcm(x_period, lcm(y_period, z_period))))
    done = true
  end

  --dbg("After Step " .. step .. ":")
  --dump(input)
  --print("Total Potential Energy: " .. total_potential)
until done or (step > 1000000)

