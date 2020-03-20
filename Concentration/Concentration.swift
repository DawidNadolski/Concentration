//
//  Concentration.swift
//  Concentration
//
//  Created by Dawid Nadolski on 13/11/2019.
//  Copyright © 2019 Dawid Nadolski. All rights reserved.
//

import Foundation

struct Concentration {
    
    private(set) var cards = [Card]()
    private var matchedCards = 0
    var score = 0
    
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            cards.indices.filter{cards[$0].isFaceUp}.oneAndOnly
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    mutating func chooseCard(at index: Int) {
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index): chosen index not in the cards")
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                if cards[matchIndex] == cards[index] {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    score += 10
                } else {
                    score -= 1
                }
                cards[index].isFaceUp = true
            } else {
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    func calculateScore() -> Int {
        return score
    }
    
    init(numberOfPairsOfCards: Int) {
        assert(numberOfPairsOfCards > 0, "Concentration.init(at: \(numberOfPairsOfCards): you must have at least one pair of card")
        for _ in 0..<numberOfPairsOfCards {
            let card = Card()
            cards += [card, card] //adding card and another matchingCard to array
        }
        cards.shuffle()
    }
}

extension Collection {
    var oneAndOnly: Element? {
        return count == 1 ? first : nil
    }
}
