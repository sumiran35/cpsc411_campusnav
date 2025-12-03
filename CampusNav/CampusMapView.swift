import SwiftUI
import MapKit
import CoreLocation

extension CLLocationCoordinate2D: Equatable {
    public static func == (lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
        return lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
    }
}

struct CampusMapView: View {
    @StateObject private var locationManager = LocationManager()
    
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 33.8823, longitude: -117.8851),
        span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
    )
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            Map(coordinateRegion: $region,
                interactionModes: .all,
                showsUserLocation: true,
                annotationItems: sampleBuildings) { building in
                MapMarker(coordinate: building.coordinate, tint: .red)
            }
            .edgesIgnoringSafeArea(.top)
            .onAppear {
                if let location = locationManager.userLocation {
                    region.center = location
                }
            }
            
            Button(action: {
                if let location = locationManager.userLocation {
                    withAnimation {
                        region.center = location
                    }
                }
            }) {
                Image(systemName: "location.fill")
                    .font(.title2)
                    .padding()
                    .background(Color.white)
                    .clipShape(Circle())
                    .shadow(radius: 4)
            }
            .padding()
        }
        .onChange(of: locationManager.userLocation) { newLocation in
            
        }
    }
}
