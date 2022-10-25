//
//  AppDelegate+SDK.swift
//  sdk.changers-sampleApp
//
//  Created by Clement Yerochewski on 27.04.21.
//  Copyright © 2021 Blacksquared Gmbh. All rights reserved.
//

import Foundation
import ChangersSDK
import UIKit

struct ChangersHelper {
    
    static var clientSecret: String { // client secret provided by Changers, they are different between each env
        return "NJenVMftfWMyr3T7XcxBRQSKgklm1berPgCz4WEB"
    }
    
    
    static var clientId: Int { // client id provided by Changers, they are different between each env
        return 3
    }
    
    static var clientName: String {
        return "sdksample"
    }
        
    static var config: ChangersConfig {
        return ChangersConfig(clientId: ChangersHelper.clientId,
                              clientSecret: ChangersHelper.clientSecret,
                              clientName: ChangersHelper.clientName,
                              environment: ChangersEnv.stage) // .stage and .production are available, each environement have their own specific clientId, clientSecret
    }
    
    static var changersUUID: String? {
           set(uuid) {
               UserDefaults.standard.set(uuid, forKey: "userUUID")
           }
           get {
               return UserDefaults.standard.string(forKey: "userUUID")
           }
       }
}

extension AppDelegate {
    
    fileprivate func handleChangersSDK() {
        _ = ChangersTracking.sharedInstance
        ChangersInstance.shared().load(config: ChangersHelper.config)
    }
        
    
    func didFinishLauching() {
        handleChangersSDK()
    }
        
    func application(_ application: UIApplication, handleEventsForBackgroundURLSession identifier: String, completionHandler: @escaping () -> Void) { // this is mandatory in order to receive user's tracking in the background
        ChangersTracking.sharedInstance.handleEvents(forBackgroundURLSession: identifier, completionHandler: completionHandler)
    }

}

