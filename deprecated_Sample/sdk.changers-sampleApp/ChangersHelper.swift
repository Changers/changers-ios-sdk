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
    
    /// client secret provided by Changers, they are different between each env
    var clientSecret: String {
        switch self {
        case .development:
            return
        case .production:
            return
        case .stage:
            return
        }
    }
    /// client id provided by Changers, they are different between each env
    var clientId: Int {
        switch self {
        case .development:
            return
        case .production:
            return
        case .stage:
            return
        }
    }
    
    /// client named provided by Changers, they are different between each env
    var clientName: String {
        return ""
    }
}


struct ChangersHelper {
    
    static let changersEnv: ChangersEnv =

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

}
