//
//  ContentView.swift
//  MasterSwift
//
//  Created by Robert Niyitanga on 10/12/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    let products = [
        Product(
            id: "1",
            name: "Cheeseburger",
            category: "Fast Food",
            price: 4.99,
            description: "A delicious grilled cheeseburger with fresh lettuce and tomato.",
            images: ["1", "1"]
        ),
        Product(
            id: "2",
            name: "Margherita Pizza",
            category: "Pizza",
            price: 8.49,
            description: "Classic Margherita pizza with mozzarella, tomato sauce, and basil.",
            images: ["1"]
        ),
        Product(
            id: "3",
            name: "Fruit Smoothie",
            category: "Beverages",
            price: 3.99,
            description: "A refreshing mix of banana, mango, and pineapple.",
            images: ["1"]
        )
    ]
    
    @State private var count = 0
    
    
    var body: some View {
        NavigationStack {
            
            VStack(spacing: 20) {
                    Text("Count: \(count)")
                        .font(.largeTitle)

                    Button("Increment") {
                        count += 1  // ✅ changing state
                    }
                }
            
            List(products, id: \.id) { product in
                NavigationLink(value: product) {
                    HStack(spacing: 15) {
                        Image(product.images.first ?? "placeholder")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 60, height: 60)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                        
                        VStack(alignment: .leading, spacing: 5) {
                            Text(product.name)
                                .font(.headline)
                            
                            Text(product.category)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            
                            Text(String(format: "$%.2f", product.price))
                                .font(.subheadline)
                                .bold()
                                .foregroundColor(.blue)
                        }
                    }
                    .padding(.vertical, 5)
                }
            }
            .navigationTitle("Products")
                      .navigationDestination(for: Product.self) { product in
                          ProductDetailView(product: product)
            }
        }
    }
    
}


// MARK: - Detail View
struct ProductDetailView: View {
    let product: Product
    
    var body: some View {
        VStack(spacing: 16) {
            Image(product.images.first ?? "placeholder")
                .resizable()
                .scaledToFit()
                .frame(height: 200)
                .clipShape(RoundedRectangle(cornerRadius: 15))
            
            Text(product.name)
                .font(.title)
                .fontWeight(.bold)
            
            Text(product.description)
                .font(.body)
                .foregroundColor(.secondary)
                .padding()
            
            Text(String(format: "$%.2f", product.price))
                .font(.title2)
                .foregroundColor(.blue)
            
            Spacer()
        }
        .padding()
        .navigationTitle(product.name)
    }
}



#Preview {
    ContentView()
}
