//
//  A2_iOS_Shalev_101482699App.swift
//  A2_iOS_Shalev_101482699
//
//  Created by Shalev Haimovitz on 2026-04-07.
//

import CoreData
import SwiftUI

@main
struct A2_iOS_Shalev_101482699App: App {
    let persistenceController = PersistenceController.shared

    init() {
        persistenceController.seedIfNeeded()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
