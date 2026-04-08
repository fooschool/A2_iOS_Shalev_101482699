//
//  ProductListView.swift
//  A2_iOS_Shalev_101482699
//
//  Created by Shalev Haimovitz on 2026-04-07.
//

import CoreData
import SwiftUI

struct ProductListView: View {
    @FetchRequest(
        entity: Product.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Product.id, ascending: true)]
    ) private var products: FetchedResults<Product>

    @State private var showingAdd = false

    var body: some View {
        NavigationStack {
            Group {
                if products.isEmpty {
                    ContentUnavailableView(
                        "No Products Yet",
                        systemImage: "tray",
                        description: Text("Tap + to add your first product.")
                    )
                } else {
                    List(products) { product in
                        NavigationLink {
                            ProductDetailView(product: product)
                        } label: {
                            VStack(alignment: .leading, spacing: 4) {
                                Text(product.name ?? "")
                                    .font(.headline)
                                Text(product.productDescription ?? "")
                                    .font(.subheadline)
                                    .foregroundStyle(.secondary)
                            }
                            .padding(.vertical, 4)
                        }
                    }
                }
            }
            .navigationTitle("Products")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showingAdd = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAdd) {
                AddProductView()
            }
        }
    }
}
