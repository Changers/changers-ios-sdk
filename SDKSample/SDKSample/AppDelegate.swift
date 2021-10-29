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
    
    lazy var changers = Changers()
    var sdkDelegate:SDKWrapperDelegate? = nil

    class func shared() -> AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    fileprivate func handleChangersSDK() {
        changers.delegate = self
        changers.debug = true
        changers.authenticationDelegate = self
        changers.initSDK(with: ChangersHelper.config, uuid: ChangersHelper.changersUUID, apn: false)
    }
    
    func application(_ application: UIApplication, handleEventsForBackgroundURLSession identifier: String, completionHandler: @escaping () -> Void) {
        changers.handleEvents(forBackgroundURLSession: identifier, completionHandler: completionHandler)
    }

    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let rootViewController = storyboard.instantiateInitialViewController() as! ViewController
        sdkDelegate = rootViewController
        window?.rootViewController = rootViewController
        handleChangersSDK()
        return true
    }
    
}

extension AppDelegate: ChangersAuthenticationDelegate {
    func didUpdateCredentials(with uiid: String) {
        ChangersHelper.changersUUID = uiid
        sdkDelegate?.updateUUID()
    }
    
    
}

extension AppDelegate: ChangersDelegate {
    func setupDidFinish() {
        sdkDelegate?.ready()
    }

    func setupDidFail(with error: ChangersAuthenticateError?) {
        print("fail with error: ", error)
    }
    
   
}
