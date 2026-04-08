//
//  AddProductView.swift
//  A2_iOS_Shalev_101482699
//
//  Created by Shalev Haimovitz on 2026-04-07.
//

import CoreData
import SwiftUI

struct AddProductView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss

    @State private var name: String = ""
    @State private var productDescription: String = ""
    @State private var priceText: String = ""
    @State private var provider: String = ""

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
            .navigationTitle("New Product")
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
        let product = Product(context: viewContext)
        product.id = nextID()
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

    private func nextID() -> Int64 {
        let request: NSFetchRequest<Product> = Product.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \Product.id, ascending: false)]
        request.fetchLimit = 1
        let result = try? viewContext.fetch(request)
        return (result?.first?.id ?? 0) + 1
    }
}
