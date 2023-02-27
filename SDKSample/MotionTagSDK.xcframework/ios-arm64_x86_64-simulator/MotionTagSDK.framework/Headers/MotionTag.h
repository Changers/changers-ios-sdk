//
//  MotionTag.h
//  Pods
//
//  Created by Sebastian Vogelsang on 17.05.16.
//
//

#ifndef MotionTag_h
#define MotionTag_h

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <UIKit/UIKit.h>

@protocol MotionTagDelegate;

@protocol MotionTag
@property (nonatomic, assign, readonly) BOOL isTrackingActive;
@property (nonatomic, strong) NSString * _Nullable userToken;
@property (nonatomic, assign) BOOL wifiOnlyDataTransfer;
@property (nonatomic, assign, readonly) BOOL hasRequiredPermissions;
@property (nonatomic, assign, readonly) BOOL isLocationServicesEnabled;
@property (nonatomic, strong, readonly) NSString * _Nonnull version;

- (void)initializeUsing:(NSObject<MotionTagDelegate>* _Nonnull) delegate
           launchOption:(NSDictionary<UIApplicationLaunchOptionsKey, id> * _Nullable) launchOptions;

- (void)start;
- (void)stop;
- (void)handleEventsForBackgroundURLSession:(NSString* _Nonnull) identifier completionHandler:(void (^ _Nonnull)(void)) completionHandler;
- (void)clearDataWithCompletionHandler:(void (^ _Nonnull)(void))completionHandler;
@end


@interface MotionTagCore : NSObject
@property (class, readonly) NSObject<MotionTag>* _Nonnull sharedInstance;
@end

@protocol MotionTagDelegate <NSObject>
@required
- (void)trackingStatusChanged:(BOOL) isTracking;
@required
- (void)locationAuthorizationStatusDidChange:(CLAuthorizationStatus)status precise:(BOOL)precise;
@optional
- (void)motionActivityAuthorized:(BOOL)authorized;
@optional
- (void)didTrackLocation:(nonnull CLLocation*)location;
@optional
- (void)dataUploadWithTrackedFrom:(nonnull NSDate*)startDate to:(nonnull NSDate*)endDate didCompleteWithError:(nullable NSError*)error;
@end

#endif /* MotionTag_h */
