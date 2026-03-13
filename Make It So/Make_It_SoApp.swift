//
//  Make_It_SoApp.swift
//  Make It So
//
//  Created by Julien Cotte on 13/03/2026.
//

import SwiftUI
import FirebaseCore
import FirebaseAuth
import FirebaseFirestore

/// App delegate pour ajouter Firebase dans l'app
class AppDelegate: NSObject, UIApplicationDelegate {

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()

        return true
    }
}

@main
struct Make_It_SoApp: App {
    
    /// Instantiation de l'app delegate firebase
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    var body: some Scene {
        WindowGroup {
            NavigationStack {
                RemindersListView()
                    .navigationTitle("Reminders")
            }
        }
    }
}
