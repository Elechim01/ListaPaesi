//
//  ListaPaesiApp.swift
//  ListaPaesi WatchKit Extension
//
//  Created by Michele Manniello on 23/08/21.
//

import SwiftUI

@main
struct ListaPaesiApp: App {
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
