//
//  SettingsView.swift
//  A2_iOS_Shalev_101482699
//
//  Created by Shalev Haimovitz on 2026-04-08.
//

import SwiftUI

struct SettingsView: View {
    @State private var showingConfirmation = false

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    Button(role: .destructive) {
                        showingConfirmation = true
                    } label: {
                        Label("Reset Product Data", systemImage: "arrow.counterclockwise")
                    }
                } header: {
                    Text("Data")
                } footer: {
                    Text("Delete all current products and restore the original 10 seeded products.")
                }
            }
            .navigationTitle("Settings")
            .confirmationDialog(
                "Reset all products to defaults?",
                isPresented: $showingConfirmation,
                titleVisibility: .visible
            ) {
                Button("Reset", role: .destructive) {
                    PersistenceController.shared.resetAndReseed()
                }
                Button("Cancel", role: .cancel) { }
            } message: {
                Text("This will delete all current products and restore the original seeded products.")
            }
        }
    }
}
