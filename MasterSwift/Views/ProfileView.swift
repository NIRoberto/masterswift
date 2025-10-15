//
//  ProfileView.swift
//  MasterSwift
//
//  Created by Robert Niyitanga on 10/12/25.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @State private var showingDeleteAlert = false
    
    var body: some View {
        NavigationStack {
            if let user = viewModel.currentUser {
                List {
                    // User Profile Section
                    Section {
                        HStack {
                            Text(user.initials)
                                .font(.title)
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                                .frame(width: 72, height: 72)
                                .background(Color.blue)
                                .clipShape(Circle())
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text(user.fullName)
                                    .font(.title3)
                                    .fontWeight(.semibold)
                                
                                Text(user.email)
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                            
                            Spacer()
                        }
                        .padding(.vertical, 8)
                    }
                    
                    // Account Settings
                    Section("Account") {
                        NavigationLink(destination: EditProfileView()) {
                            SettingsRowView(imageName: "person.circle",
                                          title: "Edit Profile",
                                          tintColor: .blue)
                        }
                        
                        NavigationLink(destination: AddressBookView()) {
                            SettingsRowView(imageName: "location.circle",
                                          title: "Address Book",
                                          tintColor: .green)
                        }
                        
                        NavigationLink(destination: PaymentMethodsView()) {
                            SettingsRowView(imageName: "creditcard.circle",
                                          title: "Payment Methods",
                                          tintColor: .orange)
                        }
                    }
                    
                    // App Settings
                    Section("Settings") {
                        NavigationLink(destination: NotificationSettingsView()) {
                            SettingsRowView(imageName: "bell.circle",
                                          title: "Notifications",
                                          tintColor: .purple)
                        }
                        
                        HStack {
                            SettingsRowView(imageName: "info.circle",
                                          title: "App Version",
                                          tintColor: .gray)
                            
                            Spacer()
                            
                            Text("1.0.0")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                    }
                    
                    // Logout & Delete
                    Section {
                        Button {
                            viewModel.signOut()
                        } label: {
                            SettingsRowView(imageName: "arrow.right.square",
                                          title: "Sign Out",
                                          tintColor: .red)
                        }
                        
                        Button {
                            showingDeleteAlert = true
                        } label: {
                            SettingsRowView(imageName: "trash.circle",
                                          title: "Delete Account",
                                          tintColor: .red)
                        }
                    }
                }
                .navigationTitle("Profile")
                .alert("Delete Account", isPresented: $showingDeleteAlert) {
                    Button("Cancel", role: .cancel) { }
                    Button("Delete", role: .destructive) {
                        Task {
                            await viewModel.deleteAccount()
                        }
                    }
                } message: {
                    Text("This action cannot be undone. All your data will be permanently deleted.")
                }
            }
        }
    }
}

struct SettingsRowView: View {
    let imageName: String
    let title: String
    let tintColor: Color
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: imageName)
                .imageScale(.medium)
                .font(.title2)
                .foregroundColor(tintColor)
            
            Text(title)
                .font(.body)
        }
    }
}

#Preview {
    ProfileView()
        .environmentObject(AuthViewModel())
}