//
//  ContentView.swift
//  Memorize
//
//  Created by Ahmed Albaqawi on 5/20/20.
//  Copyright © 2020 Ahmed Albaqawi. All rights reserved.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    //access the view model - remember where to create this EmojiMemoryGame A: in the Scene Delegate
    //so we tell this View every time EmojiMemoryGame gets a change, then we react/redraw to whatever changed - in our case a card/or pair of cards
    @ObservedObject var viewModel: EmojiMemoryGame
    var body: some View {
        VStack {
            Text("\(viewModel.model.score)").font(.system(size: 50, weight: .bold, design: .serif)).padding(.top, 8)
            Grid(viewModel.cards) {card in
                CardView(card: card, themeColor: self.viewModel.model.theme.gameBackgroundColor).onTapGesture {
                        self.viewModel.choose(card: card)
                    }
            .padding(8)
                }
            .padding()
            .foregroundColor(Color.pink)// To prove overriding is element to upper
            //.font(viewModel.cards.count < 10 ? .largeTitle : .body)
            
            Button(action: {
                self.viewModel.resetGame()
            }) {
                Text("Start Over!").fontWeight(.bold)
                .font(.title)
                .padding()
                    .background(viewModel.model.theme.gameBackgroundColor)
                .foregroundColor(.white)
                .cornerRadius(40)
                .overlay(
                    RoundedRectangle(cornerRadius: 40)
                        .stroke(Color.purple, lineWidth: 5)
                )    //.frame(minWidth: 0, maxWidth: .infinity)

                .padding(8)

            }
        }
    }
}

struct CardView: View {
    //var isFaceUp: Bool //moved to model
    var card: MemoryGame<String>.Card
    var themeColor: Color = Color.orange
    
    var body: some View {
        GeometryReader (content: { geometry in
            self.body(for: geometry.size)
        })
    }
    
    //this is a trick to clean up and remove need to use self. on all objects
    func body(for size: CGSize) -> some View {
         ZStack {
                       if self.card.isFaceUp {
                           RoundedRectangle(cornerRadius: cornerRadius).fill(Color.white)
                           RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: edgeLineWidth)
                           Text(self.card.content)
                       } else {
                        if !card.isMatched {
                            RoundedRectangle(cornerRadius: cornerRadius).fill(themeColor)
                        }
                       }
                       //we want to make things dynamic where we do not have to worry on aspect ratio or device rotations
                   }.font(Font.system(size: fontSize(for: size)))
                   //.aspectRatio(2/3, contentMode: .fit)
    }
    
    // MARK: - Drawing Constants
    let cornerRadius: CGFloat = 10.0
    let edgeLineWidth: CGFloat = 3
    //let fontScaleFactor: CGFloat = 0.75
    func fontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * 0.75
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiMemoryGameView(viewModel: EmojiMemoryGame())
    }
}
