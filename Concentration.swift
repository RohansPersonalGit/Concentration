//
//  Concentration.swift
//  Concentration
//
//  Created by Rohan Garg on 2019-12-18.
//  Copyright © 2019 RoFadez. All rights reserved.
//

import Foundation

struct Concentration
{
    public var cards = [Card]()
    var flipCount: Int
    var gameScore: Int
    private var indexofOneAndONlyFaceUpCard: Int? {
        get{
            var foundIndex: Int?
            for card in cards.indices {
                if(cards[card].isFaceUp){
                    if(foundIndex == nil){
                        foundIndex = card
                    } else {
                        return nil
                    }
                }
            }
            return foundIndex
        }
        set(newValue){
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    mutating func chooseCard(at index: Int) {
        assert(cards.indices.contains(index), "concentration.chooseCard(at: \(index)) not in cards")
        flipCount += 1
        if !cards[index].isMatched {
            if let matchIndex = indexofOneAndONlyFaceUpCard, matchIndex != index {
                if cards[matchIndex].identifier == cards[index].identifier{
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    gameScore += 2
                } else if (cards[index].seen){
                    gameScore -= 1
                }else if (cards[matchIndex].seen){
                    gameScore -= 1
                }
                else{
                    cards[index].seen = true
                    cards[matchIndex].seen = true
                }
                
                cards[index].isFaceUp = true
            } else {
                indexofOneAndONlyFaceUpCard = index
            }
        }
    }
    
    init(numberOfPairsOfCards: Int){
        flipCount = 0
        gameScore = 0
        assert(numberOfPairsOfCards>0,"Concenctration needs greater than 0 cards")
        for _ in 1...numberOfPairsOfCards{
            let card = Card()
            cards += [card, card]
        }
        //TODO: Shuffle the cards
        for i in 0..<numberOfPairsOfCards*2{
            let randomIndex = Int(arc4random_uniform(UInt32(numberOfPairsOfCards*2)))
            let temp =  cards[randomIndex]
             cards[randomIndex] = cards[i]
            cards[i] = temp
        }
    }
}
