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
    
    // 2. Fixed typo: CLocationCoordinate2D -> CLLocationCoordinate2D
    @Published var userLocation: CLLocationCoordinate2D?
    @Published var permissionStatus: CLAuthorizationStatus = .notDetermined
    
    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        
        manager.requestWhenInUseAuthorization()
        
        // Starts live location tracking
        manager.startUpdatingLocation()
    }
    
    // Defining region for geofencing and begin monitoring
    func startMonitoring(latitude: Double, longitude: Double, radius: Double) {
        let center = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let region = CLCircularRegion(center: center, radius: radius, identifier: "CSUF Campus")
        
        region.notifyOnEntry = true
        region.notifyOnExit = true
        
        manager.startMonitoring(for: region)
    }
    
    // Updates location live
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        guard let location = locations.last else { return }
        
        self.userLocation = location.coordinate
        
        // print("TEST - New location: \(location.coordinate)")
    }
    
    // Handle live location update errors
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        print("Location update failed: \(error.localizedDescription)")
    }
    
    // Geofencing triggers on entry/exit, currently only for testing
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        print("Entered campus")
    }
    
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        print("Exited campus")
    }
    
    // Handle geofencing errors
    func locationManager(_ manager: CLLocationManager, monitoringDidFailFor region: CLRegion?, withError error: Error) {
        print("Monitoring failed: \(error.localizedDescription)")
    }
    
    // Note: There was also a small typo in the argument label here ("maanger" -> "manager")
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        permissionStatus = manager.authorizationStatus
    }
}
