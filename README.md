# Advanced Script Protection

This script adds advanced protection measures such as encryption and obfuscation to a script loaded from a URL.

## Usage

1. Replace the `url` variable with the URL of the script you want to protect.
2. Replace the `secretKey` variable with your own secret key for encryption.
3. Run the script to generate the protected version of the script.
4. The protected script will be stored in the clipboard. You can paste it into a new file or location.

## How it works

1. The script is loaded from the given URL using `game:HttpGet`.
2. The start time is recorded for performance measurement.
3. The script is converted to bytecode using `string.dump`.
4. All characters in the bytecode are escaped using a custom `escapeString` function.
5. The escaped bytecode is encrypted using `syn.crypt.encrypt` and a secret key.
6. A random key is generated for obfuscation using a custom `generateObfuscationKey` function.
7. The encrypted bytecode is obfuscated using a custom `xorStrings` function and the random key.
8. The final script is built using `string.format` and includes code to decrypt and deobfuscate the original script.
9. The final script is stored in the clipboard using `setclipboard`.
10. The time taken to execute the script is printed.
