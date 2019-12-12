
--[[
Day 4: Password Remember-y...
]]

print("---------------- Day 4 ----------------")


function Day4(first, last, num_match)

  local testpass = function(pass)
    local lastdigit = -1

    local adjacent_group_size = {0, 0, 0, 0, 0, 0, 0, 0, 0, [0] = 0}

    for digit in tostring(pass):gfind("%d") do
      digit = tonumber(digit)

      -- Immediate fail if smaller digit found...
      if (digit < lastdigit) then
	  return 0
      end

      -- Save adjacent count
      if (digit == lastdigit) then
	  adjacent_group_size[digit] = adjacent_group_size[digit] + 1 
      end
      
      lastdigit = digit
    end

    for i, n in pairs(adjacent_group_size) do
	    -- PartB, passes in a match number (1)...
	    if num_match then
		    if (n == num_match) then
			    return 1
		    end
	    else
		    if (n > 0) then
			    return 1
		    end
	    end
    end
    return 0
  end

  local count = 0
  for i = first, last do
	    count = count + testpass(i)
  end
  print(first .. " -> " .. last .. " count: " .. count)
  return count
end


print("--------------- Part A ----------------")
assert(Day4("111111", "111111") == 1)
assert(Day4("223450", "223450") == 0)
assert(Day4("123789", "123789") == 0)
assert(Day4("134792", "675810") == 1955)

print("--------------- Part B ----------------")
assert(Day4("112233", "112233", 1) == 1)
assert(Day4("123444", "123444", 1) == 0)
assert(Day4("111122", "111122", 1) == 1)
assert(Day4("134792", "675810", 1) == 1319)

