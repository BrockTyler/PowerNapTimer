//
//  AppDelegate.swift
//  PowerNapTimer
//
//  Created by James Pacheco on 5/5/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        // Single instance of UserNotificationCenter
        // 'CompletionHandler' is like a closure
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { (success, error) in
            if let error = error {
                print(error.localizedDescription)
            }
            
            if success {
                print("User has granted access for alerts.")
            } else {
                print("User has denied access for alerts.")
            }
        }
        
        return true
    }
}

