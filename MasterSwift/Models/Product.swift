//
//  Product.swift
//  MasterSwift
//
//  Created by Robert Niyitanga  on 10/13/25.
//

import Foundation

struct Product: Identifiable, Hashable, Codable {
    let id: String
    let name: String
    let category: String
    let price: Double
    let description: String
    let images: [String]
}
