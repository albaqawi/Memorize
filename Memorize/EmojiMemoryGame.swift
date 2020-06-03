//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Ahmed Albaqawi on 5/21/20.
//  Copyright © 2020 Ahmed Albaqawi. All rights reserved.
//

import SwiftUI

enum GameTheme: Int, CaseIterable {
    case halloween, future, faces, sports, jobs, stuff
    
    var emojisPerTheme: [String] {
        switch self {
        case .halloween:
            return ["🧹","🦇","🦉","🧛🏼‍♂️","🎃","🧙🏼‍♂️"]
        case .future:
            return ["🤖","🦾","🚀","🦿"]
        case .faces:
            return ["😆","😇","🤩","😓","😡"]
        case .sports:
            return ["🏄🏼‍♂️","⛹🏾‍♂️","🏌🏾","⚽️"]
        case .jobs:
            return ["👩🏾‍✈️","💂🏻‍♂️","👷🏽‍♂️","👨‍🎨","🤴🏻"]
        case .stuff:
            return ["📱"] //"🧯","💸","🧰",
//        default:
//            return [""]
        }
    }
    var title: String {
        switch self {
        case .halloween: return "Halloween"
        case .future: return "Future"
        case .faces: return "Faces"
        case .sports: return "Sports"
        case .jobs: return "Jobs"
        case .stuff: return "Stuff"
        
        default:
            return "none"
        }
        
    }
    
    var gameBackgroundColor: Color {
        switch self {
        case .halloween:
            return Color(.orange)
        case .future:
            return Color(.darkGray)
        case .faces:
            return Color(.yellow)
        case .sports:
            return Color(.systemRed)
        case .jobs:
            return Color(.systemPink)
        case .stuff:
            return Color(.magenta)
        default:
            return Color(.blue)
        }
    }
}

// MARK: - The ViewModel
//to make connection reative we add ptotocol ObservableObject to gain the function ObservableObjectPublisher
class EmojiMemoryGame: ObservableObject {
    //this comes with the Protocol - completely free no need to type
    // i place it here just to remember it comes with no need to setup
    // just use directly
    //var objectWillChange: ObservableObjectPublisher but we do not do this
    //we add @Published in front of what we want to listen too like model!

    //access and init the model in Class so we have 1 access point - pass by reference!
    //instest of model: MemoryGame<String> = MemoryGame<String> as made it advanced with function on TYPE!
    // Ben comment - investigate the private key word! with @Published ?
    @Published var model: MemoryGame<String> = EmojiMemoryGame.createMemoryGame()
    //
    //static to be able to avoid the catch 22 case of setting something from within with initialization of model
    //static makes the function on the TYPE not in instance so always ready
     static func createMemoryGame() -> MemoryGame<String> {
        let theme = GameTheme.allCases.randomElement()!
        print("The theme is \(theme.title)")
        
        let emojis = theme.emojisPerTheme
        
        //let emojis = themeEmoji.sh//["👻","🤖","🧠","👨🏽‍🎤","🦾","🧞‍♂️","🕴🏻","🕴🏿","🧶","🦊","🎒","🐣"].shuffled()
        let randomNumberOfPairs = emojis.count //Int.random(in: 2...5)
        return MemoryGame<String>(numberOfPairsOfCards: randomNumberOfPairs, theme: theme) { pairIndex in
            //to retreive every content in array
            return emojis[pairIndex]
        }
        
    }
    
    func resetGame() {
        self.model = Self.createMemoryGame()
    }
        
    // MARK: - Access the model
    //return all cards
    var cards: Array<MemoryGame<String>.Card> {
        //Assignment 1: Task 2 shuffle the cards - not sure
        // In assignment 2 if we keep shuffle here it will force redraw all the cards in diff order, so this needs to be in emoji decliration
        model.cards//.shuffled()
    }
    

    
    
    // MARK: - Intents
    //select a pickede card
    func choose(card: MemoryGame<String>.Card) {
// no need for this any more as @Published takes care of this
//        objectWillChange.send()
        model.choose(card: card)
    }
}

struct EmojiMemoryGame_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
