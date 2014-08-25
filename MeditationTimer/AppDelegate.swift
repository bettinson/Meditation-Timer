//
//  AppDelegate.swift
//  MeditationTimer
//
//  Created by Matt Bettinson on 2014-07-26.
//  Copyright (c) 2014 Matt Bettinson. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var viewController: ViewController = ViewController()
    var window: UIWindow?
    let TIMESTAMP_KEY = "timestamp"
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: NSDictionary?) -> Bool {
        UIApplication.sharedApplication().idleTimerDisabled = true
        UIApplication.sharedApplication().statusBarHidden = true
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
        var timestamp = Int(NSDate.date().timeIntervalSince1970)
        var timestampOfTimerDuration = Int(NSDate.date().timeIntervalSince1970) + viewController.duration
        NSUserDefaults.standardUserDefaults().setInteger(timestamp, forKey: TIMESTAMP_KEY)
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
//        NSNotificationCenter.defaultCenter().postNotificationName("lock", object: self)
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        var newTimestamp = Int(NSDate.date().timeIntervalSince1970)
        var oldTimestamp = NSUserDefaults.standardUserDefaults().integerForKey(TIMESTAMP_KEY)
        var secondsPassed = newTimestamp - oldTimestamp
        println(secondsPassed)
        println(viewController.timerLabel?.text)
        if (viewController.timerIsRunning) {
            viewController.updateView(secondsPassed)
        }
        secondsPassed = 0
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

