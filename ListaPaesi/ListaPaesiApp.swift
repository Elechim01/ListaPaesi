//
//  ListaPaesiApp.swift
//  ListaPaesi
//
//  Created by Michele Manniello on 23/08/21.
//

import SwiftUI

@main
struct ListaPaesiApp: App {
    let persistanceController = PersistenceController.shared
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistanceController.container.viewContext)
        }
    }
}
