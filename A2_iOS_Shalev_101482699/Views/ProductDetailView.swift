//
//  ProductDetailView.swift
//  A2_iOS_Shalev_101482699
//
//  Created by Shalev Haimovitz on 2026-04-07.
//

import CoreData
import SwiftUI

struct ProductDetailView: View {
    let product: Product

    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss

    @State private var showingEdit = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text(product.name ?? "")
                    .font(.largeTitle)
                    .bold()

                Text(product.productDescription ?? "")
                    .font(.body)
                    .foregroundStyle(.secondary)

                Divider()

                detailRow(label: "Price", value: product.price.formatted(.currency(code: Locale.current.currency?.identifier ?? "CAD")))
                detailRow(label: "Provider", value: product.provider ?? "")
                detailRow(label: "Product ID", value: "#\(product.id)")
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .navigationTitle("Product")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    showingEdit = true
                } label: {
                    Image(systemName: "pencil")
                }
            }
            ToolbarItem(placement: .topBarTrailing) {
                Button(role: .destructive) {
                    deleteProduct()
                } label: {
                    Image(systemName: "trash")
                }
            }
        }
        .sheet(isPresented: $showingEdit) {
            EditProductView(product: product)
        }
    }

    private func deleteProduct() {
        viewContext.delete(product)
        try? viewContext.save()
        dismiss()
    }

    private func detailRow(label: String, value: String) -> some View {
        HStack {
            Text(label)
                .foregroundStyle(.secondary)
            Spacer()
            Text(value)
                .fontWeight(.medium)
        }
    }
}
