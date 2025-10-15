//
//  AddressBookView.swift
//  MasterSwift
//
//  Created by Robert Niyitanga on 10/12/25.
//

import SwiftUI

struct AddressBookView: View {
    @State private var addresses: [Address] = [
        Address(id: "1", title: "Home", street: "123 Main St", city: "New York", state: "NY", zipCode: "10001", isDefault: true),
        Address(id: "2", title: "Work", street: "456 Business Ave", city: "New York", state: "NY", zipCode: "10002", isDefault: false)
    ]
    
    var body: some View {
        List {
            ForEach(addresses) { address in
                AddressRow(address: address)
            }
            .onDelete(perform: deleteAddress)
        }
        .navigationTitle("Addresses")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Add") {
                    // Add new address
                }
            }
        }
    }
    
    private func deleteAddress(offsets: IndexSet) {
        addresses.remove(atOffsets: offsets)
    }
}

struct AddressRow: View {
    let address: Address
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                Text(address.title)
                    .font(.headline)
                
                if address.isDefault {
                    Text("DEFAULT")
                        .font(.caption)
                        .padding(.horizontal, 6)
                        .padding(.vertical, 2)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(4)
                }
                
                Spacer()
            }
            
            Text(address.street)
                .font(.subheadline)
            
            Text("\(address.city), \(address.state) \(address.zipCode)")
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .padding(.vertical, 4)
    }
}

struct Address: Identifiable {
    let id: String
    let title: String
    let street: String
    let city: String
    let state: String
    let zipCode: String
    let isDefault: Bool
}

#Preview {
    NavigationStack {
        AddressBookView()
    }
}