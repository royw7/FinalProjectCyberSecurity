-- Modules
local BruteForce = require("src/bruteForce")
local DictionaryAttack = require("src/DictionaryAttack")
-- VARS
local valid = false
local input 

while(not valid) do
    print("Enter Password")
    input = io.read(...)
    if(string.find(input, " ")) then
        print("Password must not contain any spaces!")
    else
        valid = true
    end
end
    
local Password = tostring(input)
print("Password is set as: "..Password)

local pinBruteForceSpawn = coroutine.create(function () 
    print("--- Attemping Pin Brute Force ---")
    BruteForce.bruteDigitOnly(Password)
end)

local bruteForceSpawn = coroutine.create(function () 
    print("--- Attemping Brute Force ---")
    BruteForce.brute(Password)
end)

local dictionaryAttackSpawn = coroutine.create(function () 
    print("--- Attemping DictionaryAttack ---")
    DictionaryAttack.attack(Password)
end)

--coroutine.resume(dictionaryAttackSpawn)
--coroutine.resume(pinBruteForceSpawn)
coroutine.resume(bruteForceSpawn)



