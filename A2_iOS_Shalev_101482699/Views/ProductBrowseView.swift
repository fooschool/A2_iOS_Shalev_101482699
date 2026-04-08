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
    @State private var slideForward: Bool = true

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
                            .id(currentIndex)
                            .transition(slideTransition)

                        HStack(spacing: 16) {
                            Button {
                                guard currentIndex > 0 else { return }
                                slideForward = false
                                withAnimation(.easeInOut(duration: 0.3)) {
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
                                guard currentIndex < products.count - 1 else { return }
                                slideForward = true
                                withAnimation(.easeInOut(duration: 0.3)) {
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

    private var slideTransition: AnyTransition {
        if slideForward {
            return .asymmetric(
                insertion: .move(edge: .trailing).combined(with: .opacity),
                removal: .move(edge: .leading).combined(with: .opacity)
            )
        } else {
            return .asymmetric(
                insertion: .move(edge: .leading).combined(with: .opacity),
                removal: .move(edge: .trailing).combined(with: .opacity)
            )
        }
    }
}
