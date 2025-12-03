import SwiftUI
import CoreData

struct ContentView: View {
    var body: some View {
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

