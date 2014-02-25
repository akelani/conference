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
    UIAlertView *simulatorAlert = [[UIAlertView alloc]initWithTitle:@"ShowKit Warning"
                                                      message:@"ShowKit cannot make or receive calls when running on the simulator."
                                                     delegate:self
                                            cancelButtonTitle:@"Ok"
                                            otherButtonTitles: nil];
    
    [simulatorAlert show];
    }
    [ShowKit setState:self.mainVideoUIView forKey:SHKMainDisplayViewKey];
    [ShowKit setState:self.prevVideoUIView forKey:SHKPreviewDisplayViewKey];
    [ShowKit setState:SHKVideoLocalPreviewEnabled forKey:SHKVideoLocalPreviewModeKey];
    
    //now listen for notification and log in.
    [[NSNotificationCenter defaultCenter] addObserver:self
                selector:@selector(connectionStateChanged:)
                    name:SHKConnectionStatusChangedNotification
                  object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(gotUserNotification:)
                                                 name:SHKUserMessageReceivedNotification
                                               object:nil];
    
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(shkRemoteClientStatusChanged:) name:SHKRemoteClientStateChangedNotification object:nil];
    
    [self getRandomColor];
}

- (void) viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:SHKConnectionStatusChangedNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:SHKUserMessageReceivedNotification object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)runTest:(id)sender {
    
    NSString* tempmsg = @"test sending a big message";
    NSData *tempmsgD = [tempmsg dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:true];
    [ShowKit sendMessage:tempmsgD];
    

    NSString* tempcmd = @"test sending a big cmd";
    NSData *tempmsgC = [tempcmd dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:true];
    [ShowKit sendCommand:tempmsgC];
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
        [self.shareOutlet setTitle: @"End Share" forState: UIControlStateNormal];
        
        [ShowKit setState:SHKVideoInputDeviceScreen
                   forKey:SHKVideoInputDeviceKey];
        
        [ShowKit setState:SHKGestureCaptureModeReceive
                   forKey:SHKGestureCaptureModeKey];
        
        [ShowKit setState:SHKGestureCaptureLocalIndicatorsOn forKey:SHKGestureCaptureLocalIndicatorsModeKey];
        
    }else{
        [self.shareOutlet setTitle: @"Share" forState: UIControlStateNormal];
        [ShowKit setState:SHKVideoInputDeviceFrontCamera
                   forKey:SHKVideoInputDeviceKey];
        
        [ShowKit setState:SHKGestureCaptureModeOff
                   forKey:SHKGestureCaptureModeKey];
        
        
        [ShowKit setState:SHKGestureCaptureLocalIndicatorsOff forKey:SHKGestureCaptureLocalIndicatorsModeKey];
        
    }
}


- (void) shkRemoteClientStatusChanged: (NSNotification*) notification
{
    SHKNotification* obj = [notification object] ;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        
        if([obj.Key isEqualToString:SHKRemoteClientVideoInputKey])
        {
            if([(NSString*)obj.Value isEqualToString:SHKRemoteClientVideoInputScreen])
            {
                NSLog(@"Screen mode enabled!");
                [ShowKit setState:SHKVideoScaleModeFit forKey: SHKVideoScaleModeKey];
                [ShowKit setState:SHKGestureCaptureLocalIndicatorsOn forKey:SHKGestureCaptureLocalIndicatorsModeKey];
                if (![[ShowKit getStateForKey:SHKGestureCaptureModeKey] isEqualToString:SHKGestureCaptureModeBroadcast]) {
                    [ShowKit setState:SHKGestureCaptureModeBroadcast forKey:SHKGestureCaptureModeKey];
                }
            } else {
                [ShowKit setState:SHKVideoScaleModeFill forKey: SHKVideoScaleModeKey];
                [ShowKit setState:SHKGestureCaptureLocalIndicatorsOff forKey:SHKGestureCaptureLocalIndicatorsModeKey];
                if (![[ShowKit getStateForKey:SHKGestureCaptureModeKey] isEqualToString:SHKGestureCaptureModeOff]) {
                    [ShowKit setState:SHKGestureCaptureLocalIndicatorsOff forKey:SHKGestureCaptureLocalIndicatorsModeKey];
                }
            }
        }
        else if([obj.Key isEqualToString:SHKRemoteClientDeviceOrientationKey])
        {
            if([(NSString*)obj.Value isEqualToString:SHKRemoteClientDeviceOrientationLandscapeLeft])
            {
            }
            else if([(NSString*)obj.Value isEqualToString:SHKRemoteClientDeviceOrientationLandscapeRight])
            {
            }
            else if([(NSString*)obj.Value isEqualToString:SHKRemoteClientDeviceOrientationPortrait])
            {
            }
            else
            {
            }
        }
        else if([obj.Key isEqualToString:SHKRemoteClientGestureStateKey])
        {
            if([(NSString*)obj.Value isEqualToString:SHKRemoteClientGestureStateStarted])
            {
            } else {
            }
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
        [self.makeCallOutlet setTitle:@"End Call" forState:UIControlStateNormal];
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

//First, set up the handle the notification
- (void) gotUserNotification: (NSNotification*) n
{
    SHKNotification* s ;
    NSData* d;
    NSString * v ;
    s = (SHKNotification*) [n object];
    d = (NSData*)s.Value;
    v = (NSString*)[[NSString alloc] initWithData:d encoding:NSASCIIStringEncoding];
    NSString* msg = [NSString stringWithFormat: @"msg receivd: \"%@\"?", v];
    
    //swizzle same alert twice, crash
    //UIAlertView *showMessage = [[UIAlertView alloc] initWithTitle:@"Incoming Message"
    //message:msg delegate:nil cancelButtonTitle:@"Close" otherButtonTitles:@"Close", nil];
    //static int cntr =0;
    //[showMessage setTag:cntr++];
    //[showMessage show];
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
    } else if ([v isEqualToString:SHKConnectionStatusLoginFailed]) {
        [ShowKit hangupCall];
    } else if ([v isEqualToString:SHKConnectionStatusCallIncoming]) {
        UIAlertView *callIncoming = [[UIAlertView alloc] initWithTitle:@"Call Incoming"
                                                                    message:@"Would you like to accept the call?"
                                                                   delegate:self
                                                          cancelButtonTitle:@"Accept"
                                                          otherButtonTitles:@"Reject", nil];
        [callIncoming setTag:0];
        [callIncoming show];
    }
    
    else if ([v isEqualToString:SHKConnectionStatusInCall]) {
        
        NSLog(@"In Call");
        
        //set the main video view
        [ShowKit setState:self.mainVideoUIView forKey:SHKMainDisplayViewKey];
        
        //set the main preview view
        [ShowKit setState:self.prevVideoUIView forKey:SHKPreviewDisplayViewKey];
        
    }
}

- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (alertView.tag) {
        case 0:
            if (buttonIndex == 0) {
                [self.makeCallOutlet setTitle:@"End Call" forState:UIControlStateNormal];
                [ShowKit acceptCall];
            }else{
                [ShowKit rejectCall];
            }
            break;
            
        default:
            break;
    }
}

@end
