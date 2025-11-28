//
//  CampusNavApp.swift
//  CampusNav
//
//  Created by csuftitan on 11/28/25.
//

import SwiftUI
import CoreData

@main
struct CampusNavApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
