//
//  PreviousGuessTableViewCell.swift
//  pick-pocket-ios
//
//  Created by Maya Saxena on 3/13/18.
//

import UIKit

class PreviousGuessTableViewCell: UITableViewCell {
    static let identifier = String(describing: PreviousGuessTableViewCell.self)

    @IBOutlet private weak var feedbackLabel: UILabel!
    @IBOutlet private weak var guessLabel: CustomizableLabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.transform = CGAffineTransform(rotationAngle: CGFloat.pi) // Bottom-to-top table view
    }

    func configure(with previousGuess: PreviousGuess) {
        feedbackLabel.text = previousGuess.result.feedbackString
        guessLabel.text = previousGuess.guess
    }
}

private extension PickPocketResult {
    var feedbackString: String {
        return String(repeating: "⚫", count: correct) + String(repeating: "⚪", count: misplaced)
    }
}
