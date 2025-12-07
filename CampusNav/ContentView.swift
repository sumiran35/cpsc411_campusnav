import SwiftUI
import CoreData

struct ContentView: View {
    @StateObject private var locationManager = LocationManager()
    var body: some View {
        VStack {
            // Keep empty
        }.onAppear {
            // Start geofencing as soon as app opens
            locationManager.startMonitoring(latitude: 33.8823, longitude: -117.8851, radius: 900)
        }
        
        //Tab view
        TabView {
            //first tab
            CampusMapView().tabItem {
                Label("Campus Map", systemImage: "map.fill")
            }
            //second tab
            BuildingListView().tabItem {
                Label("Directory", systemImage: "list.bullet")
            }
            
        }.accentColor(.blue)
    }
}

#Preview {
    ContentView()
}

