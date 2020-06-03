//
//  Grid.swift
//  Memorize
//
//  Created by Ahmed Albaqawi on 5/28/20.
//  Copyright © 2020 Ahmed Albaqawi. All rights reserved.
//

import SwiftUI

//this is a care a little bit .... discussion
//this is perfect example of using Generics with conditions for Contraints and Gains
//so we are using Generic DataStract Grid with Protocols View and Identifiable to have a powerful feature
struct Grid<Item, ItemView>: View where Item: Identifiable, ItemView: View {
    var items : [Item] // or can write it as follows to declare and instantiate items = [Item]()
    var viewForItem: (Item) -> ItemView
    
    //if we want to show ForEach like in a view Builder HStack or VStack! we use external name of param ForEach
    //if we want the param name to be ommited then we use _, this is the perfect example to use _ in Swift
    // @escaping allows to escape the initilizer without getting called!!! as this is a view and will be built later
    // think of it as a View will need to use paramaters with this grid! @escaping helps us aviod the memory cycle situation on the view level when it is kept in heap 
    init(_ items: [Item],_ viewForItem: @escaping (Item) -> ItemView) {
        self.items = items
        self.viewForItem = viewForItem
    }
    
    //we did the 3 stage func below to avoid the self.body typing we can still keep as this is!
    
    var body: some View {
        //we need to know how much space given to draw grid
        
        GeometryReader { geometry in
            self.body(for: GridLayout(itemCount: self.items.count, in: geometry.size))
        }
    }
        
        func body(for layout: GridLayout) -> some View {
                print(items)
                return ForEach(items) { item in
                    self.body(for: item,in: layout)
                }
        }
    
    func body(for item: Item, in layout: GridLayout) -> some View {
        //the Bang ! helps force unwrap the Optional type into Int data type to use it and resolve the Bogus situation
            let index = items.firstIndex(matching: item)!
        //
            return viewForItem(item)
            .frame(width: layout.itemSize.width, height: layout.itemSize.height)
            .position(layout.location(ofItemAt: index))
    }
}
