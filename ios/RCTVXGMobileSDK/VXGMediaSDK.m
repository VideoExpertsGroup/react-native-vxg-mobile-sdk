
#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import "VXGMediaSDK.h"
#import "RCTRootView.h"
#import <React/RCTComponent.h>
#import <React/RCTBridgeModule.h>
#import <React/RCTEventDispatcher.h>

@implementation VXGMediaSDK
{
  MediaPlayer*  _player;
  MediaPlayerConfig* _config;
  RCTEventDispatcher *_eventDispatcher;
}

- (instancetype)initWithEventDispatcher:(RCTEventDispatcher *)eventDispatcher
{
  if (self = [super init]) {
    _eventDispatcher = eventDispatcher;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deviceOrientationChange:) name:@"UIDeviceOrientationDidChangeNotification" object:nil];
    
    _config = [[MediaPlayerConfig alloc] init];
    // default config
    _config.decodingType = 1; // HW – 1 //SW – 0
    _config.connectionNetworkProtocol = -1; //-1; //
    _config.numberOfCPUCores = 2;
    _config.synchroEnable = 1;
    _config.connectionBufferingTime = 3000;
    _config.connectionDetectionTime = 2500;
    _config.startPreroll = 0;
    _config.aspectRatioMode = 1;
  }
  
  return self;
}

- (void)dealloc
{
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)setConfig:(NSDictionary *) cnf {

    // TODO validate params

    if ([cnf objectForKey:@"connectionUrl"]) {
        _config.connectionUrl = [cnf objectForKey:@"connectionUrl"];
    }

    // HW – 1 //SW – 0
    if ([cnf objectForKey:@"decodingType"]) {
        _config.decodingType = [[cnf objectForKey:@"decodingType"] intValue];
    }

    if ([cnf objectForKey:@"connectionNetworkProtocol"]) {
        _config.connectionNetworkProtocol = [[cnf objectForKey:@"connectionNetworkProtocol"] intValue];
    }

    if ([cnf objectForKey:@"numberOfCPUCores"]) {
        _config.numberOfCPUCores = [[cnf objectForKey:@"numberOfCPUCores"] intValue];
    }

    if ([cnf objectForKey:@"synchroEnable"]) {
        _config.synchroEnable = [[cnf objectForKey:@"synchroEnable"] intValue];
    }

    if ([cnf objectForKey:@"connectionBufferingTime"]) {
        _config.connectionBufferingTime = [[cnf objectForKey:@"connectionBufferingTime"] intValue];
    }
    
    if ([cnf objectForKey:@"connectionDetectionTime"]) {
        _config.connectionBufferingTime = [[cnf objectForKey:@"connectionDetectionTime"] intValue];
    }

    if ([cnf objectForKey:@"startPreroll"]) {
        _config.startPreroll = [[cnf objectForKey:@"startPreroll"] intValue];
    }

    if ([cnf objectForKey:@"aspectRatioMode"]) {
        _config.aspectRatioMode =  [[cnf objectForKey:@"aspectRatioMode"]  intValue];
    }

    if ([cnf objectForKey:@"autoplay"]) {
      BOOL bAutoplay = [[cnf objectForKey:@"autoplay"] boolValue];
      if (bAutoplay == TRUE) {
        [self openSync];
      }
    }
}

- (void)openSync {
    if (_player == nil) {
        _player = [[MediaPlayer alloc] init:CGRectMake( 0, 0, 100, 100 )];
    }
    [self addSubview:[_player contentView]];
    self.autoresizesSubviews = TRUE;
    [_player Open:_config callback:nil]; // TODO callback
}

#pragma mark - Export

- (void)open: (RCTPromiseResolveBlock) resolve reject:(RCTPromiseRejectBlock) reject {
  [self openSync];
  resolve(@{@"status": @"ok"});
}

#pragma mark - Export

- (void)close: (RCTPromiseResolveBlock) resolve reject:(RCTPromiseRejectBlock) reject {
  [_player Close];
  resolve(@{@"status": @"ok"});
}

#pragma mark - Export

- (void)play: (RCTPromiseResolveBlock) resolve reject:(RCTPromiseRejectBlock) reject {
  [_player Play:0];
  resolve(@{@"status": @"ok"});
}

#pragma mark - Export

- (void)pause: (RCTPromiseResolveBlock) resolve reject:(RCTPromiseRejectBlock) reject {
  [_player Pause];
  resolve(@{@"status": @"ok"});
}

#pragma mark - Export

- (void)applyConfig:(NSDictionary *) cnf resolve: (RCTPromiseResolveBlock) resolve reject:(RCTPromiseRejectBlock) reject {
  [self setConfig: cnf];
  // TODO reject if something wrong
  resolve(@{@"status": @"ok"});
}

- (void)layoutSubviews
{
    [super layoutSubviews];
}

- (void)viewDidDisappear:(BOOL)animated {
    NSLog(@"viewDidDisappear");
}

- (void)deviceOrientationChange:(NSNotification *)notification
{
  
    UIDeviceOrientation orientation = [[UIDevice currentDevice] orientation];
    
    switch (orientation) {
        case UIDeviceOrientationPortrait:
        case UIDeviceOrientationPortraitUpsideDown:
            break;

        case UIDeviceOrientationLandscapeLeft:
        case UIDeviceOrientationLandscapeRight:
            break;

        default:
            break;
    }
}


@end
