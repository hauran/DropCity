//
//  ViewController.swift
//  swiftTest
//
//  Created by Richard on 7/3/14.
//  Copyright (c) 2014 geniot. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    var locationManager: CLLocationManager!
    var mapView_: GMSMapView!
    
    override func viewDidLoad() {
        super.viewDidAppear(true)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector:"drawAShape:", name: "replyPressed", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector:"showAMessage:", name: "likePressed", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector:"receivedRegionNotification:", name: "receivedRegionNotification", object: nil)
        
        
        var dateComp:NSDateComponents = NSDateComponents()
        dateComp.year = 2014
        dateComp.month = 07
        dateComp.day = 22
        dateComp.hour = 21
        dateComp.minute = 59
        dateComp.timeZone = NSTimeZone.systemTimeZone()
        
        var calendar:NSCalendar = NSCalendar(calendarIdentifier:NSGregorianCalendar)
        var date:NSDate = calendar.dateFromComponents(dateComp)
        
        var notification:UILocalNotification = UILocalNotification()
        notification.category = "FIRST_CATEGORY"
        notification.alertBody = "You should..."
        notification.fireDate = date
        
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        //locationManager.requestWhenInUseAuthorization()
        locationManager.requestAlwaysAuthorization()
        
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    
    func locationManager(manager: CLLocationManager!,
        didChangeAuthorizationStatus status: CLAuthorizationStatus) {
            var shouldIAllow = false
            
            switch status {
            case CLAuthorizationStatus.Restricted:
                shouldIAllow = false
            case CLAuthorizationStatus.Denied:
                shouldIAllow = false
            case CLAuthorizationStatus.NotDetermined:
                shouldIAllow = false
            default:
                shouldIAllow = true
            }
            
            if (shouldIAllow) {
                locationManager.startUpdatingLocation()
                startShowingLocationNotifications()
            }
    }
    
    func startShowingLocationNotifications() {
        var locHomeNotification:UILocalNotification = UILocalNotification()
        locHomeNotification.category = "FIRST_CATEGORY"
        locHomeNotification.alertBody = "You have arrived at home"
        locHomeNotification.regionTriggersOnce = true
        locHomeNotification.region = CLCircularRegion(center: CLLocationCoordinate2DMake(40.6652630, -73.9835600), radius: 50, identifier: "5445464564564564")
        UIApplication.sharedApplication().scheduleLocalNotification(locHomeNotification)
        
        var locWorkNotification:UILocalNotification = UILocalNotification()
        locWorkNotification.category = "FIRST_CATEGORY"
        locWorkNotification.alertBody = "You have arrived at work"
        locWorkNotification.regionTriggersOnce = true
        locWorkNotification.region = CLCircularRegion(center: CLLocationCoordinate2DMake(40.7521340,-73.9785700), radius: 50, identifier: "y7657567567567")
        UIApplication.sharedApplication().scheduleLocalNotification(locWorkNotification)
        
        var locLibraryNotification:UILocalNotification = UILocalNotification()
        locLibraryNotification.category = "FIRST_CATEGORY"
        locLibraryNotification.alertBody = "You have arrived at the NY Public Library"
        locLibraryNotification.regionTriggersOnce = true
        locLibraryNotification.region = CLCircularRegion(center: CLLocationCoordinate2DMake(40.7531820, -73.9822530), radius: 50, identifier: "86esgfsdfgwer9g8w9s8fdg")
        UIApplication.sharedApplication().scheduleLocalNotification(locLibraryNotification)
        
        var locSchoolNotification:UILocalNotification = UILocalNotification()
        locSchoolNotification.category = "FIRST_CATEGORY"
        locSchoolNotification.alertBody = "You have arrived at PSS"
        locSchoolNotification.regionTriggersOnce = true
        locSchoolNotification.region = CLCircularRegion(center: CLLocationCoordinate2DMake(40.6654680, -73.9897260), radius: 50, identifier: "dfdd23asdfasetw456745645w")
        UIApplication.sharedApplication().scheduleLocalNotification(locSchoolNotification)
        NSLog("done")
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: AnyObject[]!) {
        var locationArray = locations as NSArray
        var locationObj = locationArray.lastObject as CLLocation
        var coord = locationObj.coordinate
        locationManager.stopUpdatingLocation()
        initMap(coord)
    }
    
    func initMap(coord:CLLocationCoordinate2D){
        var camera:GMSCameraPosition = GMSCameraPosition.cameraWithLatitude(coord.latitude, longitude:coord.longitude, zoom:15)
        mapView_ = GMSMapView.mapWithFrame(self.view.frame, camera: camera)
//        mapView_.myLocationEnabled = true // the blue dot
        self.view = mapView_;

        var mapInsets:UIEdgeInsets = UIEdgeInsetsMake(0, 0, (self.view.frame.height)/2, 0)
        mapView_.padding = mapInsets
        
        var marker:GMSMarker = GMSMarker()
        NSLog("Location \(coord.latitude) \(coord.longitude)")
        marker.position = CLLocationCoordinate2DMake(coord.latitude, coord.longitude);
        marker.title = "Drop City";
//        marker.snippet = "Australia";
        marker.map = mapView_;
    }
    
    
   
    
    func drawAShape(notification:NSNotification){
        var view:UIView = UIView(frame:CGRectMake(10, 10, 100, 100))
        view.backgroundColor = UIColor.redColor()
        self.view.addSubview(view)
    }
    
    
    func showAMessage(notification:NSNotification){
        var message:UIAlertController = UIAlertController(title: "A Notification Message", message: "Hello there", preferredStyle: UIAlertControllerStyle.Alert)
        message.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        
        self.presentViewController(message, animated: true, completion: nil)
        
    }
    
    
    func receivedRegionNotification(notification:NSNotification) {
        NSLog("Got a notification.  Tell the creator.")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func NotifyClick(sender: UIButton) {
        println("Hello");
        var notification = UILocalNotification()
        notification.timeZone = NSTimeZone.defaultTimeZone()
        let dateTime = NSDate()
        notification.fireDate = dateTime
        notification.alertBody = "Test"
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
        
    }
    
}

