//
//  SearchResultsView.swift
//  A2_iOS_Shalev_101482699
//
//  Created by Shalev Haimovitz on 2026-04-08.
//

import CoreData
import SwiftUI

struct SearchResultsView: View {
    @State private var searchText: String = ""

    var body: some View {
        NavigationStack {
            SearchResultsContent(searchText: searchText)
                .navigationTitle("Search")
                .searchable(text: $searchText, prompt: "Search products")
        }
    }
}

private struct SearchResultsContent: View {
    @FetchRequest private var products: FetchedResults<Product>
    private let searchText: String

    init(searchText: String) {
        self.searchText = searchText
        let request: NSFetchRequest<Product> = Product.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \Product.id, ascending: true)]
        if !searchText.isEmpty {
            request.predicate = NSPredicate(
                format: "name CONTAINS[cd] %@ OR productDescription CONTAINS[cd] %@",
                searchText, searchText
            )
        }
        _products = FetchRequest(fetchRequest: request, animation: .default)
    }

    var body: some View {
        if searchText.isEmpty {
            ContentUnavailableView(
                "Search Products",
                systemImage: "magnifyingglass",
                description: Text("Type a name or description to find products.")
            )
        } else if products.isEmpty {
            ContentUnavailableView.search(text: searchText)
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
}
