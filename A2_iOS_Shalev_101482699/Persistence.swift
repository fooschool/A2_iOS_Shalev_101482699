//
//  Persistence.swift
//  A2_iOS_Shalev_101482699
//
//  Created by Shalev Haimovitz on 2026-04-07.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    @MainActor
    static let preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        for i in 0..<10 {
            let newProduct = Product(context: viewContext)
            newProduct.id = Int64(i + 1)
            newProduct.name = "Sample \(i + 1)"
            newProduct.productDescription = "A sample product"
            newProduct.price = 1.0
            newProduct.provider = "Sample"
        }
        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "ProductModel")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.

                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }

    func seedIfNeeded() {
        let key = "hasSeededProducts"
        guard !UserDefaults.standard.bool(forKey: key) else { return }

        let context = container.viewContext
        let seeds: [(name: String, description: String, price: Double)] = [
            ("Tomato", "A very red vegetable", 1.00),
            ("Potato", "A brown vegetable", 0.50),
            ("Lemon", "A sour yellow fruit", 0.75),
            ("Apple", "A red round fruit", 1.00),
            ("Banana", "A long yellow fruit", 0.25),
            ("Carrot", "A long orange vegetable", 0.30),
            ("Onion", "A round white vegetable", 0.40),
            ("Garlic", "A small white vegetable", 0.60),
            ("Cucumber", "A long green vegetable", 0.80),
            ("Pepper", "A spicy red vegetable", 1.20),
        ]

        for (index, seed) in seeds.enumerated() {
            let product = Product(context: context)
            product.id = Int64(index + 1)
            product.name = seed.name
            product.productDescription = seed.description
            product.price = seed.price
            product.provider = "Loblaws"
        }

        do {
            try context.save()
            UserDefaults.standard.set(true, forKey: key)
        } catch {
            let nsError = error as NSError
            fatalError("Failed to seed products: \(nsError), \(nsError.userInfo)")
        }
    }
}
