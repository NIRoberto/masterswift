//
//  MasterSwiftApp.swift
//  MasterSwift
//
//  Created by Robert Niyitanga  on 10/12/25.
//

import SwiftUI
import SwiftData
import Firebase
import FirebaseFirestore

@main
struct MasterSwiftApp: App {
    
    init() {
        FirebaseApp.configure()
        
        // Enable offline persistence
        let settings = FirestoreSettings()
        settings.isPersistenceEnabled = true
        Firestore.firestore().settings = settings
        
        print("Firebase configured with Firestore!")
    }
    
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            RootView()
        }
        .modelContainer(sharedModelContainer)
    }
}
