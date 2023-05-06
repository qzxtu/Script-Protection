-- Load the script from the given URL
local url = "Script Link Here"
local script = game:HttpGet(url, true) -- Use HTTPS

-- Record the start time for performance measurement
local startTime = os.clock()

-- Convert the script to bytecode
local function dumpString(str)
    local dumped = string.dump(loadstring(str))
    return dumped
end
local bytecode = dumpString(script)

-- Escape all characters in the script
local function escapeString(str)
    local escaped = ""
    for i = 1, #str do
        escaped = escaped .. "\\" .. string.byte(str, i)
    end
    return escaped
end
local escapedBytecode = escapeString(bytecode)

-- Encrypt the escaped bytecode using a secret key
local secretKey = "mySecretKey"
local function encryptString(str, key)
    local encrypted = syn.crypt.encrypt(str, key)
    return encrypted
end
local encryptedBytecode = encryptString(escapedBytecode, secretKey)

-- Generate a random key to use for obfuscation
local function generateObfuscationKey()
    math.randomseed(os.time())
    local key = ""
    for i = 1, 32 do
        key = key .. string.char(math.random(32, 126))
    end
    return key
end
local obfuscationKey = generateObfuscationKey()

-- Obfuscate the encrypted bytecode using the random key
local function xorStrings(str1, str2)
    local result = ""
    for i = 1, #str1 do
        local byte1 = string.byte(str1, i)
        local byte2 = string.byte(str2, i % #str2 + 1)
        result = result .. string.char(bit32.bxor(byte1, byte2))
    end
    return result
end
local obfuscatedBytecode = xorStrings(encryptedBytecode, obfuscationKey)

-- Build the final script with string.format()
local formatString = [[
-- Advanced protection with encryption and obfuscation
-- Bytecode Hash: %s
loadstring(syn.crypt.decrypt(%q, %q))()
]]
local decryptedBytecode = "syn.crypt.xor(" .. ("%q"):format(obfuscatedBytecode) .. ", " .. ("%q"):format(obfuscationKey) .. ")"
local finalScript = string.format(formatString, syn.crypt.hash(obfuscatedBytecode), decryptedBytecode, secretKey)

-- Store the obfuscated script in the clipboard
setclipboard(finalScript)

-- Print the time taken to execute the script
print(("Finished in %.2f seconds"):format(os.clock() - startTime))