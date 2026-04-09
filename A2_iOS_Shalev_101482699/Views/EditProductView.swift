//
//  EditProductView.swift
//  A2_iOS_Shalev_101482699
//
//  Created by Shalev Haimovitz on 2026-04-09.
//

import CoreData
import SwiftUI

struct EditProductView: View {
    let product: Product

    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss

    @State private var name: String
    @State private var productDescription: String
    @State private var priceText: String
    @State private var provider: String

    init(product: Product) {
        self.product = product
        _name = State(initialValue: product.name ?? "")
        _productDescription = State(initialValue: product.productDescription ?? "")
        _priceText = State(initialValue: String(format: "%.2f", product.price))
        _provider = State(initialValue: product.provider ?? "")
    }

    private var isValid: Bool {
        !name.trimmingCharacters(in: .whitespaces).isEmpty &&
        !productDescription.trimmingCharacters(in: .whitespaces).isEmpty &&
        !provider.trimmingCharacters(in: .whitespaces).isEmpty &&
        (Double(priceText) ?? 0) > 0
    }

    var body: some View {
        NavigationStack {
            Form {
                Section("Product") {
                    TextField("Name", text: $name)
                    TextField("Description", text: $productDescription, axis: .vertical)
                        .lineLimit(2...4)
                }
                Section("Pricing") {
                    TextField("Price", text: $priceText)
                        .keyboardType(.decimalPad)
                    TextField("Provider", text: $provider)
                }
            }
            .navigationTitle("Edit Product")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") { save() }
                        .disabled(!isValid)
                }
            }
        }
    }

    private func save() {
        product.name = name.trimmingCharacters(in: .whitespaces)
        product.productDescription = productDescription.trimmingCharacters(in: .whitespaces)
        product.price = Double(priceText) ?? 0
        product.provider = provider.trimmingCharacters(in: .whitespaces)

        do {
            try viewContext.save()
            dismiss()
        } catch {
            print("Failed to save product: \(error)")
        }
    }
}
