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

    @StateObject var locationManager = LocationManager()
    @StateObject var directionsVM = DirectionsViewModel()
    @StateObject var searchVM = CampusSearchViewModel()

    init() {
        // Restore CSUF geofencing
        LocationManager().startMonitoring(
            latitude: 33.8823,
            longitude: -117.8851,
            radius: 500
        )
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext,
                             persistenceController.container.viewContext)
                .environmentObject(locationManager)
                .environmentObject(directionsVM)
                .environmentObject(searchVM)
        }
    }
}
