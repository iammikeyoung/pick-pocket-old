//
//  Lock.swift
//  pick-pocket-ios
//
//  Created by Nicholas Servidio on 1/7/17.
//
//

import UIKit

struct Lock {
    let code: String
    func submit(guess: String) -> PickPocketResult {
        var correct = 0
        var misplaced = 0
        var codeMisplaced = [Character: Int]()
        var guessMisplaced = [Character: Int]()

        zip(code, guess).forEach { (codeCharacter, guessCharacter) in
            if codeCharacter == guessCharacter {
                correct += 1
            } else {
                if let misplacedCount = codeMisplaced[guessCharacter], misplacedCount > 0 {
                    codeMisplaced[guessCharacter] = misplacedCount - 1
                    misplaced += 1
                } else {
                    let misplacedCount = codeMisplaced[codeCharacter] ?? 0
                    codeMisplaced[codeCharacter] = misplacedCount + 1
                }

                if let misplacedCount = guessMisplaced[codeCharacter], misplacedCount > 0 {
                    guessMisplaced[codeCharacter] = misplacedCount - 1
                    misplaced += 1
                } else {
                    let misplacedCount = guessMisplaced[guessCharacter] ?? 0
                    guessMisplaced[guessCharacter] = misplacedCount + 1
                }
            }
        }
        return PickPocketResult(correct: correct, misplaced: misplaced)
    }
}
