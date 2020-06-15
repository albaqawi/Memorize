//
//  Array+Identifiable.swift
//  Memorize
//
//  Created by Ahmed Albaqawi on 5/28/20.
//  Copyright © 2020 Ahmed Albaqawi. All rights reserved.
//

import Foundation
//to fix the bogus function used perviously here and in model in leacure 3
// the PURE solution was only to convert the return value of function from Int to an Optional with Int data type associated!!!
 
extension Array where Element: Identifiable {
    func firstIndex(matching: Element) -> Int? {
        for index in 0..<self.count {
            if self[index].id == matching.id {
                return index
            }
        }
        
        return nil
    }
}
