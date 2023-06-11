local module = {}

local Util = require("src/Util")

local Password_File4 = "src/passwords/NordVPN.txt"
local Password_File3 = "src/passwords/Most-Popular-Letter-Passes.txt"
local Password_File2 = "src/passwords/xato-net-10-million-passwords-1000000.txt"
local Password_File1 = "src/passwords/alleged-gmail-passwords.txt"

local function tryPasswordFile(file, passwordToCrack, startTime)
    local passwords = Util.lines_from(file)
    for _, password in pairs(passwords) do
        if(password == passwordToCrack) then
            print("--- Dictionary Attack Success --- ")
            print("Password is "..password)
            print("Time Took In Seconds Exact: "..(os.clock() - startTime))
            print("Time Took: "..Util.disp_time(os.clock() - startTime))
            return true
        end
    end
    return false
end

function module.attack(passwordToCrack)
    local startTime = os.clock()
    print("--- Dictionary Attack Started ---")
   
    print("Injecting leaked Gmail passwords")
    local success = tryPasswordFile(Password_File1, passwordToCrack, startTime)
    if success then return end
    print("Gmail passwords exhausted")

    print("Injecting leaked NordVPN passwords")
    local success = tryPasswordFile(Password_File4, passwordToCrack, startTime)
    if success then return end
    print("NordVPN passwords exhausted")

    print("Injecting common passwords")
    local success = tryPasswordFile(Password_File3, passwordToCrack, startTime)
    if success then return end
    print("Common passwords exhausted")

    print("Injecting ten million passwords")
    local success = tryPasswordFile(Password_File2, passwordToCrack, startTime)
    if success then return end
    print("Ten Million passwords exhausted")

    print("Password Never Found")
    print("Time Took: "..(os.clock() - startTime))
    print("--- Dictionary Attack Ended --- ")
end

return module