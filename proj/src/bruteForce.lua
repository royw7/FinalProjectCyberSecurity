local STRING_TYPES = "1234567890abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ`~!@#$%^&*()_-+=[{]}|:;'\",<.>/?"
local INT_TYPES = "1234567890"
local STRING_TYPES_TABLE = {}
local INT_TYPES_TABLE = {}

local Util = require("src/Util")

for i = 1, string.len(STRING_TYPES)do
    table.insert(STRING_TYPES_TABLE, string.sub(STRING_TYPES, i, i))
end

for i = 1, string.len(INT_TYPES)do
    table.insert(INT_TYPES_TABLE, string.sub(INT_TYPES, i, i))
end

local module = {}

local passwordFound = nil

local function generate(current, len, chars, passToCrack)
    if #current == len then
    -- Util.tprint(current)
     if(Util.tableToString(current) == passToCrack) then
      passwordFound = Util.tableToString(current)
      return
    end
    end
    if #current < len then
    for c = 1, #chars do
    local curr = {}
    for i = 1, #current do
        curr[i] = current[i]
    end
    curr[#curr+1] = chars[c]
    generate(curr, len, chars, passToCrack)
    end
    end
end

local MIN = 1
local MAX = #(STRING_TYPES_TABLE)

function module.brute(passToCrack)
    passwordFound = nil
    local startTime = os.clock()
    for l = MIN, MAX do
        local start = os.clock()
        print("--- Brute Force: Started Checking Passwords with Length "..l.."---")
        generate({}, l, STRING_TYPES_TABLE, passToCrack)
        if(passwordFound)then
            print("--- Brute Force Ended --- ")
            print("Password is "..passwordFound)
            print("Time Took In Seconds Exact: "..(os.clock() - startTime))
            print("Time Took: "..Util.disp_time(os.clock() - startTime))
            return
        end
        print("--- Brute Force: Finished Checking Passwords with Length "..l.." Time Took: "..Util.disp_time(os.clock() - start).."---")
    end
    print("--- Brute Force Ended --- ")
    print("Password Never Found")
    print("Time Took: "..(os.clock() - startTime))
end

function module.bruteDigitOnly(passToCrack)
    passwordFound = nil
    local startTime = os.clock()
    for l = 1, 10 do
        local start = os.clock()
        print("--- Pin Brute Force: Started Checking Passwords with Length "..l.."---")
        generate({}, l, INT_TYPES_TABLE, passToCrack)
        if(passwordFound)then
            print("--- Pin Brute Force Ended --- ")
            print("Password is "..passwordFound)
            print("Time Took In Seconds Exact: "..(os.clock() - startTime))
            print("Time Took: "..Util.disp_time(os.clock() - startTime))
            return
        end
        print("--- Pin Brute Force: Finished Checking Passwords with Length "..l.." Time Took: "..Util.disp_time(os.clock() - start).."---")
    end
    print("--- Pin Brute Force Ended --- ")
    print("Password Never Found")
    print("Time Took: "..(os.clock() - startTime))
end

return module