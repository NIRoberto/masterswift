//
//  CartView.swift
//  MasterSwift
//
//  Created by Robert Niyitanga on 10/12/25.
//

import SwiftUI

struct CartView: View {
    @EnvironmentObject var cartViewModel: CartViewModel
    
    var body: some View {
        NavigationStack {
            if cartViewModel.items.isEmpty {
                VStack(spacing: 20) {
                    Image(systemName: "cart")
                        .font(.system(size: 60))
                        .foregroundColor(.gray)
                    
                    Text("Your cart is empty")
                        .font(.title2)
                        .foregroundColor(.secondary)
                    
                    Text("Add some products to get started")
                        .font(.body)
                        .foregroundColor(.secondary)
                }
            } else {
                VStack {
                    List {
                        ForEach(cartViewModel.items) { item in
                            CartItemRow(item: item)
                        }
                        .onDelete(perform: deleteItems)
                    }
                    
                    // Total and Checkout
                    VStack(spacing: 16) {
                        HStack {
                            Text("Total: \(String(format: "$%.2f", cartViewModel.totalPrice))")
                                .font(.title2)
                                .fontWeight(.bold)
                            Spacer()
                        }
                        
                        Button("Checkout") {
                            // Handle checkout
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                    }
                    .padding()
                    .background(Color(.systemGray6))
                }
            }
        }
        .navigationTitle("Cart (\(cartViewModel.itemCount))")
    }
    
    private func deleteItems(offsets: IndexSet) {
        for index in offsets {
            cartViewModel.removeFromCart(cartViewModel.items[index])
        }
    }
}

struct CartItemRow: View {
    let item: CartItem
    @EnvironmentObject var cartViewModel: CartViewModel
    
    var body: some View {
        HStack {
            Image(item.product.images.first ?? "placeholder")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 50, height: 50)
                .clipShape(RoundedRectangle(cornerRadius: 8))
            
            VStack(alignment: .leading, spacing: 4) {
                Text(item.product.name)
                    .font(.headline)
                
                Text(String(format: "$%.2f", item.product.price))
                    .font(.subheadline)
                    .foregroundColor(.blue)
            }
            
            Spacer()
            
            HStack {
                Button("-") {
                    cartViewModel.updateQuantity(for: item, quantity: item.quantity - 1)
                }
                .frame(width: 30, height: 30)
                .background(Color(.systemGray5))
                .cornerRadius(15)
                
                Text("\(item.quantity)")
                    .frame(width: 30)
                
                Button("+") {
                    cartViewModel.updateQuantity(for: item, quantity: item.quantity + 1)
                }
                .frame(width: 30, height: 30)
                .background(Color(.systemGray5))
                .cornerRadius(15)
            }
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    CartView()
        .environmentObject(CartViewModel())
}
