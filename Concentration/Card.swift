//
//  Card.swift
//  Concentration
//
//  Created by Rohan Garg on 2019-12-18.
//  Copyright © 2019 RoFadez. All rights reserved.
//

import Foundation

struct Card: Hashable
{
    func hash(int hasher: inout Hasher) {
        hasher.combine(identifier)
    }
    var isFaceUp  = false
    var isMatched = false
    var seen = false
    public var identifier : Int
    
    private static var identifierFactory = 0
    private static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }

    init(){
        self.identifier = Card.getUniqueIdentifier()
    }
    
}
