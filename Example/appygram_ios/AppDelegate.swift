//
//  AppDelegate.swift
//  appygram_ios
//
//  Created by Carl Scott on 05/28/2015.
//  Copyright (c) 05/28/2015 Carl Scott. All rights reserved.
//

import UIKit
import appygram_ios

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, AppygramEventHandler {

    let APPYGRAM_KEY : String = "API-KEY-HERE"
    
    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        var config = AppygramConfig(api_key: APPYGRAM_KEY)
        config.topic = "Feedback"
        
        println("Configured? \(config.isConfigured())")
        
        Appygram.configure(config)
        
        Appygram.Global().addAfterSendHandler(self)
        
        Appygram.Global().topics {
            println("Got topics \($0)")
        }
        
        var app_json = Dictionary<String, AnyObject>()
        app_json["key"] = "String key"
        app_json["id"] = 7
        app_json["list"] = ["a", "bc", "d"]
        app_json["hash"] = ["a":1, "b":2, "c":3]
        
        var message = Appygram.Global().create()
        message.message = "Hello, world, from the land of iOS"
        message.summary = "iOS Test"
        message.platform = "iOS"
        message.setAppJSON(app_json)
        
        Appygram.Global().send(message)
        
        return true
    }
    
    func afterSend(event: AppygramEvent) {
        println("Sent appygram \(event.getMessage())")
        println(event)
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

