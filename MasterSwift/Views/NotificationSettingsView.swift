//
//  NotificationSettingsView.swift
//  MasterSwift
//
//  Created by Robert Niyitanga on 10/12/25.
//

import SwiftUI

struct NotificationSettingsView: View {
    @State private var orderUpdates = true
    @State private var promotions = false
    @State private var newProducts = true
    @State private var pushNotifications = true
    
    var body: some View {
        Form {
            Section("Order Notifications") {
                Toggle("Order Updates", isOn: $orderUpdates)
                Toggle("Delivery Status", isOn: $pushNotifications)
            }
            
            Section("Marketing") {
                Toggle("Promotions & Offers", isOn: $promotions)
                Toggle("New Products", isOn: $newProducts)
            }
        }
        .navigationTitle("Notifications")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        NotificationSettingsView()
    }
}