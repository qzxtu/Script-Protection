-- Load the script from the given URL
local scriptUrl = "Script Link Here"
local scriptContent = game:HttpGet(scriptUrl, true) -- Use HTTPS

-- Record the start time for performance measurement
local startTime = os.clock()

-- Convert the script to bytecode
local function convertStringToBytecode(str)
    local bytecode = string.dump(loadstring(str))
    return bytecode
end
local scriptBytecode = convertStringToBytecode(scriptContent)

-- Escape all characters in the script
local function escapeAllCharactersInString(str)
    local escapedString = ""
    for i = 1, #str do
        escapedString = escapedString .. "\\" .. string.byte(str, i)
    end
    return escapedString
end
local escapedScriptBytecode = escapeAllCharactersInString(scriptBytecode)

-- Encrypt the escaped bytecode using a secret key
local secretKey = "mySecretKey"
local function encryptStringUsingSecretKey(str, key)
    local encryptedString = syn.crypt.encrypt(str, key)
    return encryptedString
end
local encryptedScriptBytecode = encryptStringUsingSecretKey(escapedScriptBytecode, secretKey)

-- Generate a random key to use for obfuscation
local function generateRandomObfuscationKey()
    math.randomseed(os.time())
    local key = ""
    for i = 1, 32 do
        key = key .. string.char(math.random(32, 126))
    end
    return key
end
local obfuscationKey = generateRandomObfuscationKey()

-- Obfuscate the encrypted bytecode using the random key
local function xorTwoStringsTogether(str1, str2)
    local result = ""
    for i = 1, #str1 do
        local byte1 = string.byte(str1, i)
        local byte2 = string.byte(str2, i % #str2 + 1)
        result = result .. string.char(bit32.bxor(byte1, byte2))
    end
    return result
end
local obfuscatedScriptBytecode = xorTwoStringsTogether(encryptedScriptBytecode, obfuscationKey)

-- Build the final script with string.format()
local formatString = [[
-- Advanced protection with encryption and obfuscation
-- Bytecode Hash: %s
loadstring(syn.crypt.decrypt(%q, %q))()
]]
local decryptedScriptBytecode = "syn.crypt.xor(" .. ("%q"):format(obfuscatedScriptBytecode) .. ", " .. ("%q"):format(obfuscationKey) .. ")"
local finalScriptContent = string.format(formatString, syn.crypt.hash(obfuscatedScriptBytecode), decryptedScriptBytecode, secretKey)

-- Store the obfuscated script in the clipboard
setclipboard(finalScriptContent)

-- Print the time taken to execute the script
print(("Finished in %.2f seconds"):format(os.clock() - startTime))
