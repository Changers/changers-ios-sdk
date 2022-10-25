//
//  AppDelegate.swift
//  SDKSample
//
//  Created by Clement Yerochewski on 19.05.21.
//

import UIKit
import ChangersSDK

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        didFinishLauching() // this has to be called as soon as possible within the didFinishLaunchingWithOptions 
        return true
    }

}
