//
//  ViewController.swift
//  pick-pocket-ios
//
//  Created by Nicholas Servidio on 1/7/17.
//
//

import UIKit

struct PreviousGuess {
    let guess: String
    let result: PickPocketResult
}

final class PickLockViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    private struct Constants {
        static let fontSize: CGFloat = 17
    }

    @IBOutlet private weak var previousGuessesTableView: UITableView!
    @IBOutlet private weak var guessLabel: CustomizableLabel!

    @IBOutlet private var digitButtons: [GuessDigitButton]! {
        didSet {
            digitButtons.sort(by: { $0.digit < $1.digit })
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }

    private func setupTableView() {
        previousGuessesTableView.transform = CGAffineTransform(rotationAngle: CGFloat.pi) // Bottom-to-top table view

        previousGuessesTableView.register(
            UINib(nibName: String(describing: PreviousGuessTableViewCell.self), bundle: nil),
            forCellReuseIdentifier: PreviousGuessTableViewCell.identifier
        )
    }

    // MARK: - UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(
                withIdentifier: PreviousGuessTableViewCell.identifier,
                for: indexPath
            ) as? PreviousGuessTableViewCell
            else { return UITableViewCell() }

        let sampleGuess = PreviousGuess(
            guess: "12\(indexPath.row)",
            result: PickPocketResult(correct: 2, misplaced: 1)
        )

        cell.configure(with: sampleGuess)

        return cell
    }
}
