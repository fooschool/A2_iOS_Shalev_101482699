//
//  ProductBrowseView.swift
//  A2_iOS_Shalev_101482699
//
//  Created by Shalev Haimovitz on 2026-04-08.
//

import CoreData
import SwiftUI

struct ProductBrowseView: View {
    @FetchRequest(
        entity: Product.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Product.id, ascending: true)]
    ) private var products: FetchedResults<Product>

    @State private var currentIndex: Int = 0

    var body: some View {
        NavigationStack {
            Group {
                if products.isEmpty {
                    ContentUnavailableView(
                        "No Products to Browse",
                        systemImage: "shippingbox",
                        description: Text("Add a product from the List tab to get started.")
                    )
                } else {
                    VStack(spacing: 0) {
                        ProductDetailView(product: products[safeIndex])

                        HStack(spacing: 16) {
                            Button {
                                if currentIndex > 0 {
                                    currentIndex -= 1
                                }
                            } label: {
                                Label("Previous", systemImage: "chevron.left")
                                    .frame(maxWidth: .infinity)
                            }
                            .buttonStyle(.bordered)
                            .controlSize(.large)
                            .disabled(currentIndex <= 0)

                            Button {
                                if currentIndex < products.count - 1 {
                                    currentIndex += 1
                                }
                            } label: {
                                Label("Next", systemImage: "chevron.right")
                                    .labelStyle(.titleAndIcon)
                                    .frame(maxWidth: .infinity)
                            }
                            .buttonStyle(.borderedProminent)
                            .controlSize(.large)
                            .disabled(currentIndex >= products.count - 1)
                        }
                        .padding()
                    }
                    .navigationTitle("Browse")
                }
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }

    private var safeIndex: Int {
        min(max(currentIndex, 0), products.count - 1)
    }
}
