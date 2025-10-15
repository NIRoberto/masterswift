//
//  AuthViewModel.swift
//  MasterSwift
//
//  Created by Robert Niyitanga on 10/12/25.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestore

@MainActor
class AuthViewModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    @Published var isLoading = false
    @Published var errorMessage = ""
    
    init() {
        self.userSession = Auth.auth().currentUser
        
        Task {
            await fetchUser()
        }
    }
    
    func signIn(withEmail email: String, password: String) async {
        print("🔄 Starting sign in for: \(email)")
        isLoading = true
        errorMessage = ""
        
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user
            print("✅ Sign in successful for: \(email)")
            await fetchUser()
        } catch {
            errorMessage = error.localizedDescription
            print("❌ Sign in failed: \(error.localizedDescription)")
        }
        
        isLoading = false
        print("🏁 Sign in process completed")
    }
    
    func createUser(withEmail email: String, password: String, fullName: String) async {
        print("🔄 Starting user creation for: \(email)")
        isLoading = true
        errorMessage = ""
        
        do {
            print("📝 Creating Firebase Auth account...")
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            print("✅ Firebase Auth account created: \(result.user.uid)")
            
            print("💾 Saving user data to Firestore...")
            let user = User(id: result.user.uid, email: email, fullName: fullName)
            let encodedUser = try Firestore.Encoder().encode(user)
            try await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
            print("✅ User data saved to Firestore: \(user.email)")
            
            await fetchUser()
        } catch {
            errorMessage = error.localizedDescription
            print("❌ User creation failed: \(error.localizedDescription)")
        }
        
        isLoading = false
        print("🏁 User creation process completed")
    }
    
    func signOut() {
        print("🔄 Starting sign out process...")
        do {
            try Auth.auth().signOut()
            self.userSession = nil
            self.currentUser = nil
            print("✅ Sign out successful")
        } catch {
            print("❌ Sign out failed: \(error.localizedDescription)")
        }
    }
    
    func deleteAccount() async {
        guard let user = Auth.auth().currentUser else { 
            print("❌ No current user to delete")
            return 
        }
        
        print("🔄 Starting account deletion for: \(user.uid)")
        
        do {
            print("🗑️ Deleting user data from Firestore...")
            try await Firestore.firestore().collection("users").document(user.uid).delete()
            print("✅ User data deleted from Firestore")
            
            print("🗑️ Deleting Firebase Auth account...")
            try await user.delete()
            print("✅ Firebase Auth account deleted")
            
            self.userSession = nil
            self.currentUser = nil
            print("✅ Account deletion completed")
        } catch {
            errorMessage = error.localizedDescription
            print("❌ Account deletion failed: \(error.localizedDescription)")
        }
    }
    
    func fetchUser() async {
        guard let uid = Auth.auth().currentUser?.uid else { 
            print("⚠️ No current user to fetch")
            return 
        }
        
        print("🔄 Fetching user data for: \(uid)")
        
        do {
            let snapshot = try await Firestore.firestore().collection("users").document(uid).getDocument()
            if snapshot.exists {
                self.currentUser = try snapshot.data(as: User.self)
                print("✅ User fetched from Firestore: \(self.currentUser?.email ?? "")")
            } else {
                print("⚠️ User document doesn't exist in Firestore, creating fallback...")
                if let email = Auth.auth().currentUser?.email {
                    self.currentUser = User(id: uid, email: email, fullName: email.components(separatedBy: "@").first ?? "User")
                    print("✅ Fallback user created: \(email)")
                }
            }
        } catch {
            print("❌ Failed to fetch user from Firestore: \(error.localizedDescription)")
            if let email = Auth.auth().currentUser?.email {
                self.currentUser = User(id: uid, email: email, fullName: email.components(separatedBy: "@").first ?? "User")
                print("✅ Using fallback user data: \(email)")
            }
        }
    }
}