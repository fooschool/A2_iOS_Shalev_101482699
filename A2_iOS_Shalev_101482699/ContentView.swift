//
//  ContentView.swift
//  A2_iOS_Shalev_101482699
//
//  Created by Shalev Haimovitz on 2026-04-07.
//

import CoreData
import SwiftUI

struct ContentView: View {
    var body: some View {
        MainTabView()
    }
}

#Preview {
    ContentView()
        .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
}
