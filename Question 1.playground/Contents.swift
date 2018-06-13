import UIKit

/*
Question 1 -- sortByStrings(s,t): Sort the letters in the string s by the order they occur in the string t. You can assume t will not have repetitive characters. For s = "weather" and t = "therapyw", the output should be sortByString(s, t) = "theeraw". For s = "good" and t = "odg", the output should be sortByString(s, t) = "oodg".
*/

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

sortByStrings(s: "weather", t: "therapyw") // prints "theeraw"
sortByStrings(s: "good", t: "odg") // prints "oodg"

assert(sortByStrings(s: "weather", t: "therapyw") == "theeraw")
assert(sortByStrings(s: "good", t: "odg") == "oodg")
