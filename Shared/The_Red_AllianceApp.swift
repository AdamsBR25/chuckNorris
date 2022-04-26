//
//  The_Red_AllianceApp.swift
//  Shared
//
//  Created by Brady Adams on 4/25/22.
//

import SwiftUI
import UserNotifications

@main
struct The_Red_AllianceApp: App {
    @State public var notifAllowed = false
    init() {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            
            if let error = error {
                print(error)
            }
            
            // Enable or disable features based on the authorization.
        }
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
