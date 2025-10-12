//
//  Item.swift
//  MasterSwift
//
//  Created by Robert Niyitanga  on 10/12/25.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
