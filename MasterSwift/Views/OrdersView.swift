//
//  OrdersView.swift
//  MasterSwift
//
//  Created by Robert Niyitanga on 10/12/25.
//

import SwiftUI

struct OrdersView: View {
    @State private var orders: [Order] = [
        Order(id: "1", items: [], total: 24.97, status: .delivered, date: Date().addingTimeInterval(-86400)),
        Order(id: "2", items: [], total: 15.48, status: .inProgress, date: Date().addingTimeInterval(-3600)),
        Order(id: "3", items: [], total: 8.99, status: .pending, date: Date())
    ]
    
    var body: some View {
        NavigationStack {
            if orders.isEmpty {
                VStack(spacing: 20) {
                    Image(systemName: "bag")
                        .font(.system(size: 60))
                        .foregroundColor(.gray)
                    
                    Text("No orders yet")
                        .font(.title2)
                        .foregroundColor(.secondary)
                    
                    Text("Your order history will appear here")
                        .font(.body)
                        .foregroundColor(.secondary)
                }
            } else {
                List(orders) { order in
                    OrderRow(order: order)
                }
            }
        }
        .navigationTitle("Orders")
    }
}

struct OrderRow: View {
    let order: Order
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text("Order #\(order.id)")
                    .font(.headline)
                
                Spacer()
                
                Text(order.status.rawValue)
                    .font(.caption)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(order.status.color)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            
            HStack {
                Text(String(format: "$%.2f", order.total))
                    .font(.subheadline)
                    .fontWeight(.semibold)
                
                Spacer()
                
                Text(order.date, style: .date)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
        .padding(.vertical, 4)
    }
}

struct Order: Identifiable {
    let id: String
    let items: [CartItem]
    let total: Double
    let status: OrderStatus
    let date: Date
}

enum OrderStatus: String, CaseIterable {
    case pending = "Pending"
    case inProgress = "In Progress"
    case delivered = "Delivered"
    case cancelled = "Cancelled"
    
    var color: Color {
        switch self {
        case .pending: return .orange
        case .inProgress: return .blue
        case .delivered: return .green
        case .cancelled: return .red
        }
    }
}

#Preview {
    OrdersView()
}