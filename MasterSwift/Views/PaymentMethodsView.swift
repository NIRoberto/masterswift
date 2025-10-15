//
//  PaymentMethodsView.swift
//  MasterSwift
//
//  Created by Robert Niyitanga on 10/12/25.
//

import SwiftUI

struct PaymentMethodsView: View {
    @State private var paymentMethods: [PaymentMethod] = [
        PaymentMethod(id: "1", type: .card, title: "Visa ****1234", isDefault: true),
        PaymentMethod(id: "2", type: .card, title: "Mastercard ****5678", isDefault: false),
        PaymentMethod(id: "3", type: .applePay, title: "Apple Pay", isDefault: false)
    ]
    
    var body: some View {
        List {
            ForEach(paymentMethods) { method in
                PaymentMethodRow(method: method)
            }
            .onDelete(perform: deletePaymentMethod)
        }
        .navigationTitle("Payment Methods")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Add") {
                    // Add new payment method
                }
            }
        }
    }
    
    private func deletePaymentMethod(offsets: IndexSet) {
        paymentMethods.remove(atOffsets: offsets)
    }
}

struct PaymentMethodRow: View {
    let method: PaymentMethod
    
    var body: some View {
        HStack {
            Image(systemName: method.type.icon)
                .foregroundColor(method.type.color)
                .frame(width: 30)
            
            VStack(alignment: .leading) {
                Text(method.title)
                    .font(.headline)
                
                if method.isDefault {
                    Text("Default")
                        .font(.caption)
                        .foregroundColor(.blue)
                }
            }
            
            Spacer()
        }
        .padding(.vertical, 4)
    }
}

struct PaymentMethod: Identifiable {
    let id: String
    let type: PaymentType
    let title: String
    let isDefault: Bool
}

enum PaymentType {
    case card
    case applePay
    case paypal
    
    var icon: String {
        switch self {
        case .card: return "creditcard"
        case .applePay: return "applelogo"
        case .paypal: return "p.circle"
        }
    }
    
    var color: Color {
        switch self {
        case .card: return .blue
        case .applePay: return .black
        case .paypal: return .blue
        }
    }
}

#Preview {
    NavigationStack {
        PaymentMethodsView()
    }
}