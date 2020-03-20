//
//  ViewController.swift
//  Concentration
//
//  Created by Dawid Nadolski on 10/11/2019.
//  Copyright © 2019 Dawid Nadolski. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // lazy means that the game will be initialzied when we use it the first time
    private lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    
    var numberOfPairsOfCards: Int {
        return (cardButtons.count + 1) / 2
    }
    
    private(set) var flipCount = 0 {
        didSet {
            flipCountLabel.text = "Flips: \(flipCount)";
        }
    }
    
    private(set) var score = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    
    @IBOutlet private weak var flipCountLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet private var cardButtons: [UIButton]!
    
    @IBAction private func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            game.chooseCard(at: cardNumber)
            score = game.calculateScore()
            updateViewFromModel()
        } else {
            print("button is not in cardButtons")
        }
    }
    
    @IBAction func newGame(_ sender: UIButton) {
        game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
        emojiChoices = emojiThemes[emojiThemes.count.arc4random]
        emoji = [:]
        flipCount = 0
        updateViewFromModel()
    }
    
    private func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 0.3792304397, green: 0.7682200074, blue: 0.6881307364, alpha: 0.6879013271)
            } else {
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 0) : #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
                button.isEnabled = card.isMatched ? false : true
            }
        }
    }
    
    private var emojiThemes = ["🐶🐱🐭🐼🐨🐻🦊🐷🐮🐵", "🚗🚌🛩🏎🚜🏍🚲🚁🚀🚋", "⚽🏀🏈⚾🏐🏉🎱🎾🏓🏸",
                               "🍏🍐🍊🍋🍌🍉🍇🍓🍒🍑", "😎😂😍😘🤔😖😨🤐😴😤", "❤️💛💚💙💔💜💖💝💗💘"]
    lazy private var emojiChoices: String = emojiThemes[emojiThemes.count.arc4random]
    
    private var emoji = [Card:String]()
    
    private func emoji(for card: Card) -> String {
        if emoji[card] == nil, emojiChoices.count > 0 {
            let randomStringIndex = emojiChoices.index(emojiChoices.startIndex, offsetBy: emojiChoices.count.arc4random)
            emoji[card] = String(emojiChoices.remove(at: randomStringIndex))
        }
        
        return emoji[card] ?? "?"
    }
}

extension Int {
    var arc4random: Int {
        if self > 0{
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
    }
}
