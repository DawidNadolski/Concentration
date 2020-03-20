//
//  Card.swift
//  Concentration
//
//  Created by Dawid Nadolski on 13/11/2019.
//  Copyright © 2019 Dawid Nadolski. All rights reserved.
//

import Foundation

struct Card: Hashable {
    
    var hashValue: Int { return identifier}
    
    static func ==(lhs: Card, rhs: Card) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
    var isFaceUp = false
    var isMatched = false
    private var identifier: Int
    
    private static var identifierFactory = 0;
    
    private static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
}
