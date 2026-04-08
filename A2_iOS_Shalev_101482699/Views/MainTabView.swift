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
                ProductBrowseView()
            }
            Tab("List", systemImage: "list.bullet") {
                ProductListView()
            }
        }
    }
}
