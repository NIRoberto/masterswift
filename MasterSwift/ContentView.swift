//
//  ContentView.swift
//  MasterSwift
//
//  Created by Robert Niyitanga on 10/12/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    
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
    
    var body: some View {
        NavigationStack {
            VStack {
                // Welcome header
                if let user = authViewModel.currentUser {
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Welcome back,")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            Text(user.fullName)
                                .font(.title2)
                                .fontWeight(.semibold)
                        }
                        Spacer()
                        
                        Button("Logout") {
                            authViewModel.signOut()
                        }
                        .font(.subheadline)
                        .foregroundColor(.red)
                    }
                    .padding(.horizontal)
                }
                
                // Featured section
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 15) {
                        ForEach(1...5, id: \.self) { i in
                            Text("Featured \(i)")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.blue)
                                .cornerRadius(10)
                        }
                    }
                    .padding(.horizontal)
                }
                
                // Products list
                List(products, id: \.id) { product in
                    NavigationLink(value: product) {
                        ProductRowView(product: product)
                    }
                }
                .listStyle(PlainListStyle())
            }
            .navigationTitle("Products")
            .navigationDestination(for: Product.self) { product in
                ProductDetailView(product: product)
            }
        }
    }
}

struct ProductRowView: View {
    let product: Product
    
    var body: some View {
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
            
            Spacer()
        }
        .padding(.vertical, 8)
    }
}

// MARK: - Detail View
struct ProductDetailView: View {
    let product: Product
    @EnvironmentObject var cartViewModel: CartViewModel
    @State private var showingAddedToCart = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Product Image
                Image(product.images.first ?? "placeholder")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 250)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                
                VStack(alignment: .leading, spacing: 16) {
                    // Product Info
                    VStack(alignment: .leading, spacing: 8) {
                        Text(product.name)
                            .font(.title)
                            .fontWeight(.bold)
                        
                        Text(product.category)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 4)
                            .background(Color(.systemGray6))
                            .cornerRadius(8)
                    }
                    
                    // Price
                    Text(String(format: "$%.2f", product.price))
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(.blue)
                    
                    // Description
                    Text(product.description)
                        .font(.body)
                        .foregroundColor(.secondary)
                        .lineLimit(nil)
                    
                    Spacer(minLength: 20)
                    
                    // Add to Cart Button
                    Button {
                        cartViewModel.addToCart(product)
                        showingAddedToCart = true
                    } label: {
                        HStack {
                            Image(systemName: "cart.badge.plus")
                            Text("Add to Cart")
                        }
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(12)
                    }
                }
                .padding(.horizontal)
            }
        }
        .navigationTitle(product.name)
        .navigationBarTitleDisplayMode(.inline)
        .alert("Added to Cart!", isPresented: $showingAddedToCart) {
            Button("OK") { }
        } message: {
            Text("\(product.name) has been added to your cart.")
        }
    }
}



#Preview {
    ContentView()
        .environmentObject(AuthViewModel())
        .environmentObject(CartViewModel())
}
