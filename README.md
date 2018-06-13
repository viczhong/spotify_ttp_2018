# Spotify TTP Code Challenge
To TTP: 

Hello from Victor Zhong.


## To run:
Open each `.playground` file in Xcode.
See below in case Playground files don't open.

### Question 1:

sortByStrings(s,t): Sort the letters in the string s by the order they occur in the string t. You can assume t will not have repetitive characters. For s = "weather" and t = "therapyw", the output should be sortByString(s, t) = "theeraw". For s = "good" and t = "odg", the output should be sortByString(s, t) = "oodg".

```swift
func sortByStrings(s: String, t: String) -> String {
    var pointerS = 0
    var pointerT = 0
    var outputString = ""

    while pointerT < t.count {
        let charAtS = s[s.index(s.startIndex, offsetBy: pointerS)]
        let charAtT = t[t.index(t.startIndex, offsetBy: pointerT)]

        if charAtS == charAtT {
            outputString.append(charAtS)
        }

        pointerS += 1

        if pointerS == s.count {
            pointerT += 1
            pointerS = 0
        }
    }

    return outputString
}

sortByStrings(s: "weather", t: "therapyw") // returns "theeraw"
sortByStrings(s: "good", t: "odg") // returns "oodg"

assert(sortByStrings(s: "weather", t: "therapyw") == "theeraw")
assert(sortByStrings(s: "good", t: "odg") == "oodg")
```

### Question 2:

decodeString(s): Given an encoded string, return its corresponding decoded string.

The encoding rule is: k[encoded_string], where the encoded_string inside the square brackets is repeated exactly k times. Note: k is guaranteed to be a positive integer.

For s = "4[ab]", the output should be decodeString(s) = "abababab"
For s = "2[b3[a]]", the output should be decodeString(s) = "baaabaaa"

```swift
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
```

### Question 3:

changePossibilities(amount,amount): Your quirky boss collects rare, old coins. They found out you're a programmer and asked you to solve something they've been wondering for a long time.

 Write a function that, given an amount of money and an array of coin denominations, computes the number of ways to make the amount of money with coins of the available denominations.

 Example: for amount=4 (4¢) and denominations=[1,2,3] (1¢, 2¢ and 3¢), your program would output 4—the number of ways to make 4¢ with those denominations:

 1¢, 1¢, 1¢, 1¢
 
 1¢, 1¢, 2¢
 
 1¢, 3¢
 
 2¢, 2¢
 
 ```swift
 func changePossibilities(amount: Int, denominations: [Int]) -> Int {
    // I think it's easier to check if it's from bigger to smaller coin sizes
    let sortedDenom = denominations.sorted { $0 > $1 }

    let combinations = findCoinCombos(amount: amount, denominations: sortedDenom)

    print("\(combinations) Combinations of \(amount)")

    return combinations
}

func findCoinCombos(amount: Int, denominations: [Int], current: [Int] = [], index: Int = 0) -> Int {
    // Base cases
    // If the amount is exactly 0 after the operations, we can count this as a valid combo
    guard amount != 0 else { print(current); return 1 }

    // If amount is in the negative or we're out of coins to plug in, this isn't a valid combo
    guard amount >= 0 && denominations.count != index else { return 0 }

    // Start with first coin
    let firstCoin = findCoinCombos(amount: amount - denominations[index], denominations: denominations, current: current + [denominations[index]], index: index)

    // Continue breaking down the amount with next coin(s) in series once current coin is bigger than amount
    let nextCoin = findCoinCombos(amount: amount, denominations: denominations, current: current, index: index + 1)

    // Recursion
    return firstCoin + nextCoin
}

changePossibilities(amount: 4, denominations: [1, 2, 3]) // returns 4

assert(changePossibilities(amount: 4, denominations: [1, 2, 3]) == 4)
```

Prints:
```
[3, 1]
[2, 2]
[2, 1, 1]
[1, 1, 1, 1]
4 Combinations for value: 4
```