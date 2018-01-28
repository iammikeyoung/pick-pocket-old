//
//  ViewController.swift
//  pick-pocket-ios
//
//  Created by Nicholas Servidio on 1/7/17.
//
//

import UIKit

final class PickLockViewController: UIViewController {
    @IBOutlet private weak var feedbackLabel: UILabel!
    @IBOutlet private weak var previousGuessLabel: UILabel!

    @IBOutlet private weak var guessLabel: CustomizableLabel!
    @IBOutlet private weak var lockImageView: UIImageView!

    @IBOutlet private var digitButtons: [GuessDigitButton]! {
        didSet {
            digitButtons.sort(by: { $0.digit < $1.digit })
        }
    }

    private var viewModel = PickLockViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func guessDigitButtonPressed(_ sender: GuessDigitButton) {
        viewModel.handleDigitTapped(digit: sender.digit)
        guessLabel.text = viewModel.guessText
        feedbackLabel.text = viewModel.feedbackText
        previousGuessLabel.text = viewModel.previousGuessText
        lockImageView.image = viewModel.lockIcon
    }

}
