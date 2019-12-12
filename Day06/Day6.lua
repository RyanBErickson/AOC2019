
--[[ Day 6: Count Orbits ]]

TESTA = {"COM)B", "B)C", "C)D", "D)E", "E)F", "B)G", "G)H", "D)I", "E)J", "J)K", "K)L"}
TESTB = {"COM)B", "B)C", "C)D", "D)E", "E)F", "B)G", "G)H", "D)I", "E)J", "J)K", "K)L", "K)YOU", "I)SAN"}
INPUT = {}
for line in io.lines("input.txt") do
  table.insert(INPUT, line)
end


function loadinput(input)
  local parent = {}
  for _, line in pairs(input) do
    local _, _, root, branch = line:find("(.-)%)(.+)")
    parent[branch] = root
  end
  return parent
end


print("..................................... PART A .....................................")



function Day6a(input)
  local parent = loadinput(input)

  local countPath = function(cur)
    local count = 0
    while (cur ~= 'COM') do
      count, cur = count + 1, parent[cur]
    end
    return count
  end

  -- For each node, traverse (and count) through parent nodes back to COM...
  local count = 0
  for k, _ in pairs(parent) do
    count = count + countPath(k)
  end

  print("Count: " .. count)
  return count
end

assert(Day6a(TESTA) == 42)
assert(Day6a(INPUT) == 268504)


print("..................................... PART B .....................................")

function Day6b(input)
  local tins = table.insert

  local parent = loadinput(input)

  local getPathToRoot = function(cur)
    local path, tins = {}, table.insert
    while (cur ~= 'COM') do
      tins(path, cur)
      cur = parent[cur]
    end
    return path
  end

  -- Build path from 'YOU' and 'SAN' back to origin
  local path_a, path_b = getPathToRoot(parent['YOU']), getPathToRoot(parent['SAN'])

  -- Remove common nodes from end of each (starts with COM), until non-matching or length zero...
  while (#path_a > 0) and (path_a[#path_a] == path_b[#path_b]) do
    table.remove(path_a)
    table.remove(path_b)
  end

  local count = #path_a + #path_b

  print("count: " .. count)
  return count
end

assert(Day6b(TESTB) == 4)
assert(Day6b(INPUT) == 409)

