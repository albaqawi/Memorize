//
//  Cardify.swift
//  Memorize
//
//  Created by Ahmed Albaqawi on 6/6/20.
//  Copyright © 2020 Ahmed Albaqawi. All rights reserved.
//

import SwiftUI


//we want this code to be a reusable code, independent and based on Generics. So we only want it to make a card out of any view! so we leave matching is in the game logic and not in here!
struct Cardify: ViewModifier {
    var isFaceUp: Bool
    var cardColor: LinearGradient
    
    
    private let cornerRadius: CGFloat = 10.0
    private let edgeLineWidth: CGFloat = 3
    //the content in our code is the ZStack that calls it from View
    func body(content: Content) -> some View {
        ZStack {
            if isFaceUp {
                RoundedRectangle(cornerRadius: cornerRadius).fill(Color.white)
                RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: edgeLineWidth)
                //this is the ZStack passed into this modifer
                content
            } else {
                RoundedRectangle(cornerRadius: cornerRadius).fill(cardColor)
               RoundedRectangle(cornerRadius:  cornerRadius).stroke(lineWidth: edgeLineWidth)
            }
        }
    }
}

extension View {
   func cardify(isFaceUp: Bool, cardColor: LinearGradient) -> some View {
    self.modifier(Cardify(isFaceUp: isFaceUp, cardColor: cardColor))
    }
}
