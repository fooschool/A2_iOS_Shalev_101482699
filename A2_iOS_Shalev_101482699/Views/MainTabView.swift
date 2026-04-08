//
//  MainTabView.swift
//  A2_iOS_Shalev_101482699
//
//  Created by Shalev Haimovitz on 2026-04-08.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            Tab("Browse", systemImage: "square.stack") {
                BrowsePlaceholderView()
            }
            Tab("List", systemImage: "list.bullet") {
                ProductListView()
            }
        }
    }
}

private struct BrowsePlaceholderView: View {
    var body: some View {
        NavigationStack {
            ContentUnavailableView(
                "Browse",
                systemImage: "square.stack",
                description: Text("Per-product browse view coming soon.")
            )
            .navigationTitle("Browse")
        }
    }
}
