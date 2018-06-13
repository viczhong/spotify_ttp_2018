//: Playground - noun: a place where people can play

import UIKit

/*
Question 2 -- decodeString(s): Given an encoded string, return its corresponding decoded string.

The encoding rule is: k[encoded_string], where the encoded_string inside the square brackets is repeated exactly k times. Note: k is guaranteed to be a positive integer.

For s = "4[ab]", the output should be decodeString(s) = "abababab"
For s = "2[b3[a]]", the output should be decodeString(s) = "baaabaaa"
*/

func decodeString(s: String) -> String {
    var pointer = 0
    var strArr = [String]()
    var storage = String()
    var numberStorage = String()

    while pointer < s.count {
        // Counting backwards in case the string is nested
        let char = s[s.index(s.startIndex, offsetBy: s.count - pointer - 1)]

        // Keep track of the string
        if char != "]" && char != "[" {
            storage = String(char) + storage
        }

        if char == "[" {
            // We have a complete string at this point. Time to move on and find the number. Check the integer.
            while pointer < s.count - 1 {
                pointer += 1
                let charToCheck = s[s.index(s.startIndex, offsetBy: s.count - pointer - 1)]

                // Check to see if the character is a number. If so, add it to our number storage string. If not, uncheck and continue with the operation.
                if CharacterSet.decimalDigits.contains(Unicode.Scalar(String(charToCheck))!) {
                    numberStorage = String(charToCheck) + numberStorage
                } else {
                    pointer -= 1
                    break
                }
            }

            // Cast stored number string as an integer
            guard let num = Int(numberStorage) else { return strArr.joined() }

            // Expand the array
            strArr = Array(repeating: storage + strArr.joined(), count: num)

            // Clear out the storage strings
            storage.removeAll()
            numberStorage.removeAll()
        }

        pointer += 1
    }

    // Turn our string storage array into a String
    return strArr.joined()
}

decodeString(s: "4[ab]") // returns "abababab"
decodeString(s: "2[b3[a]]") // returns "baaabaaa"

assert(decodeString(s: "4[ab]") == "abababab")
assert(decodeString(s: "2[b3[a]]") == "baaabaaa")
