//
//  Array+Only.swift
//  Memorize
//
//  Created by Ahmed Albaqawi on 5/29/20.
//  Copyright © 2020 Ahmed Albaqawi. All rights reserved.
//

import Foundation

extension Array {
    var only: Element? {
        count == 1 ? first : nil
    }
    
}
