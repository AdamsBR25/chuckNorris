//
//  The_Red_AllianceApp.swift
//  The Red Alliance WatchKit Extension
//
//  Created by Brady Adams on 4/25/22.
//

import SwiftUI

@main
struct The_Red_AllianceApp: App {
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
