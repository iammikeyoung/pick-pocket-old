//
//  PickLockViewModel.swift
//  pick-pocket-ios
//
//  Created by Maya Saxena on 1/27/18.
//

import UIKit

struct PickLockViewModel {
    private let lock: Lock

    private var isLocked = true

    var lockIcon: UIImage {
        return isLocked ? #imageLiteral(resourceName: "lock-closed") : #imageLiteral(resourceName: "lock-open")
    }

    private(set) var previousGuessText = ""
    private(set) var guessText = ""
    private(set) var feedbackText = ""

    init() {
        self.lock = Lock(code: "123")
    }

    mutating func handleDigitTapped(digit: Int) {
        guessText += String(digit)

        guard guessText.count == lock.code.count else { return }

        let result = lock.submit(guess: guessText)
        isLocked = result.correct != lock.code.count
        feedbackText = result.feedbackString
        previousGuessText = guessText
        guessText = ""
    }
}

extension PickPocketResult {
    var feedbackString: String {
        return String(repeating: "⚫", count: correct) + String(repeating: "⚪", count: misplaced)
    }
}
