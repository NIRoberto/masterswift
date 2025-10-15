//
//  RootView.swift
//  MasterSwift
//
//  Created by Robert Niyitanga on 10/12/25.
//

import SwiftUI

struct RootView: View {
    @StateObject var authViewModel = AuthViewModel()
    @StateObject var cartViewModel = CartViewModel()
    
    var body: some View {
        Group {
            if authViewModel.userSession != nil {
                MainTabView()
            } else {
                LoginView()
            }
        }
        .environmentObject(authViewModel)
        .environmentObject(cartViewModel)
    }
}

struct MainTabView: View {
    var body: some View {
        TabView {
            ContentView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
            
            CategoriesView()
                .tabItem {
                    Image(systemName: "square.grid.2x2")
                    Text("Categories")
                }
            
            CartView()
                .tabItem {
                    Image(systemName: "cart.fill")
                    Text("Cart")
                }
            
            OrdersView()
                .tabItem {
                    Image(systemName: "bag.fill")
                    Text("Orders")
                }
            
            ProfileView()
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Profile")
                }
        }
        .accentColor(.blue)
    }
}

#Preview {
    RootView()
}
