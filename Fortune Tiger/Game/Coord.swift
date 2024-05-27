//
//  Coord.swift
//  Fortune Tiger
//
//  Created by Мирсаит Сабирзянов on 26.05.2024.
//

import Foundation
import SwiftUI

struct Coord : Equatable {
    init(_ x: Int, _ y: Int) {
        self.x = x
        self.y = y
    }
    
    var x: Int
    var y: Int
}
