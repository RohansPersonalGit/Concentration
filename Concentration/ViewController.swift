//
//  ViewController.swift
//  Concentration
//
//  Created by Rohan Garg on 2019-12-04.
//  Copyright © 2019 RoFadez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    // all literals with no decimal points are ints, types are only used in func arguments
    private lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOFCards)
    var numberOfPairsOFCards: Int {
        return (cardButtons.count + 1)/2
    }
    private(set) var flipCount = 0 {
        didSet {
            flipCountLabel.text = "flips: \(flipCount)"
        }
    }
    var gameScore = 0 {
        didSet {
            gameScoreLabel.text = "GameScore: \(gameScore)"
        }
    }
    var themes: [Int: Array<String>] = [0: ["👻","😂","😊","🤡","😺","🎃"], 1:["🧛🏾‍","🧟","🧙🏾‍♂️","🦸🏾‍♂️","🦹🏾","🧝🏾"], 2: ["👨🏾‍🚀","🧑🏾‍✈️","👨🏾‍🔧","🧑🏾‍🏫","🧑🏾‍🔬","🕵🏾"]]
    var theme = -1
    @IBOutlet private weak var newGameButton: UIButton!
    
    @IBOutlet private weak var flipCountLabel: UILabel!
    
    @IBOutlet private weak var gameScoreLabel: UILabel!
    @IBOutlet private var cardButtons: [UIButton]!
    //is what gets the little circle, func means function, touchcard name, inside is args
    //if there was a return value you do -> int
    @IBAction func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.firstIndex(of: sender){
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        }
    }
    
    func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 0.9465195487, green: 1, blue: 0.9535968211, alpha: 1)
            } else {
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.8470588235) : #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
                
            }
            flipCount = game.flipCount
            gameScore = game.gameScore
        }
    }
    func flipCard(withEmoji emoji: String, on button: UIButton){
        if(button.currentTitle == emoji){
            button.setTitle("", for: UIControl.State.normal)
            button.backgroundColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        }else{
            button.setTitle(emoji, for: UIControl.State.normal)
            button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }
    }
    //var emojiChoices = ["👻","😂","😊","🤡","😺","🎃"]
    private var removedEmojis = [String]()

    private var emoji = [Int: String]()
    func emoji(for card: Card) -> String {
        if(theme == -1){
            theme = Int(arc4random_uniform(UInt32(themes.count)))
        }
        
        if emoji[card.identifier] == nil, let count = themes[theme]?.count,count > 0 {
            let randomIndex = count.arc4random
            if let removeEmoji = themes[theme]?.remove(at: randomIndex){
                print("hit")
                emoji[card.identifier] = removeEmoji
                removedEmojis.append(removeEmoji)
            }
        }
        return emoji[card.identifier] ?? ""
    }
    
    @IBAction func triggerNewGame(_ sender: Any) {
        game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
        flipCount = 0
        gameScore = 0
        for index in cardButtons.indices{
            let button = cardButtons[index]
            button.setTitle("", for: UIControl.State.normal)
            button.backgroundColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        }
        themes[theme]?.append(contentsOf: removedEmojis)
        theme = -1
        removedEmojis.removeAll()
    }
    
}

extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))

        }
        else if self < 0 {
            return -Int(arc4random_uniform(UInt32(self)))
        }
        else {
            return 0
        }
    }
}
