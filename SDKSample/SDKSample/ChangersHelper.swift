//
//  ChangersHelper.swift
//  sdk.changers-sampleApp
//
//  Created by Clement Yerochewski on 13/08/2020.
//  Copyright © 2020 Blacksquared Gmbh. All rights reserved.
//

import Foundation
import ChangersSDK

extension ChangersEnv {
    var clientSecret: String { // client secret provided by Changers, they are different between each env
        switch self {
        case .development:
            fatalError("missing developer  client secret")
        case .production:
            fatalError("missing prod client secret")
        case .stage:
            return "NJenVMftfWMyr3T7XcxBRQSKgklm1berPgCz4WEB"
        }
    }
    
    var clientId: Int { // client id provided by Changers, they are different between each env
        switch self {
        case .development:
            fatalError("missing dev client id")
        case .production:
            fatalError("missing prod client id")
        case .stage:
            return 3
        }
    }
    
    var clientName: String {
        return "sdksample" // client named provided by Changers, they are different between each env
    }
    
    var APN_KEY: String { // client secret provided by Changers, they are different between each env
        switch self {
        case .development:
            return ""
        case .production:
            return ""
        case .stage:
            return ""
        }
    }
    
    var server: String {
        switch self {
        case .development:
            return "https://sst.changersdev.de/api/"
        case .production:
            return "https://sst.changers.com/api/"
        case .stage:
            return "https://sst.maroshi.de/api/"
        }
    }


    
   
    
}


struct ChangersHelper {
    
    static let changersEnv: ChangersEnv = ChangersEnv.stage

    static var config: ChangersConfig {
        return ChangersConfig(clientId: changersEnv.clientId,
                              clientSecret: changersEnv.clientSecret,
                              clientName: changersEnv.clientName,
                              environment: changersEnv
        )
    }

    static var changersUUID: String? {
        set(uuid) {
            UserDefaults.standard.set(uuid, forKey: "userUUID")
        }
        get {
            return UserDefaults.standard.string(forKey: "userUUID")
        }
    }
    
    static var notificationIdentifier: String? {
        set(uuid) {
            UserDefaults.standard.set(uuid, forKey: "notificationIdentifier")
        }
        get {
            return UserDefaults.standard.string(forKey: "notificationIdentifier")
        }
    }

}
