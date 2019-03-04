#import <MapKit/MapKit.h>

#import <React/RCTViewManager.h>
#import <React/RCTLog.h>
#import <React/RCTUIManager.h>
#import "RCTVXGMobileSDKManager.h"
#import "VXGMediaSDK.h"
#import <React/RCTBridge.h>


@implementation RCTVXGMobileSDKManager

RCT_EXPORT_MODULE();

- (UIView *)view
{
  return [[VXGMediaSDK alloc] initWithEventDispatcher:self.bridge.eventDispatcher];
}

- (dispatch_queue_t)methodQueue
{
  return self.bridge.uiManager.methodQueue;
}

RCT_EXPORT_VIEW_PROPERTY(config, NSDictionary);

RCT_REMAP_METHOD(open,
                 open: (nonnull NSNumber *)reactTag
                 resolver:(RCTPromiseResolveBlock)resolve
                 rejecter:(RCTPromiseRejectBlock)reject)
{
  [self.bridge.uiManager prependUIBlock:^(__unused RCTUIManager *uiManager, NSDictionary<NSNumber *, VXGMediaSDK *> *viewRegistry) {
    RCTLogInfo(@"open");
    VXGMediaSDK *view = viewRegistry[reactTag];
    if (![view isKindOfClass:[VXGMediaSDK class]]) {
      RCTLogError(@"Invalid view returned from registry, expecting VXGMediaSDK, got: %@", view);
    } else {
      [view open:resolve reject:reject];
    }
  }];
}

// reactTag: (nonnull NSNumber *) reactTag

RCT_REMAP_METHOD(close,
                 close: (nonnull NSNumber *) reactTag
                 resolver: (RCTPromiseResolveBlock) resolve
                 rejecter: (RCTPromiseRejectBlock) reject
) {
  [self.bridge.uiManager prependUIBlock:^(__unused RCTUIManager *uiManager, NSDictionary<NSNumber *, VXGMediaSDK *> *viewRegistry) {
    RCTLogInfo(@"close");
    VXGMediaSDK *view = viewRegistry[reactTag];
    if (![view isKindOfClass:[VXGMediaSDK class]]) {
      RCTLogError(@"Invalid view returned from registry, expecting VXGMediaSDK, got: %@", view);
    } else {
      [view close:resolve reject:reject];
    }
  }];
}

RCT_REMAP_METHOD(play,
                 play: (nonnull NSNumber *)reactTag
                 resolver: (RCTPromiseResolveBlock)resolve
                 rejecter: (RCTPromiseRejectBlock)reject)
{
  [self.bridge.uiManager prependUIBlock:^(__unused RCTUIManager *uiManager, NSDictionary<NSNumber *, VXGMediaSDK *> *viewRegistry) {
    RCTLogInfo(@"play");
    VXGMediaSDK *view = viewRegistry[reactTag];
    if (![view isKindOfClass:[VXGMediaSDK class]]) {
      RCTLogError(@"Invalid view returned from registry, expecting VXGMediaSDK, got: %@", view);
    } else {
      [view play:resolve reject:reject];
    }
  }];
}

RCT_REMAP_METHOD(pause,
                 pause: (nonnull NSNumber *) reactTag
                 resolver: (RCTPromiseResolveBlock) resolve
                 rejecter: (RCTPromiseRejectBlock) reject)
{
  RCTLogInfo(@"pause");
  [self.bridge.uiManager prependUIBlock:^(__unused RCTUIManager *uiManager, NSDictionary<NSNumber *, VXGMediaSDK *> *viewRegistry) {
    VXGMediaSDK *view = viewRegistry[reactTag];
    if (![view isKindOfClass:[VXGMediaSDK class]]) {
      RCTLogError(@"Invalid view returned from registry, expecting VXGMediaSDK, got: %@", view);
    } else {
      [view pause:resolve reject:reject];
    }
  }];
}


RCT_REMAP_METHOD(applyConfig,
                 applyConfig: (NSDictionary *) cnf
                 reactTag: (nonnull NSNumber *)reactTag
                 resolver: (RCTPromiseResolveBlock)resolve
                 rejecter: (RCTPromiseRejectBlock)reject)
{
  RCTLogInfo(@"applyConfig");
  [self.bridge.uiManager prependUIBlock:^(__unused RCTUIManager *uiManager, NSDictionary<NSNumber *, VXGMediaSDK *> *viewRegistry) {
    VXGMediaSDK *view = viewRegistry[reactTag];
    if (![view isKindOfClass:[VXGMediaSDK class]]) {
      RCTLogError(@"Invalid view returned from registry, expecting VXGMediaSDK, got: %@", view);
    } else {
      [view applyConfig: cnf resolve:resolve reject:reject];
    }
  }];
}

+ (BOOL)requiresMainQueueSetup
{
  return YES;
}

@end
