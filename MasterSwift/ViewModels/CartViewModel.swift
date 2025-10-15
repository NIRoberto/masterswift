//
//  CartViewModel.swift
//  MasterSwift
//
//  Created by Robert Niyitanga on 10/12/25.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestore

@MainActor
class CartViewModel: ObservableObject {
    @Published var items: [CartItem] = []
    
    var totalPrice: Double {
        items.reduce(0) { $0 + $1.totalPrice }
    }
    
    var itemCount: Int {
        items.reduce(0) { $0 + $1.quantity }
    }
    
    init() {
        Task {
            await loadCart()
        }
    }
    
    func addToCart(_ product: Product) {
        print("🛍️ Adding to cart: \(product.name)")
        if let index = items.firstIndex(where: { $0.product.id == product.id }) {
            items[index].quantity += 1
            print("✅ Updated quantity to \(items[index].quantity) for \(product.name)")
        } else {
            items.append(CartItem(product: product, quantity: 1))
            print("✅ Added new item to cart: \(product.name)")
        }
        Task {
            await saveCart()
        }
    }
    
    func removeFromCart(_ item: CartItem) {
        print("🗑️ Removing from cart: \(item.product.name)")
        items.removeAll { $0.id == item.id }
        print("✅ Item removed from cart")
        Task {
            await saveCart()
        }
    }
    
    func updateQuantity(for item: CartItem, quantity: Int) {
        if let index = items.firstIndex(where: { $0.id == item.id }) {
            if quantity > 0 {
                items[index].quantity = quantity
            } else {
                removeFromCart(item)
                return
            }
        }
        Task {
            await saveCart()
        }
    }
    
    func clearCart() {
        print("🗑️ Clearing entire cart (\(items.count) items)")
        items.removeAll()
        print("✅ Cart cleared")
        Task {
            await saveCart()
        }
    }
    
    private func saveCart() async {
        guard let uid = Auth.auth().currentUser?.uid else { 
            print("⚠️ No user logged in, cannot save cart")
            return 
        }
        
        print("🔄 Saving cart with \(items.count) items for user: \(uid)")
        
        let cartData = items.map { item -> [String: Any] in
            [
                "productId": item.product.id,
                "productName": item.product.name,
                "productCategory": item.product.category,
                "productPrice": item.product.price,
                "productDescription": item.product.description,
                "productImages": item.product.images,
                "quantity": item.quantity
            ]
        }
        
        do {
            try await Firestore.firestore().collection("carts").document(uid).setData(["items": cartData])
            print("✅ Cart saved successfully to Firestore")
        } catch {
            print("❌ Failed to save cart: \(error.localizedDescription)")
        }
    }
    
    private func loadCart() async {
        guard let uid = Auth.auth().currentUser?.uid else { 
            print("⚠️ No user logged in, cannot load cart")
            return 
        }
        
        print("🔄 Loading cart for user: \(uid)")
        
        do {
            let snapshot = try await Firestore.firestore().collection("carts").document(uid).getDocument()
            
            if let data = snapshot.data(),
               let cartArray = data["items"] as? [[String: Any]] {
                var loadedItems: [CartItem] = []
                
                for itemData in cartArray {
                    if let productId = itemData["productId"] as? String,
                       let productName = itemData["productName"] as? String,
                       let productCategory = itemData["productCategory"] as? String,
                       let productPrice = itemData["productPrice"] as? Double,
                       let productDescription = itemData["productDescription"] as? String,
                       let productImages = itemData["productImages"] as? [String],
                       let quantity = itemData["quantity"] as? Int {
                        
                        let product = Product(
                            id: productId,
                            name: productName,
                            category: productCategory,
                            price: productPrice,
                            description: productDescription,
                            images: productImages
                        )
                        
                        loadedItems.append(CartItem(product: product, quantity: quantity))
                    }
                }
                
                self.items = loadedItems
                print("✅ Cart loaded successfully with \(loadedItems.count) items")
            } else {
                print("ℹ️ No cart data found, starting with empty cart")
            }
        } catch {
            print("❌ Failed to load cart: \(error.localizedDescription)")
        }
    }
}