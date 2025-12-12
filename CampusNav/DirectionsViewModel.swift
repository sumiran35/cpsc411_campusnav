//
//  DirectionsViewModel.swift
//  CampusNav
//
//  Created by csuftitan on 12/11/25.
//

import Foundation
import MapKit
import Combine
import CoreLocation

@MainActor
class DirectionsViewModel: ObservableObject {

    // Published variables
    @Published var route: MKRoute?
    @Published var steps: [MKRoute.Step] = []
    @Published var currentStepIndex: Int = 0
    @Published var arrived: Bool = false

    // Priavate variables
    private var directions: MKDirections?
    private var destination: CLLocationCoordinate2D?

    // Configuration
    private let rerouteThreshold: CLLocationDistance = 35
    private let arrivalThreshold: CLLocationDistance = 15

    // Route Preview
    func getDirections(from start: CLLocationCoordinate2D,
                       to end: CLLocationCoordinate2D) {

        stop()
        destination = end

        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: start))
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: end))
        request.transportType = .walking

        let dir = MKDirections(request: request)
        directions = dir

        dir.calculate { [weak self] response, error in
            guard let self,
                  let route = response?.routes.first else { return }

            DispatchQueue.main.async {
                self.route = route
                self.steps = route.steps.filter { !$0.instructions.isEmpty }
                self.currentStepIndex = 0
                self.arrived = false
            }
        }
    }

    // The stop button for directions
    func stop() {
        directions?.cancel()
        directions = nil
        route = nil
        steps = []
        currentStepIndex = 0
        destination = nil
        arrived = false
    }

    // Naviagation update arrival + reroute
    func handleNavigationUpdate(currentLocation: CLLocationCoordinate2D) {
        guard let destination else { return }

        let userLoc = CLLocation(latitude: currentLocation.latitude,
                                 longitude: currentLocation.longitude)

        let destLoc = CLLocation(latitude: destination.latitude,
                                 longitude: destination.longitude)

        // Arrival destination detenction
        if userLoc.distance(from: destLoc) <= arrivalThreshold {
            arrived = true
            stop()
            return
        }

        updateProgress(for: currentLocation)
        handleReroutingIfNeeded(currentLocation: currentLocation)
    }

    // Steps update when moving
    func updateProgress(for userLocation: CLLocationCoordinate2D) {
        guard let route else { return }

        let userLoc = CLLocation(latitude: userLocation.latitude,
                                 longitude: userLocation.longitude)

        for (i, step) in route.steps.enumerated() {
            let coords = step.polyline.coordinates
            guard let first = coords.first else { continue }

            let stepLoc = CLLocation(latitude: first.latitude,
                                     longitude: first.longitude)

            if userLoc.distance(from: stepLoc) < 20 {
                currentStepIndex = i
                break
            }
        }
    }

    // Rerouting function
    func handleReroutingIfNeeded(currentLocation: CLLocationCoordinate2D) {
        guard let route,
              let destination else { return }

        let userLoc = CLLocation(latitude: currentLocation.latitude,
                                 longitude: currentLocation.longitude)

        let distance = distanceFromRoute(userLocation: userLoc,
                                         polyline: route.polyline)

        if distance > rerouteThreshold {
            getDirections(from: currentLocation, to: destination)
        }
    }

    // Route heading
    func nextStepHeading() -> CLLocationDirection? {
        guard let route,
              currentStepIndex < route.steps.count else { return nil }

        let step = route.steps[currentStepIndex]
        let coords = step.polyline.coordinates
        guard coords.count >= 2 else { return nil }

        let start = coords.first!
        let end = coords.last!

        let dx = end.longitude - start.longitude
        let dy = end.latitude - start.latitude

        var angle = atan2(dy, dx) * 180 / .pi
        if angle < 0 { angle += 360 }

        return angle
    }

    // Measures distance from the route
    private func distanceFromRoute(userLocation: CLLocation,
                                   polyline: MKPolyline) -> CLLocationDistance {

        let points = polyline.points()
        var minDistance = CLLocationDistance.greatestFiniteMagnitude

        for i in 0..<polyline.pointCount {
            let coord = points[i].coordinate
            let loc = CLLocation(latitude: coord.latitude,
                                 longitude: coord.longitude)
            minDistance = min(minDistance,
                              userLocation.distance(from: loc))
        }

        return minDistance
    }
}

// Polyline helper
extension MKPolyline {
    var coordinates: [CLLocationCoordinate2D] {
        var coords = Array(repeating: kCLLocationCoordinate2DInvalid,
                           count: Int(pointCount))
        getCoordinates(&coords,
                       range: NSRange(location: 0, length: pointCount))
        return coords
    }
}
