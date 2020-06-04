//
//  MemoryGame.swift
//  Memorize
//
//  Created by Ahmed Albaqawi on 5/21/20.
//  Copyright © 2020 Ahmed Albaqawi. All rights reserved.
//

import Foundation

//we had to extend to Protocol Equatable, in order to use the operator (==)

struct MemoryGame<CardContent> where CardContent: Equatable {
    //Array of objects
    var cards: Array<Card>
    var theme: GameTheme
    var score: Int = 0

    //MARK - Must watch Lecture #4 to review how code got refactored and minimized - indexOfTheOneAndOnlyFaceUpCard
    
    //to ensure we follow best coding style and no error prone ways - we want a computed value from the cards only as a single point of truth. this is done with setters and getters
    var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get {
            //[Int] is short hand for Array<Int>
            //$0 is the first arrgument of the filter func which is index
            let faceUpCardIndicies = cards.indices.filter { cards[$0].isFaceUp }
            //get back the first value - the 1st match!
            return faceUpCardIndicies.only
        }
        set {
            for index in cards.indices {
                // newValue is a special var that is an Optional, and an Int is NEVER true to an optional nil
                // then they both have to match in Int values
                    cards[index].isFaceUp = index == newValue // if true or false on 1 line, setting isFaceUp only if index in itteration = the pressed card index
               
            }
        }
    }
    
    struct Card: Identifiable {
        var id: Int
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var isSeen: Bool = false
        var content: CardContent //the value of the generic Data type
    }
    // actions done on a card, but as card is  Struct it is  always passed by value
    //the key word mutating allows us to changes things that are in the heep like the MemoryGame and all its functions
    // mutating gives us this option to change things in the strcut in the heep
    mutating func choose(card: Card) {
        print("card chosen:  \(card)")
        // get the 1st card, the card is not face down and not highlighted as matched
        if let chosenIndex: Int = cards.firstIndex(matching: card), !cards[chosenIndex].isFaceUp, !cards[chosenIndex].isMatched {
            print("chosenIndex : \(chosenIndex)")
            // if found a matching card
            // here we use the getter of indexOfTheOneAndOnlyFaceUpCard
            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                    self.score += 2
                } else {
                    //no match
                    print("this card is seen now",cards[chosenIndex].isSeen)
                    print("this card is seen now",cards[chosenIndex].isSeen)
                    if cards[chosenIndex].isSeen {
                        score -= 1
                        print("this card is seen now",cards[chosenIndex].isSeen)
                    }
                    if cards[potentialMatchIndex].isSeen {
                        score -= 1
                        print("this card is seen now",cards[chosenIndex].isSeen)
                    }
                    cards[chosenIndex].isSeen = true
                    cards[potentialMatchIndex].isSeen = true
                }
                //no need to keep tracking this is nil or not as we have implimented the values in set and get
//                indexOfTheOneAndOnlyFaceUpCard = nil
                //this next line will flip cards open / face up on mismatch
                cards[chosenIndex].isFaceUp = true
            } else {
               // only 1 card up  at start of game, here we use the setter of indexOfTheOneAndOnlyFaceUpCard
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
            }
        }

    }
    
    init(numberOfPairsOfCards: Int, theme: GameTheme, score: Int = 0, cardContentFactory: (Int) -> CardContent) {
        cards = Array<Card>()
        self.theme = theme
        for pairIndex in 0..<numberOfPairsOfCards {
            //to retreive every content in array
            let content = cardContentFactory(pairIndex)
            cards.append(Card(id: pairIndex*2, content: content))
            cards.append(Card(id: pairIndex*2+1, content: content))
        }
        self.cards = cards.shuffled()
    }
    
}
