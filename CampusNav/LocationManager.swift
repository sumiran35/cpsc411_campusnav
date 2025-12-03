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
        
        manager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        guard let location = locations.last else {return}
        
        self.userLocation = location.coordinate
    }
    
    // Note: There was also a small typo in the argument label here ("maanger" -> "manager")
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        permissionStatus = manager.authorizationStatus
    }
}
