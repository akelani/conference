//
//  ViewController.m
//  iShowYou
//
//  Created by Yue Chang Hu on 12/14/12.
//  Copyright (c) 2012 Curiousminds. All rights reserved.
//
#import "TargetConditionals.h"
#import "ViewController.h"

#define SK_DEVEL 0
#if SK_DEVEL
static NSString *kUser1login = @"422.tom";
static NSString *kUser2login = @"422.tharper";
#else
static NSString *kUser1login = @"521.tom1";
static NSString *kUser2login = @"521.tom2";//@"12.agent2";
#endif

static NSString *kUser1password = @"harper98";
static NSString *kUser2password = @"harper98";

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (TARGET_IPHONE_SIMULATOR)
    {
    //__SHOWKIT_VERSION__ == "0.8.6"
    UIAlertView *simulatorAlert = [[UIAlertView alloc]initWithTitle:@"ShowKit Warning"
                                                      message:@"ShowKit requires version > 0.8.6 to make calls in the simulator"
                                                     delegate:self
                                            cancelButtonTitle:@"Ok"
                                            otherButtonTitles: nil];
    
    [simulatorAlert show];
    }
    // Showkit gets allocated on the first call to it
#if !TESTING_DYNAMIC_VIEWS
#if TESTING_DECODER_CALLBACK==0
    [ShowKit setState:self.mainVideoUIView forKey:SHKMainDisplayViewKey];
#endif
    [ShowKit setState:self.prevVideoUIView forKey:SHKPreviewDisplayViewKey];
#endif
    [ShowKit setState:SHKVideoLocalPreviewEnabled forKey:SHKVideoLocalPreviewModeKey];

    // Enable software encoder- must be done before logging in
    [ShowKit setState:SHKVideoDecodeDeviceSoftware forKey:SHKVideoDecodeDeviceKey];
    
#if TESTING_STATS
    [SHKStats shkSetDelegate:(id<SHKStatsDelegate>)self];
#endif
    
    //now listen for notification and log in.
    [[NSNotificationCenter defaultCenter] addObserver:self
                selector:@selector(connectionStateChanged:)
                    name:SHKConnectionStatusChangedNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(gotUserNotification:)
                                                 name:SHKUserMessageReceivedNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(gotDataNotification:)
                                                 name:SHKUserDataReceivedNotification
                                               object:nil];
    
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(shkRemoteClientStatusChanged:) name:SHKRemoteClientStateChangedNotification object:nil];


    [self getRandomColor];
}

- (void) viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:SHKConnectionStatusChangedNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:SHKUserMessageReceivedNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:SHKUserDataReceivedNotification object:nil];
}



-(BOOL) shouldAutorotate
{
    return YES;
}


-(NSUInteger) supportedInterfaceOrientations
{
    NSUInteger   orientation = UIInterfaceOrientationMaskPortrait;
    
    orientation |=  UIInterfaceOrientationMaskPortraitUpsideDown;
    orientation  |=  UIInterfaceOrientationMaskLandscapeLeft;
    orientation  |= UIInterfaceOrientationMaskLandscapeRight;
    return orientation;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)runTest:(id)sender {
    
    if([[[self.runTestOutlet titleLabel] text] isEqualToString:@"Test"]){
        
        //NSString* tempmsg = @"test sending a big message\0";
        //NSData *tempmsgD = [tempmsg dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:true];
        //[ShowKit sendData:tempmsgD];
        
        
        NSString* tempcmd = @"test sending text\0";
        NSData *tempmsgC = [tempcmd dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:true];
        [ShowKit sendText:tempmsgC];
    }
    
    if([[[self.runTestOutlet titleLabel] text] isEqualToString:@"DrawOff"]){
        [self.runTestOutlet setTitle: @"DrawOn" forState: UIControlStateNormal];
        [ShowKit setState:SHKDrawModeOn forKey:SHKDrawMode];
    } else {
        [self.runTestOutlet setTitle: @"DrawOff" forState: UIControlStateNormal];
        [ShowKit setState:SHKDrawModeOff forKey:SHKDrawMode];
    }
}

- (IBAction)toggleUser:(id)sender {
    if([[[self.toggleUserOutlet titleLabel] text] isEqualToString:@"User 1"]){
           [self.toggleUserOutlet setTitle: @"User 2" forState: UIControlStateNormal];
    }else{
            [self.toggleUserOutlet setTitle: @"User 1" forState: UIControlStateNormal];
    }
}

//self.toggleUserOutlet.hidden = false;
//self.shareOutlet.hidden = true;
- (IBAction)share:(id)sender {
    if([[[self.shareOutlet titleLabel] text] isEqualToString:@"Share"]){
        [self.shareOutlet setTitle: @"Unshare" forState: UIControlStateNormal];
        [self.runTestOutlet setTitle: @"DrawOff" forState: UIControlStateNormal];
        
        [ShowKit setState:SHKVideoInputDeviceScreen forKey:SHKVideoInputDeviceKey];
        [ShowKit setState:SHKGestureCaptureModeReceive forKey:SHKGestureCaptureModeKey];
        [ShowKit setState:SHKGestureCaptureLocalIndicatorsOn forKey:SHKGestureCaptureLocalIndicatorsModeKey];
        
    }else{
        [self.shareOutlet setTitle: @"Share" forState: UIControlStateNormal];
        [self.runTestOutlet setTitle: @"Test" forState: UIControlStateNormal];
        [ShowKit setState:SHKVideoInputDeviceFrontCamera forKey:SHKVideoInputDeviceKey];
        [ShowKit setState:SHKGestureCaptureModeOff forKey:SHKGestureCaptureModeKey];
        [ShowKit setState:SHKGestureCaptureLocalIndicatorsOff forKey:SHKGestureCaptureLocalIndicatorsModeKey];
    }
}


- (void) shkRemoteClientStatusChanged: (NSNotification*) notification
{
    SHKNotification* obj = [notification object] ;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        
        if ([obj.Key isEqualToString:SHKRemoteClientVideoInputKey])
        {
            if([(NSString*)obj.Value isEqualToString:SHKRemoteClientVideoInputScreen])
            {
                NSLog(@"Screen mode enabled!");
                
                //[ShowKit setState:SHKVideoScaleModeFit forKey: SHKVideoScaleModeKeyInternal];
                [ShowKit setState:SHKGestureCaptureLocalIndicatorsOn forKey:SHKGestureCaptureLocalIndicatorsModeKey];
                [ShowKit setState:SHKGestureCaptureModeBroadcast forKey:SHKGestureCaptureModeKey];
            } else {
                //NSString * mode = [ShowKit getStateForKey:SHKVideoScaleModeKey];
                //[ShowKit setState:mode forKey: SHKVideoScaleModeKeyInternal];
                [ShowKit setState:SHKGestureCaptureLocalIndicatorsOff forKey:SHKGestureCaptureLocalIndicatorsModeKey];
            }
        }
        else if([obj.Key isEqualToString:SHKRemoteClientGestureStateKey])
        {
            
#ifdef TEST_GESTURE_TOUCHES
            if([(NSString*)obj.Value isEqualToString:SHKRemoteClientGestureStateStarted])
            {
                [SHKTouches shkSetDelegate:(id<SHKTouchesDelegate>)self];
            } else {
                [SHKTouches shkSetDelegate:(id<SHKTouchesDelegate>)nil];
            }
#endif
        }
        else if([obj.Key isEqualToString:SHKRemoteClientVideoStateKey])
        {
            if([(NSString*)obj.Value isEqualToString:SHKRemoteClientVideoStateStarted])
            {
            } else {
            }
        }
        else if([obj.Key isEqualToString:SHKRemoteClientAudioStateKey])
        {
            if([(NSString*)obj.Value isEqualToString:SHKRemoteClientAudioStateStarted])
            {
            } else {
            }
            
        }
    });
}


- (IBAction)login:(id)sender {
    if ([[[self.loginOutlet titleLabel] text] isEqualToString:@"Login"]) {
        if([[[self.toggleUserOutlet titleLabel] text] isEqualToString:@"User 1"]){
        
            [ShowKit login:kUser1login password:kUser1password];
        }else{
            [ShowKit login:kUser2login password:kUser2password];
        }
        self.toggleUserOutlet.hidden = TRUE;
    }else{
        [ShowKit logout];
        [self.loginOutlet setTitle:@"Login" forState:UIControlStateNormal];
        self.toggleUserOutlet.hidden = false;
    }
}

- (IBAction)makeCall:(id)sender {
    if ([[[self.makeCallOutlet titleLabel] text] isEqualToString:@"Call"]) {
        
        if ([[[self.toggleUserOutlet titleLabel] text] isEqualToString:@"User 1"]) {
            [ShowKit initiateCallWithSubscriber:kUser2login];
        }else{
            [ShowKit initiateCallWithSubscriber:kUser1login];
        }
        [self.makeCallOutlet setTitle:@"End" forState:UIControlStateNormal];
    }else{
        [ShowKit hangupCall];
        [self.makeCallOutlet setTitle:@"Call" forState:UIControlStateNormal];
    }
}


- (void) getRandomColor {
    CGFloat hue = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;
    UIColor *temp = [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
    [self.mainVideoUIView setBackgroundColor:temp];
}

// this channel is primarily for short text messages/commands, and is reliable
- (void) gotUserNotification: (NSNotification*) n
{
    SHKNotification* s = (SHKNotification*) [n object];
    NSData* d = (NSData*)s.Value;
    NSString * v = (NSString*)[[NSString alloc] initWithData:d encoding:NSASCIIStringEncoding];
    NSString* msg = [NSString stringWithFormat: @"msg receivd: \"%@\"?", v];
    
    /*
    //swizzle same alert twice, crash
    UIAlertView *showMessage = [[UIAlertView alloc] initWithTitle:@"Incoming Message"
    message:msg delegate:nil cancelButtonTitle:@"Close" otherButtonTitles:@"Close", nil];
    static int cntr =0;
    [showMessage setTag:cntr++];
    [showMessage show];
     */
}


// This channel is for dealing with binary data, you decide what to do here
- (void) gotDataNotification: (NSNotification*) n
{
    SHKNotification* s ;
    NSData*          v ;
    
    s = (SHKNotification*) [n object];
    v = (NSData*)s.Value;
    
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:v];
    NSString *msg = [unarchiver decodeObjectForKey: @"skmessage"];
    [unarchiver finishDecoding];
}

//First, set up the handle the notification
- (void) connectionStateChanged: (NSNotification*) n
{
    SHKNotification* s ;
    NSString * v ;
    
    s = (SHKNotification*) [n object];
    v = (NSString*)s.Value;
    
    
    if ([v isEqualToString:SHKConnectionStatusCallTerminated]){
        [self.makeCallOutlet setTitle:@"Call" forState:UIControlStateNormal];
        
        [ShowKit setState:SHKVideoInputDeviceFrontCamera
                   forKey:SHKVideoInputDeviceKey];
        
        [ShowKit setState:SHKGestureCaptureModeOff
                   forKey:SHKGestureCaptureModeKey];
        
    } else if ([v isEqualToString:SHKConnectionStatusLoggedIn]) {
        [self.loginOutlet setTitle:@"Logout" forState:UIControlStateNormal];

#if (TEST_VIDEO_CAPTURE)
        [SHKEncoder shkSetDelegate:(id<SHKVideoCaptureDelegate>)self];
#endif
    } else if ([v isEqualToString:SHKConnectionStatusLoginFailed]) {
        [ShowKit hangupCall];
    } else if ([v isEqualToString:SHKConnectionStatusCallIncoming]) {

        NSString * mode = [ShowKit getStateForKey:SHKAppBackgroundedKey];
        if ([mode isEqualToString:SHKInForeground]) {
            UIAlertView *callIncoming = [[UIAlertView alloc] initWithTitle:@"Call Incoming"
                                                                   message:@"Would you like to accept the call?"
                                                                  delegate:self
                                                         cancelButtonTitle:@"Accept"
                                                         otherButtonTitles:@"Reject", nil];
            
            
            [callIncoming setTag:0];
            [callIncoming show];
        }
        else
        {
            UILocalNotification *localNotif = [[UILocalNotification alloc] init];
            localNotif.fireDate             = nil;
            localNotif.hasAction            = YES;
            localNotif.alertBody            = [NSString stringWithFormat:@"Incoming Call."];
            localNotif.alertAction          = NSLocalizedString(@"Accept Call", nil);
            localNotif.soundName            = UILocalNotificationDefaultSoundName;
            localNotif.applicationIconBadgeNumber = 1;
            
            [[UIApplication sharedApplication]presentLocalNotificationNow:localNotif];
        }
        
    }
    
    else if ([v isEqualToString:SHKConnectionStatusInCall]) {
        
        NSLog(@"In Call");
#if TESTING_DYNAMIC_VIEWS
        //set the main video view
        [ShowKit setState:self.mainVideoUIView forKey:SHKMainDisplayViewKey];
        
        //set the main preview view
        [ShowKit setState:self.prevVideoUIView forKey:SHKPreviewDisplayViewKey];
        
        //set the main preview view
       // [ShowKit setState:SHKVideoLocalPreviewEnabled forKey:SHKVideoLocalPreviewModeKey];
#endif
#if TESTING_DECODER_CALLBACK
        [ShowKit setVideoBufferCallback:^(uint8_t*data, long width, long height, PixelFormat pixelFormat, BOOL isEncoding) {
            [self renderWithData:data width:width height:height pixelFormat:pixelFormat isEncoding:isEncoding];
        }];
#endif
    }
}


-(void)renderWithData:(uint8_t*)data width:(long)width height:(long)height pixelFormat:(PixelFormat)pixelFormat isEncoding:(BOOL)isEncoding {
    
}

- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (alertView.tag) {
        case 0:
            if (buttonIndex == 0) {
                [self.makeCallOutlet setTitle:@"End" forState:UIControlStateNormal];
                [ShowKit acceptCall];
            }else{
                [ShowKit rejectCall];
            }
            break;
            
        default:
            break;
    }
}

#if TESTING_STATS
- (void)shkStatsNotification:(StatsStruct*)stats
{
    StatsStruct local;
    memcpy(&local, stats, sizeof(StatsStruct));
}
#endif 

#if TEST_GESTURE_TOUCHES
//SHKTouchesDelegate
- (void)shkTouchesBegan:(CGPoint)point {
    printf("got touch began");
}
- (void)shkTouchesMoved:(CGPoint)point {
    printf("got touch moved");
}
- (void)shkTouchesEnded:(CGPoint)point {
    printf("got touch ended");
}
- (void)shkTouchesCancelled:(CGPoint)point {
    printf("got touch cancelled");
}
#endif

#if TEST_VIDEO_CAPTURE
//SHKVideoCaptureDelegate
- (void)StartCapture {
    self.encodeTimer = [NSTimer scheduledTimerWithTimeInterval:(1.f/30.f) target:self selector:@selector(encodeFrame) userInfo:nil repeats:YES];
}
- (void)StopCapture {
    [self.encodeTimer invalidate];
    self.encodeTimer = nil;
}
- (void)Initialize:(int)width height:(int)height fps:(int)fps{
    m_width = width;
    m_height = height;
}

-(void)encodeFrame {
    
    int len = (m_width*m_height*3)>>1;
    unsigned char* pBuf = new unsigned char[len];
    unsigned char* pBuf1 = pBuf + (m_width*m_height);
    unsigned char* pBuf2 = pBuf + (5*m_width*m_height)/4;
    
    int x, y, i;
    i = m_count++;
    
    for(y=0;y<m_height;y++) {
        for(x=0;x<m_width;x++) {
            pBuf[y * m_width + x] = x + y + i * 3;
        }
    }
    for(y=0;y<m_height/2;y++) {
        for(x=0;x<m_width/2;x++) {
            pBuf1[y * (m_width>>1) + x] = 128 + y + i * 2;
            pBuf2[y * (m_width>>1) + x] = 64 + x + i * 5;
        }
    }
    
    [SHKEncoder shkEncodeFrame:pBuf width:m_width height:m_height length:len colorspace:kCVPixelFormatType_420YpCbCr8BiPlanarVideoRange mediatime:m_count];
    
    delete pBuf;
}

#endif

@end
