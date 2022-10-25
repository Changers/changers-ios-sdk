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

@protocol MotionTagDelegate;

@protocol MotionTag
@property (nonatomic, weak) id <MotionTagDelegate> _Nullable delegate;
@property (nonatomic, readonly) BOOL isTrackingActive;
@property (nonatomic, strong) NSString * _Nonnull userToken;
@property (nonatomic, assign) BOOL wifiOnlyDataTransfer;
- (void)start;
- (void)stop;
- (void)handleEventsForBackgroundURLSession:(NSString* _Nonnull) identifier completionHandler:(void (^ _Nonnull)(void))completionHandler;
- (void)clearDataWithCompletionHandler:(void (^ _Nonnull)(void))completionHandler;
@end


@interface MotionTagCore : NSObject
@property (class, readonly) NSObject<MotionTag>* _Nonnull sharedInstance;
@end

@protocol MotionTagDelegate <NSObject>
@optional
- (void)trackingStatusChanged:(BOOL) isTracking;
- (void)locationAuthorizationStatusDidChange:(CLAuthorizationStatus)status precise:(BOOL)precise;
- (void)motionActivityAuthorized:(BOOL)authorized;
- (void)didTrackLocation:(nonnull CLLocation*)location;
- (void)dataUploadWithTrackedFrom:(nonnull NSDate*)startDate to:(nonnull NSDate*)endDate didCompleteWithError:(nullable NSError*)error;
@end

#endif /* MotionTag_h */
