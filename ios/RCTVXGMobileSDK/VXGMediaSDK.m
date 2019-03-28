
#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import "VXGMediaSDK.h"
#import "RCTRootView.h"
#import <React/RCTComponent.h>
#import <React/RCTBridgeModule.h>
#import <React/RCTEventDispatcher.h>
#import <React/RCTLog.h>

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
        NSString *toLog = [NSString stringWithFormat:@"VXGMediaSDK: connectionUrl = %@", _config.connectionUrl];
        RCTLogInfo(toLog);
    }

    // HW – 1 //SW – 0
    if ([cnf objectForKey:@"decodingType"]) {
        _config.decodingType = [[cnf objectForKey:@"decodingType"] intValue];
        NSString *toLog = [NSString stringWithFormat:@"VXGMediaSDK: decodingType = %i", _config.decodingType];
        RCTLogInfo(toLog);
    }

    if ([cnf objectForKey:@"connectionNetworkProtocol"]) {
        _config.connectionNetworkProtocol = [[cnf objectForKey:@"connectionNetworkProtocol"] intValue];
        NSString *toLog = [NSString stringWithFormat:@"VXGMediaSDK: connectionNetworkProtocol = %i", _config.connectionNetworkProtocol];
        RCTLogInfo(toLog);
    }

    if ([cnf objectForKey:@"numberOfCPUCores"]) {
        _config.numberOfCPUCores = [[cnf objectForKey:@"numberOfCPUCores"] intValue];
        NSString *toLog = [NSString stringWithFormat:@"VXGMediaSDK: numberOfCPUCores = %i", _config.numberOfCPUCores];
        RCTLogInfo(toLog);
    }

    if ([cnf objectForKey:@"synchroEnable"]) {
        _config.synchroEnable = [[cnf objectForKey:@"synchroEnable"] intValue];
        NSString *toLog = [NSString stringWithFormat:@"VXGMediaSDK: synchroEnable = %i", _config.synchroEnable];
        RCTLogInfo(toLog);
    }

    if ([cnf objectForKey:@"connectionBufferingTime"]) {
        _config.connectionBufferingTime = [[cnf objectForKey:@"connectionBufferingTime"] intValue];
        NSString *toLog = [NSString stringWithFormat:@"VXGMediaSDK: connectionBufferingTime = %i", _config.connectionBufferingTime];
        RCTLogInfo(toLog);
    }
    
    if ([cnf objectForKey:@"connectionDetectionTime"]) {
        _config.connectionBufferingTime = [[cnf objectForKey:@"connectionDetectionTime"] intValue];
        NSString *toLog = [NSString stringWithFormat:@"VXGMediaSDK: connectionDetectionTime = %i", _config.connectionDetectionTime];
        RCTLogInfo(toLog);
    }

    if ([cnf objectForKey:@"startPreroll"]) {
        _config.startPreroll = [[cnf objectForKey:@"startPreroll"] intValue];
        NSString *toLog = [NSString stringWithFormat:@"VXGMediaSDK: startPreroll = %i", _config.startPreroll];
        RCTLogInfo(toLog);
    }

    if ([cnf objectForKey:@"aspectRatioMode"]) {
        _config.aspectRatioMode =  [[cnf objectForKey:@"aspectRatioMode"]  intValue];
        NSString *toLog = [NSString stringWithFormat:@"VXGMediaSDK: aspectRatioMode = %i", _config.aspectRatioMode];
        RCTLogInfo(toLog);
    }

    if ([cnf objectForKey:@"autoplay"]) {
        BOOL bAutoplay = [[cnf objectForKey:@"autoplay"] boolValue];
        if (bAutoplay == TRUE) {
            RCTLogInfo(@"VXGMediaSDK: autoplay enabled");
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
