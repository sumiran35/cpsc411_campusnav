import SwiftUI
import CoreData
import CoreLocation

struct ContentView: View {
    var body: some View {
        CampusMapView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {

        // fake campus location only for Canvas
        let previewLocationManager = LocationManager()
        previewLocationManager.userLocation = CLLocationCoordinate2D(
            latitude: 33.8823,   // CSUF latitude
            longitude: -117.8851 // CSUF longitude
        )

        return ContentView()
            .environment(
                \.managedObjectContext,
                PersistenceController.preview.container.viewContext
            )
            .environmentObject(previewLocationManager)
            .environmentObject(DirectionsViewModel())
            .environmentObject(CampusSearchViewModel())
            .preferredColorScheme(.dark)
    }
}

