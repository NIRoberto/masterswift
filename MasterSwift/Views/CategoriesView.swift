//
//  CategoriesView.swift
//  MasterSwift
//
//  Created by Robert Niyitanga on 10/12/25.
//

import SwiftUI

struct CategoriesView: View {
    let categories = ["Fast Food", "Pizza", "Beverages", "Desserts", "Salads", "Asian"]
    
    let products = [
        Product(id: "1", name: "Cheeseburger", category: "Fast Food", price: 4.99, description: "A delicious grilled cheeseburger with fresh lettuce and tomato.", images: ["1"]),
        Product(id: "2", name: "Margherita Pizza", category: "Pizza", price: 8.49, description: "Classic Margherita pizza with mozzarella, tomato sauce, and basil.", images: ["1"]),
        Product(id: "3", name: "Fruit Smoothie", category: "Beverages", price: 3.99, description: "A refreshing mix of banana, mango, and pineapple.", images: ["1"]),
        Product(id: "4", name: "Chocolate Cake", category: "Desserts", price: 5.99, description: "Rich chocolate cake with cream frosting.", images: ["1"]),
        Product(id: "5", name: "Caesar Salad", category: "Salads", price: 6.49, description: "Fresh romaine lettuce with caesar dressing.", images: ["1"])
    ]
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(categories, id: \.self) { category in
                    NavigationLink(destination: CategoryProductsView(category: category, products: products.filter { $0.category == category })) {
                        HStack {
                            Image(systemName: categoryIcon(for: category))
                                .foregroundColor(.blue)
                                .frame(width: 30)
                            
                            Text(category)
                                .font(.headline)
                            
                            Spacer()
                            
                            Text("\(products.filter { $0.category == category }.count)")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                        .padding(.vertical, 8)
                    }
                }
            }
            .navigationTitle("Categories")
        }
    }
    
    private func categoryIcon(for category: String) -> String {
        switch category {
        case "Fast Food": return "hamburger"
        case "Pizza": return "circle.fill"
        case "Beverages": return "cup.and.saucer"
        case "Desserts": return "birthday.cake"
        case "Salads": return "leaf"
        case "Asian": return "chopsticks"
        default: return "fork.knife"
        }
    }
}

struct CategoryProductsView: View {
    let category: String
    let products: [Product]
    
    var body: some View {
        List(products, id: \.id) { product in
            NavigationLink(value: product) {
                ProductRowView(product: product)
            }
        }
        .navigationTitle(category)
        .navigationDestination(for: Product.self) { product in
            ProductDetailView(product: product)
        }
    }
}

#Preview {
    CategoriesView()
}