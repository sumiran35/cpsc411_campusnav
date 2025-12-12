//
//  LocationMAnager.swift
//  CampusNav
//
//  Created by csuftitan on 11/28/25.
//

import Foundation
import CoreLocation
import Combine

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {

    private let manager = CLLocationManager()

    @Published var userLocation: CLLocationCoordinate2D?
    @Published var userHeading: CLHeading?
    @Published var userCourse: CLLocationDirection = 0
    @Published var userSpeed: CLLocationSpeed = 0
    @Published var permissionStatus: CLAuthorizationStatus = .notDetermined

    private var lastSmoothedHeading: CLLocationDirection = 0

    override init() {
        super.init()

        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest

        // Detects if using swiftUI canvas
        if ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1" {

            //Freeze location for Canvas
            userLocation = CLLocationCoordinate2D(
                latitude: 33.8823,   // CSUF
                longitude: -117.8851
            )

            print("SwiftUI Preview detected — using CSUF location")
            return
        }

        // using real location (Simulator & Device)
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        manager.startUpdatingHeading()
    }

    // Geofencing

    func startMonitoring(latitude: Double, longitude: Double, radius: Double) {
        let center = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)

        let region = CLCircularRegion(
            center: center,
            radius: radius,
            identifier: "CSUF_CAMPUS"
        )
        region.notifyOnEntry = true
        region.notifyOnExit = true

        manager.startMonitoring(for: region)
        print("Monitoring CSUF Campus Region…")
    }

    // CLLocationManagerDelegate

    func locationManager(_ manager: CLLocationManager,
                         didUpdateLocations locations: [CLLocation]) {
        guard let loc = locations.last else { return }

        userLocation = loc.coordinate
        userSpeed = max(loc.speed, 0)

        if loc.speed > 0 {
            userCourse = loc.course
        }
    }

    func locationManager(_ manager: CLLocationManager,
                         didUpdateHeading newHeading: CLHeading) {
        userHeading = newHeading
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        permissionStatus = manager.authorizationStatus
    }

    //Heading Helpers

    func enhancedHeading() -> CLLocationDirection {
        if userSpeed > 1 { return userCourse }
        if let heading = userHeading { return heading.trueHeading }
        return userCourse
    }

    func smoothedEnhancedHeading() -> CLLocationDirection {
        let raw = enhancedHeading()
        let alpha = 0.25
        let smooth = alpha * raw + (1 - alpha) * lastSmoothedHeading
        lastSmoothedHeading = smooth
        return smooth
    }
}
