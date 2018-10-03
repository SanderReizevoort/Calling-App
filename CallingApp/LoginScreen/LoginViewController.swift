//
//  LoginViewController.swift
//  CallApp
//
//  Created by Nikita Benin on 09/08/2018.
//  Copyright © 2018 Nikita Benin. All rights reserved.
//

import UIKit
import UserNotifications
import CoreLocation


class LoginViewController: UIViewController, CLLocationManagerDelegate {
    
    let locationManager = CLLocationManager()
    //Notification test
    @IBAction func sendNotification(_ sender: Any) {
        let content = UNMutableNotificationContent()
        content.title = "CallingApp"
        content.subtitle = "Button notification"
        content.body = "Your pressed \"Notify me\" button 30 seconds ago."
        content.badge = 1

        let timeTrigger = UNTimeIntervalNotificationTrigger(timeInterval: 30.0, repeats: false)
        let request = UNNotificationRequest(identifier: "timeTrigeredNotification", content: content, trigger: timeTrigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
       // UIApplication.shared.applicationIconBadgeNumber = 0
    }
    //
    @IBOutlet weak var collectionView: UICollectionView!
    let loginTypes = ["  Login with Facebook","  Login with Google","", "     Create Account"]
    let socialLogos = [#imageLiteral(resourceName: "facebook-logo"), #imageLiteral(resourceName: "google-logo"), UIImage.init(), UIImage.init()]
    let socialColors = [UIColor.init(named: "facebook"),UIColor.init(named: "google"), UIColor.clear, UIColor.clear]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIApplication.shared.applicationIconBadgeNumber = 0
        startBackgroundLocationCheck()
        
        //Notification test-start
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge], completionHandler: {didAllow, error in
            
            if didAllow == false{
                print("Notifications are allowed.")
            }else{
                print("Notifications are blocked.")
            }
            
        })
        //Notification test-end
        //Location test-start
        //Ask for Authorisation from the User.
        
        
        
        
        //Location test-end
        
        
        let collectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionViewFlowLayout.itemSize = CGSize(width: collectionView.frame.width, height: 100)
        
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
            locationManager.startMonitoringSignificantLocationChanges()
            //locationManager.startUpdatingLocation()
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
        
        let state = UIApplication.shared.applicationState
        if state == .background {
            print("location = \(locValue.latitude) \(locValue.longitude)")
            _ = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(notifyOnLocation), userInfo: nil, repeats: false)
        }
        

        
    }
    @objc func notifyOnLocation(){
        let content = UNMutableNotificationContent()
        content.title = "Travelling?"
        content.subtitle = ""
        content.body = "Travelling is great with CallingApp"
        content.badge = 1
        let request = UNNotificationRequest(identifier: "locationTrigeredNotification", content: content, trigger: nil)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
}
extension LoginViewController: UICollectionViewDelegate {
    
}

extension LoginViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "loginCell", for: indexPath) as! LoginTypeCell
        cell.layer.cornerRadius = 20
        
        if indexPath.row == 3 {
            cell.layer.borderWidth = 2
            cell.layer.borderColor = UIColor.white.cgColor
        }
        
        cell.socialLbl.text = loginTypes[indexPath.row]
        cell.socialImg.image = socialLogos[indexPath.row]
        cell.backgroundColor = socialColors[indexPath.row]
        return cell
    }
}
