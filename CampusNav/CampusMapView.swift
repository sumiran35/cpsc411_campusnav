import SwiftUI
import MapKit
import Combine

struct CampusMapView: View {

    // EnvironmentObjects
    @EnvironmentObject var locationManager: LocationManager
    @EnvironmentObject var directionsVM: DirectionsViewModel
    @EnvironmentObject var searchVM: CampusSearchViewModel

    // Setting CSUF Campus Bounds
    private let campusCenter = CLLocationCoordinate2D(
        latitude: 33.8823,
        longitude: -117.8851
    )

    private let campusSpan = MKCoordinateSpan(
        latitudeDelta: 0.010,
        longitudeDelta: 0.010
    )

    // Map Camera
    @State private var cameraPosition: MapCameraPosition =
        .region(
            MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: 33.8823, longitude: -117.8851),
                span: MKCoordinateSpan(latitudeDelta: 0.006, longitudeDelta: 0.006)
            )
        )

    // UI States
    @State private var selectedBuilding: CampusBuilding?
    @State private var showDirectory = false
    @State private var directorySearch = ""
    @State private var navigationActive = false
    @State private var showArrivalAlert = false

    // Directory Filterd
    private var filteredDirectoryBuildings: [CampusBuilding] {
        directorySearch.isEmpty
        ? sampleBuildings
        : sampleBuildings.filter {
            $0.name.lowercased().contains(directorySearch.lowercased()) ||
            $0.description.lowercased().contains(directorySearch.lowercased())
        }
    }

    // Body
    var body: some View {
        VStack(spacing: 0) {

            // Map search on the map screen
            if !showDirectory {
                VStack {
                    TextField("Search buildings…", text: $searchVM.query)
                        .padding(10)
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(10)
                        .padding()
                        .onChange(of: searchVM.query) { _ in
                            searchVM.search(sampleBuildings)
                        }

                    if !searchVM.results.isEmpty {
                        List(searchVM.results) { b in
                            Button {
                                selectBuilding(b)
                                searchVM.query = ""
                                searchVM.results = []
                            } label: {
                                Text(b.name)
                            }
                        }
                        .frame(height: 180)
                    }
                }
            }

            // Chossing the map or directory screens
            if showDirectory {
                directoryView
            } else {
                mapView
            }

            // Preview of the route
            if directionsVM.route != nil && !navigationActive {
                Button {
                    navigationActive = true
                } label: {
                    Text("Start Route")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                        .padding(.horizontal)
                }
                .padding(.top, 20)
            }

            // Turn by turn directions
            if navigationActive && !directionsVM.steps.isEmpty {
                Divider()

                HStack {
                    Text("Walking Directions")
                        .font(.headline)
                    Spacer()
                    Button("Stop") {
                        navigationActive = false
                        directionsVM.stop()
                    }
                    .foregroundColor(.red)
                }
                .padding(.horizontal)
                .padding(.top, 20)

                ScrollView {
                    VStack(alignment: .leading, spacing: 12) {
                        ForEach(directionsVM.steps.indices, id: \.self) { i in
                            let step = directionsVM.steps[i]
                            VStack(alignment: .leading) {
                                Text(step.instructions)
                                    .fontWeight(
                                        directionsVM.currentStepIndex == i ? .bold : .regular
                                    )
                                    .foregroundColor(
                                        directionsVM.currentStepIndex == i ? .blue : .primary
                                    )
                                Text("\(Int(step.distance)) meters")
                                    .font(.caption2)
                                    .foregroundColor(.secondary)
                            }
                            Divider()
                        }
                    }
                    .padding()
                }
                .frame(maxHeight: 250)
            }

            // Bottom Bar
            bottomBar
        }
        .alert("You've arrived ", isPresented: $showArrivalAlert) {
            Button("OK") { }
        }

        // Location updates when arrived
        .onReceive(locationManager.$userLocation.compactMap { $0 }) { loc in
            if navigationActive {
                directionsVM.handleNavigationUpdate(currentLocation: loc)
                if directionsVM.arrived {
                    navigationActive = false
                    showArrivalAlert = true
                }
            }
        }

        // Chossen building display
        .sheet(item: $selectedBuilding) { b in
            VStack(spacing: 20) {
                Text(b.name).font(.title2)
                Text(b.description)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .padding(.horizontal)

                Button("Get Walking Directions") {
                    if let loc = locationManager.userLocation {
                        directionsVM.getDirections(from: loc, to: b.coordinate)
                        navigationActive = false
                    }
                    selectedBuilding = nil
                }
                .padding(.top, 20)
                .padding(.bottom, 20)
                .frame(maxWidth: .infinity)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(12)
                .padding(.horizontal)

                Button("Cancel") {
                    selectedBuilding = nil
                }
                .foregroundColor(.red)
            }
            .presentationDetents([.height(280)])
        }
    }

    // Directory screen view
    private var directoryView: some View {
        VStack {
            TextField("Search directory…", text: $directorySearch)
                .padding(10)
                .background(Color(.secondarySystemBackground))
                .cornerRadius(10)
                .padding()

            ScrollView {
                LazyVStack(spacing: 12) {
                    ForEach(filteredDirectoryBuildings) { b in
                        Button {
                            selectBuilding(b)
                            showDirectory = false
                        } label: {
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(b.name).font(.headline)
                                    Text(b.description)
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                }
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.gray)
                            }
                            .padding()
                            .background(Color(.secondarySystemBackground))
                            .cornerRadius(12)
                        }
                    }
                }
                .padding()
            }
        }
    }

    // The Map view
    private var mapView: some View {
        ZStack(alignment: .bottomTrailing) {

            Map(position: $cameraPosition) {
                
                UserAnnotation()

                // Building pins
                ForEach(sampleBuildings) { b in
                    Annotation(b.name, coordinate: b.coordinate) {
                        Image(systemName: "mappin.circle.fill")
                            .font(.title)
                            .foregroundColor(.red)
                            .onTapGesture {
                                selectedBuilding = b
                            }
                    }
                }

                // Route polyline
                if let route = directionsVM.route {
                    MapPolyline(route.polyline)
                        .stroke(.blue, lineWidth: 6)
                }

                // Heading arrow on map
                if let userLoc = locationManager.userLocation {
                    let blended = locationManager.smoothedEnhancedHeading()
                    let turnHeading = navigationActive
                        ? directionsVM.nextStepHeading()
                        : nil

                    let finalHeading = turnHeading ?? blended

                    Annotation("User", coordinate: userLoc) {
                        Image(systemName: "location.north.fill")
                            .font(.system(size: 32))
                            .foregroundColor(.blue)
                            .rotationEffect(.degrees(finalHeading))
                    }
                }

            }
            .mapControls {
                MapCompass()
            }
            .onMapCameraChange { context in
                clampCameraToCampus(context.region)
            }

            // Recenter button
            Button {
                cameraPosition = .userLocation(
                    followsHeading: true,
                    fallback: .region(
                        MKCoordinateRegion(
                            center: campusCenter,
                            span: MKCoordinateSpan(latitudeDelta: 0.006,
                                                   longitudeDelta: 0.006)
                        )
                    )
                )
            } label: {
                Image(systemName: "location.fill")
                    .font(.title2)
                    .padding()
                    .background(Color(.systemBackground))
                    .clipShape(Circle())
                    .shadow(radius: 4)
            }
            .padding()
        }
    }

    // The Bottom bar UI
    private var bottomBar: some View {
        HStack {
            Button {
                showDirectory = false
            } label: {
                Text("Map")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(showDirectory ? Color(.secondarySystemBackground) : Color.blue)
                    .foregroundColor(showDirectory ? .primary : .white)
                    .cornerRadius(10)
            }
            .padding(.top, 20)

            Button {
                showDirectory = true
                searchVM.query = ""
                searchVM.results = []
            } label: {
                Text("Directory")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(showDirectory ? Color.blue : Color(.secondarySystemBackground))
                    .foregroundColor(showDirectory ? .white : .primary)
                    .cornerRadius(10)
            }
            .padding(.top, 20)
        }
        .padding(.horizontal)
        .padding(.bottom, 8)
        .background(.ultraThinMaterial)
    }

    // Helper functions
    private func selectBuilding(_ b: CampusBuilding) {
        selectedBuilding = b
        cameraPosition = .region(
            MKCoordinateRegion(
                center: b.coordinate,
                span: MKCoordinateSpan(latitudeDelta: 0.004,
                                       longitudeDelta: 0.004)
            )
        )
    }

    private func clampCameraToCampus(_ region: MKCoordinateRegion?) {
        guard let region else { return }

        let latMin = campusCenter.latitude - campusSpan.latitudeDelta / 2
        let latMax = campusCenter.latitude + campusSpan.latitudeDelta / 2
        let lonMin = campusCenter.longitude - campusSpan.longitudeDelta / 2
        let lonMax = campusCenter.longitude + campusSpan.longitudeDelta / 2

        let clampedLat = min(max(region.center.latitude, latMin), latMax)
        let clampedLon = min(max(region.center.longitude, lonMin), lonMax)

        if clampedLat != region.center.latitude ||
            clampedLon != region.center.longitude {

            cameraPosition = .region(
                MKCoordinateRegion(
                    center: CLLocationCoordinate2D(latitude: clampedLat,
                                                   longitude: clampedLon),
                    span: region.span
                )
            )
        }
    }
}

