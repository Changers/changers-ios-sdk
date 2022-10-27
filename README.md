# changers-ios-sdk

## 1. App Settings
+ Activate Capabilities -> Background Modes -> Location Updates
+ Add to Info.plist: 
	+ "Privacy - Motion Usage Description" string // e.g: For the automatic measurement of distances we need the option "Always Allow"
	+ "Privacy - Location Always & When in Use Description" string // e.g: For the automatic measurement of distances we need the option "Always Allow"
	+ "Privacy - When in Use Description" string // e.g: For the automatic measurement of distances we need the option "Allow While Using App".
	+ "Privacy - Motion Usage Description" string // e.g: For the automatic tracking measurement we need the access of the Motion Activity

+ minimum deployment target 11.0

## Authorizations
The SDK requires two authorizations:  

1. Location (Always)
2. Motion

Both authorizations are requested by the Changers SDK when needed.

### Automatic Tracking
To function properly the SDK requires the **'Always'** location permission and the **Motion & Fitness** permission.


## 1. Installation

### CocoaPods

⚠️ THIS NEEDS TO BE UPDATED FOR NOW PLEASE IGNORE COCOAPODS AND USE MANUALLY INSTALL ⚠️

[CocoaPods](https://cocoapods.org) is a dependency manager for Cocoa projects. For usage and installation instructions, visit their website. To integrate Alamofire into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
 pod "changers-ios-sdk", :git => 'https://github.com/Changers/changers-ios-sdk.git'
```

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
_ = ChangersTracking.sharedInstance
ChangersInstance.shared().load(config: ChangersConfig)
```

**note**: the clientId, clientName, clientSecret are environement based, and needs to be given by Changers. In the sample app you will find sandbox credentials for the ChangersEnv.stage environement.


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


## 7. Example

Checkout the "SDKSample" folder for an example application.

