//
//  ViewController.m
//  iShowYou
//
//  Created by Yue Chang Hu on 12/14/12.
//  Copyright (c) 2012 Curiousminds. All rights reserved.
//
#import "TargetConditionals.h"
#import "ViewController.h"

static NSString *kUser1login = @"ENTER_USER_HERE";
static NSString *kUser2login = @"ENTER_USER2_HERE";
static NSString *kUser1password = @"ENTER_USER1_PASSWORD";
static NSString *kUser2password = @"ENTER_USER2_PASSWORD";

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
}

- (void) viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:SHKConnectionStatusChangedNotification object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)toggleUser:(id)sender {
    if([[[self.toggleUserOutlet titleLabel] text] isEqualToString:@"User 1"]){
        [self.toggleUserOutlet setTitle: @"User 2" forState: UIControlStateNormal];
    }else{
        [self.toggleUserOutlet setTitle: @"User 1" forState: UIControlStateNormal];
    }
}

- (IBAction)login:(id)sender {
    if ([[[self.loginOutlet titleLabel] text] isEqualToString:@"Login"]) {
        if([[[self.toggleUserOutlet titleLabel] text] isEqualToString:@"User 1"]){
            [ShowKit login:kUser1login password:kUser1password];
        }else{
            [ShowKit login:kUser2login password:kUser2password];
        }
    }else{
        [ShowKit logout];
        [self.loginOutlet setTitle:@"Login" forState:UIControlStateNormal];
    }
}

- (IBAction)makeCall:(id)sender {
    if ([[[self.makeCallOutlet titleLabel] text] isEqualToString:@"Make Call"]) {
        
        if ([[[self.toggleUserOutlet titleLabel] text] isEqualToString:@"User 1"]) {
            [ShowKit initiateCallWithUser:kUser2login];
        }else{
            [ShowKit initiateCallWithUser:kUser1login];
        }
        [self.makeCallOutlet setTitle:@"End Call" forState:UIControlStateNormal];
    }else{
        [ShowKit hangupCall];
        [self.makeCallOutlet setTitle:@"Make Call" forState:UIControlStateNormal];
    }
}

//First, set up the handle the notification
- (void) connectionStateChanged: (NSNotification*) n
{
    SHKNotification* s ;
    NSString * v ;
    
    s = (SHKNotification*) [n object];
    v = (NSString*)s.Value;
    
    
    if ([v isEqualToString:SHKConnectionStatusCallTerminated]){
        [self.makeCallOutlet setTitle:@"Make Call" forState:UIControlStateNormal];
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
