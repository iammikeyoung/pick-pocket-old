//
//  CustomizableLabel.swift
//  pick-pocket-ios
//
//  Created by Maya Saxena on 1/27/18.
//

import UIKit

class CustomizableLabel: UILabel {
    @IBInspectable var letterSpacing: CGFloat = 0 {
        didSet {
            kern(text: text)
        }
    }

    override var text: String? {
        didSet {
            kern(text: text)
        }
    }

    private func kern(text: String?) {
        if let labelText = text, labelText.count > 0 {
            let attributedString = NSMutableAttributedString(string: labelText)
            attributedString.addAttribute(NSKernAttributeName, value: letterSpacing, range: NSRange(location: 0, length: attributedString.length - 1))
            attributedText = attributedString
        }
    }
}
