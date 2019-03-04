#ifndef VXGMediaPlayer_h
#define VXGMediaPlayer_h

#import <React/RCTComponent.h>
#import <React/RCTBridgeModule.h>

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>
#import "MediaPlayer.h"
#import "M3U8.h"
#import "Thumbnailer.h"

@class RCTEventDispatcher;

@interface VXGMediaSDK : UIView

- (instancetype)initWithEventDispatcher:(RCTEventDispatcher *)eventDispatcher NS_DESIGNATED_INITIALIZER;
- (void)openSync;
- (void)open: (RCTPromiseResolveBlock) resolve reject:(RCTPromiseRejectBlock)reject;
- (void)close: (RCTPromiseResolveBlock) resolve reject:(RCTPromiseRejectBlock)reject;
- (void)play: (RCTPromiseResolveBlock) resolve reject:(RCTPromiseRejectBlock)reject;
- (void)pause: (RCTPromiseResolveBlock) resolve reject:(RCTPromiseRejectBlock)reject;
- (void)applyConfig:(NSDictionary *) cnf resolve: (RCTPromiseResolveBlock) resolve reject:(RCTPromiseRejectBlock) reject;
@end

#endif /* VXGMediaPlayer_h */
