//
//  AppDelegate.swift
//  swiftTest
//
//  Created by Richard on 7/3/14.
//  Copyright (c) 2014 geniot. All rights reserved.
//

import UIKit
import CoreLocation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: NSDictionary?) -> Bool {
        
        //        Actions
        var replyAction:UIMutableUserNotificationAction = UIMutableUserNotificationAction()
        replyAction.identifier = "REPLY_ACTION"
        replyAction.title = "Reply"
        replyAction.activationMode = UIUserNotificationActivationMode.Foreground
        replyAction.destructive = false
        replyAction.authenticationRequired = false
        
        var likeAction:UIMutableUserNotificationAction = UIMutableUserNotificationAction()
        likeAction.identifier = "LIKE_ACTION"
        likeAction.title = "Like"
        likeAction.activationMode = UIUserNotificationActivationMode.Background
        likeAction.destructive = false
        likeAction.authenticationRequired = false
        
        var thirdAction:UIMutableUserNotificationAction = UIMutableUserNotificationAction()
        thirdAction.identifier = "THIRD_ACTION"
        thirdAction.title = "Third Action"
        thirdAction.activationMode = UIUserNotificationActivationMode.Background
        thirdAction.destructive = false
        thirdAction.authenticationRequired = false
        
        
        //        Category
        var firstCategory:UIMutableUserNotificationCategory = UIMutableUserNotificationCategory()
        firstCategory.identifier = "FIRST_CATEGORY"
        
        let defaultActions:NSArray = [replyAction, likeAction, thirdAction]
        let minimalAction:NSArray = [replyAction, likeAction]
        
        firstCategory.setActions(defaultActions, forContext:UIUserNotificationActionContext.Default)
        firstCategory.setActions(minimalAction, forContext:UIUserNotificationActionContext.Minimal)
        
        //        NSSet of all our categories
        let categories:NSSet = NSSet(objects:firstCategory)
        
        
        let types:UIUserNotificationType = UIUserNotificationType.Alert | UIUserNotificationType.Badge
        
        let mySettings:UIUserNotificationSettings = UIUserNotificationSettings(forTypes:types, categories:categories)
        
        UIApplication.sharedApplication().registerUserNotificationSettings(mySettings)
        UIApplication.sharedApplication().registerForRemoteNotifications()
        
        return true
    }
    
    func application( application: UIApplication!, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData! ) {
        var characterSet: NSCharacterSet = NSCharacterSet( charactersInString: "<>" )
        var deviceTokenString: String = ( deviceToken.description as NSString )
            .stringByTrimmingCharactersInSet( characterSet )
            .stringByReplacingOccurrencesOfString( " ", withString: "" ) as String
        
        println( deviceTokenString)
    }
    func application( application: UIApplication!, didFailToRegisterForRemoteNotificationsWithError error: NSError! ) {
        println( "didFailToRegisterForRemoteNotificationsWithError" )
        println( error.localizedDescription )
    }
    
    
    
    
    func application(application: UIApplication!,
        handleActionWithIdentifier identifier:String!,
        forLocalNotification notification:UILocalNotification!,
        completionHandler: (() -> Void)!){
            
            if (identifier == "REPLY_ACTION"){
                NSNotificationCenter.defaultCenter().postNotificationName("replyPressed", object: nil)
                
            }else if (identifier == "LIKE_ACTION"){
                NSNotificationCenter.defaultCenter().postNotificationName("likePressed", object: nil)
                
            }
            
            completionHandler()
            
    }
    
    
    func application(application: UIApplication!,
        didReceiveLocalNotification notification:UILocalNotification!,
        completionHandler: (() -> Void)!){
            if(notification.region){
                NSNotificationCenter.defaultCenter().postNotificationName("receivedRegionNotification", object: nil)
            }
    }

    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
}

