//
//  GuessDigitButton.swift
//  pick-pocket-ios
//
//  Created by Maya Saxena on 1/27/18.
//

import UIKit

@IBDesignable class GuessDigitButton: UIButton {
    @IBInspectable var digit: Int = 0 {
        didSet {
            titleLabel?.text = String(digit)
        }
    }
}
