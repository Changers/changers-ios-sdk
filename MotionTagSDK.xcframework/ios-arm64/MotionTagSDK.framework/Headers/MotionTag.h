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

#define kMTDataTransferMode @"kMTDataTransferMode"
#define kMTBatterySavingsMode @"kMTBatterySavingsMode"
#define kMTSendingMode @"kMTSendingMode"

typedef NS_ENUM(NSUInteger, MTDataTransferMode) {
    kDataTransferModeWifiOnly NS_SWIFT_NAME(wifiOnly),
    kDataTransferMode3G NS_SWIFT_NAME(wifiAnd3G)
}NS_SWIFT_NAME(DataTransferMode);


@protocol MotionTagDelegate;

@protocol MotionTag
@property (nonatomic, readonly) BOOL isTrackingActive;
@property (nonatomic, strong, readonly) NSNumber * _Nonnull trackingActiveAsInt;
@property (nonatomic, weak) id <MotionTagDelegate> _Nullable delegate;

- (void)startWithToken:(nullable NSString*)token;
- (void)startWithToken:(nullable NSString*)token settings:(nullable NSDictionary*)settingsDict;
- (void)stop;
- (void)useWifiOnlyDataTransfer:(BOOL)on;
- (void)checkIn;
- (void)checkOut;
- (void)registerCallback:(void (^_Nonnull)(void))completionHandler forIdentifier:(NSString *_Nonnull)identifier;
@end


@interface MotionTagCore : NSObject
+ (NSObject<MotionTag>*_Nonnull)sharedInstanceWithToken:(nullable NSString*)token
                                               settings:(nullable NSDictionary*)settingsDict
                                             completion:(nullable void(^)(void))completion;

-(void) setDelegate:(nullable id<MotionTagDelegate>)delegate;
@end

@protocol MotionTagDelegate <NSObject>
@optional
- (void)trackingStatusChanged:(BOOL) isTracking;
- (void)locationAuthorizationStatusDidChange:(CLAuthorizationStatus)status precise:(BOOL)precise;
- (void)motionActivityAuthorized:(BOOL)authorized;
- (void)didTrackLocation:(nonnull CLLocation*)location;
- (void)didTransmitData:(nonnull NSDate*)transmissionTimestamp lastEventTimestamp:(nonnull NSDate*)lastEventTimestamp;
@end

#endif /* MotionTag_h */
