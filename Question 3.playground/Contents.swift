//: Playground - noun: a place where people can play

import UIKit

/*
 Question 3 -- changePossibilities(amount,amount): Your quirky boss collects rare, old coins. They found out you're a programmer and asked you to solve something they've been wondering for a long time.

 Write a function that, given an amount of money and an array of coin denominations, computes the number of ways to make the amount of money with coins of the available denominations.

 Example: for amount=4 (4¢) and denominations=[1,2,3] (1¢, 2¢ and 3¢), your program would output 4—the number of ways to make 4¢ with those denominations:

 1¢, 1¢, 1¢, 1¢
 1¢, 1¢, 2¢
 1¢, 3¢
 2¢, 2¢
 */


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
