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
            Text("\(viewModel.score)").font(.system(size: 50, weight: .bold, design: .serif)).padding(.top, 50)
            Grid(viewModel.cards) {card in
                CardView(card: card, themeColor: self.viewModel.color).onTapGesture {
                        self.viewModel.choose(card: card)
                    }
            .padding(8)
                }
            .padding(.top,0)
            .foregroundColor(Color.pink)// To prove overriding is delegated inward
            //.font(viewModel.cards.count < 10 ? .largeTitle : .body)
            
            Button(action: {
                self.viewModel.resetGame()
            }) {
                Text("Start Over!").fontWeight(.bold)
                .font(.title)
                .padding()
                    .background(viewModel.color)
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
    //remember ViewBuilder will never show the LIST of VIEWS! if you have any variables or papamaters... make sure everything is called in as functions 
    @ViewBuilder
    private func body(for size: CGSize) -> some View {
        //now we do the branch logic ahead to check for matching
        //following line will ensure we remove any pair already matched
        if card.isFaceUp || !card.isMatched {
                ZStack {
                Pie(startAngle: Angle.degrees(0-90), endAngle: Angle.degrees(110-90),clockwise: true)
                    .padding(5).opacity(0.7)
                Text(self.card.content)
                    .font(Font.system(size: fontSize(for: size)))
             }
            //we showed 2 ways to use the modifer in the long and short  form
             //.modifier(Cardify(isFaceUp: card.isFaceUp, cardColor: gradiantCardColor))
                .cardify(isFaceUp: card.isFaceUp, cardColor: gradiantColor(for: themeColor))
        }
    }
    
    private func gradiantColor(for card: Color) -> LinearGradient {
        let gradientLayer = Gradient(colors: [Color.white, card])
        let gradiantCardColor = LinearGradient(gradient: gradientLayer, startPoint: .leading, endPoint: .topTrailing)
        return gradiantCardColor
    }
    
    // MARK: - Drawing Constants
    private func fontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * 0.7
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        game.choose(card: game.cards[0])
        
        return EmojiMemoryGameView(viewModel: game)
    }
}
