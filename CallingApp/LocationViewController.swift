//
//  LocationViewController.swift
//  CallingApp
//
//  Created by Nikita Benin on 04/09/2018.
//  Copyright © 2018 Twilio, Inc. All rights reserved.
//

import UIKit
import CoreLocation
import UserNotifications

class LocationViewController: UIViewController, CLLocationManagerDelegate {

    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startBackgroundLocationCheck()
        
        }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func startBackgroundLocationCheck(){
        locationManager.allowsBackgroundLocationUpdates = true
        locationManager.pausesLocationUpdatesAutomatically = false
        self.locationManager.requestAlwaysAuthorization()
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            //locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
            //locationManager.distanceFilter = 1000
            
            locationManager.startMonitoringSignificantLocationChanges()
            locationManager.startUpdatingLocation()
    }
}
    
    func startReceivingSignificantLocationChanges() {
        let authorizationStatus = CLLocationManager.authorizationStatus()
        if authorizationStatus != .authorizedAlways {
            print("User hasn't autorizedAlways location services!")
            return
        }
        if !CLLocationManager.significantLocationChangeMonitoringAvailable() {
            return
        }
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        print("location = \(locValue.latitude) \(locValue.longitude)")
        notifyOnLocation()
    }
    func notifyOnLocation(){
        let content = UNMutableNotificationContent()
        content.title = "Travelling?"
        content.subtitle = ""
        content.body = "Travelling is great with CallingApp"
        content.badge = 1
        let request = UNNotificationRequest(identifier: "timeTrigeredNotification", content: content, trigger: nil)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
}
