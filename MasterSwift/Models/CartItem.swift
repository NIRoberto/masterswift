//
//  CartItem.swift
//  MasterSwift
//
//  Created by Robert Niyitanga on 10/12/25.
//

import Foundation

struct CartItem: Identifiable, Codable {
    let id = UUID()
    let product: Product
    var quantity: Int
    
    var totalPrice: Double {
        return product.price * Double(quantity)
    }
}