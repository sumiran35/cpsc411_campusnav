//
//  Persistence.swift
//  CampusNav
//
//  Created by csuftitan on 11/28/25.
//

import CoreData
import SwiftUI
import Combine

@MainActor
final class PersistenceController: ObservableObject {

    static let shared = PersistenceController()

    // Published error state (UI can react)
    @Published var persistentStoreError: String?

    // Core Data stack
    let container: NSPersistentContainer

    // Preview
    static let preview: PersistenceController = {
        let controller = PersistenceController(inMemory: true)
        let viewContext = controller.container.viewContext

        for _ in 0..<10 {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()
        }

        do {
            try viewContext.save()
        } catch {
            print("Preview Core Data save error:", error)
        }

        return controller
    }()

    // Init
    init(inMemory: Bool = false) {

        container = NSPersistentContainer(name: "CampusNav")

        if inMemory {
            container.persistentStoreDescriptions.first?.url =
                URL(fileURLWithPath: "/dev/null")
        }

        container.loadPersistentStores { [weak self] storeDescription, error in
            guard let self else { return }

            if let error = error as NSError? {

                print("Core Data store failed to load:", error)

                self.persistentStoreError = """
                Storage could not be loaded.
                The app is running in offline mode.
                Error: \(error.localizedDescription)
                """

                // Fallback to in-memory store
                let fallback = NSPersistentStoreDescription()
                fallback.type = NSInMemoryStoreType

                self.container.persistentStoreDescriptions = [fallback]

                self.container.loadPersistentStores { _, fallbackError in
                    if let fallbackError {
                        print("Fallback store failed:", fallbackError)
                    } else {
                        print("Using in-memory Core Data store")
                    }
                }

                return
            }

            print("Core Data store loaded:",
                  storeDescription.url?.absoluteString ?? "")
        }

        container.viewContext.automaticallyMergesChangesFromParent = true
        container.viewContext.mergePolicy =
            NSMergeByPropertyObjectTrumpMergePolicy
    }
}
