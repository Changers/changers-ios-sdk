# changers-ios-sdk

## 1. App Settings
+ Activate Capabilities -> Background Modes -> Location Updates
+ Add to Info.plist: 
	+ "Privacy - Motion Usage Description" string // e.g: For the automatic measurement of distances we need the option "Always Allow"
	+ "Privacy - Location Always & When in Use Description" string // e.g: For the automatic measurement of distances we need the option "Always Allow"
	+ "Privacy - When in Use Description" string // e.g: For the automatic measurement of distances we need the option "Allow While Using App".
	+ "Privacy - Motion Usage Description" string // e.g: For the automatic tracking measurement we need the access of the Motion Activity
	+"Privacy - Camera Usage Description" string // e.g: The use of the camera allows you to redeem Climate Coins and to take part in climate measures.

+ minimum deployment target 13.0

## Authorizations
The SDK requires two authorizations:  

1. Location (Always)
2. Motion

Both authorizations are requested by the Changers SDK when needed.

### Automatic Tracking
To function properly the SDK requires the **'Always'** location permission and the **Motion & Fitness** permission.


## 1. Installation

### Manually

You can also drag and drop the Changers SDK [here](https://github.com/Changers/changers-ios-sdk/tree/master/SDKSample/ChangersSDK.xcframework)

```
  Manually drag and drop `ChangersSDK.xcframework` to your project
```

**Note**: to run on simulator you need to exclude arm64 architecture from the iOS Simulator

### MotionTagSDK

**MotionTagSDK** needs to be installed manually to your project. MotionTagSDK available [Here](https://github.com/Changers/changers-ios-sdk/tree/master/SDKSample/MotionTagSDK.xcframework)


```
  Manually drag and drop `MotionTagSDK.xcframework` to Your project
```

  
## 2. Interface from ChangersInstance singleton

```
var isLoggedIn: Bool { get }
func registerUser(authenticationDelegate: ChangersAuthenticationDelegate? = nil, setupDelegate: ChangersDelegate? = nil)
func loginUser(uuid: UUID, authenticationDelegate: ChangersAuthenticationDelegate? = nil, setupDelegate: ChangersDelegate? = nil)
func logoutUser()
func load(config: ChangersConfig)
func handleEvents(forBackgroundURLSession identifier: String, completionHandler: @escaping () -> Void)
func loadWebApp(on viewController: UIViewController, completion: (() -> Void)? = nil, dismissCompletion: (() -> Void)? = nil)
func webApp(with dismissCompletion: (() -> Void)? = nil) -> UIViewController
```


```
public protocol ChangersDelegate: class {
    func setupDidFinish()
    func setupDidFail(with error: ChangersAuthenticateError?)
}
```

```
public protocol ChangersAuthenticationDelegate: class {
    func didSetupUser(with uiid: String)
}
```




## 3. Implementation

the following needs be done as soon as possible within the didFinishLauchingWithOptions
```
let changersTracking = ChangersTracking.sharedInstance
changersTracking.initializeMotionTag(with: launchOptions)
ChangersInstance.shared().load(config: ChangersConfig)
```

ChangersConfig is initialized with 4 arguments
```
///  this is needed in order to setup the SDK ⚠️ You cannot override an app which has a different environement set, make sure to uninstall > install
clientId: clientSecret provided by Changers, they are different between environment ( stage, prod, dev )
clientSecret: clientSecret provided by Changers, they are different between environment ( stage, prod, dev )
clientName:  clientName provided by Changers, they are different between environment ( stage, prod, dev )
environment: ChangersEnv.stage, ChangersEnv.production or ChangersEnv.developemtn. default  is .stage
  
public init(clientId: Int, clientSecret: String, clientName: String, environment: ChangersEnv = .stage)
```
**note**: the clientId, clientName, clientSecret are environement based, and needs to be given by Changers. In the sample app you will find sandbox credentials for the ChangersEnv.stage environement.

To switch between staging and production environments use the `ChangersEnv` enum with the desired value when creating the config


Must be called from the handleEventsForBackgroundURLSession method of the UIApplicationDelegate. It's accessible using the ChangersTracking sharedInstance
```
func handleEvents(forBackgroundURLSession identifier: String, completionHandler: @escaping () -> Void)
```


To check if an user is already logged in
```
var isLoggedIn: Bool { get }
```

If you want to register a new user, or log an user in, you must first logout an user if already logged in
```
func logoutUser()
```

To register an user as a guest.
```
func registerUser(authenticationDelegate: ChangersAuthenticationDelegate? = nil, setupDelegate: ChangersDelegate? = nil)
```

To log a user in
```
func loginUser(uuid: UUID, authenticationDelegate: ChangersAuthenticationDelegate? = nil, setupDelegate: ChangersDelegate? = nil)
```

You can either get the viewController and embeed it wherere you want
```
func webApp(with dismissCompletion: (() -> Void)? = nil) -> UIViewController
```

You can load the viewController from a viewController
```
func loadWebApp(on viewController: UIViewController, completion: (() -> Void)? = nil, dismissCompletion: (() -> Void)? = nil)
```


## 4. Errors


```
enum ChangersSDKError: Error {
    case unknownError
    case connectionError
    case credentialsError
    case configError
}
```

## 5. Universal links
We use universal links to show the offer after scanning a QR code

To enable universal links you will have to provide us with your apple team ID & bundle ID so we can update our `apple-app-site-association` file on the server.

Then you will have to enable assosiated domain in your project to do that head to project settings > signing & capabilities > tap + icon > associated domains.

Add the following for production: `applinks:api.klima-taler.com/qrcodes/*` 
and for staging: `applinks:api.coin-stage.de/qrcodes/*` 

To handle when the app is opened with a universal link you will have to implement the following

```
func application(_ application: UIApplication,
                 continue userActivity: NSUserActivity,
                 restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {

    guard let incomingURL = userActivity.webpageURL else {
        return false
    }

    ChangersInstance.shared().scannedQrCode(with: incomingURL.absoluteString)
    return true

}
```
This way we detect the url and pass it to the SDK to handle it accordingly

## 6. Example

Checkout the "SDKSample" folder for an example application.

