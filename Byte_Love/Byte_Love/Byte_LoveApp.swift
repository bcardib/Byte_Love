//
//  Byte_LoveApp.swift
//  Byte_Love
//
//  Created by Hiba Wajeeh on 24/08/2024.
//

import SwiftUI
import SwiftData

@main
struct Byte_LoveApp: App {
    @StateObject private var userResponse = UserResponse()
    @State private var isSplashActive: Bool = true // State to control splash screen visibility

    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self, // Make sure your `Item` model is defined elsewhere
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
            if isSplashActive {
                SplashScreenView(isActive: $isSplashActive)
                    .environmentObject(userResponse)
            } else {
                ContentView()
                    .environmentObject(userResponse)
                    .modelContainer(sharedModelContainer)
            }
        }
    }
}

