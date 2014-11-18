//
//  ShowKitViewController.h
//  HotelTonightDemo
//
//  Created by Anthony Kelani on 7/13/14.
//  Copyright (c) 2014 Anthony Kelani. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ShowKit/ShowKit.h>


@interface SHKSupportViewController : UIViewController <UIAlertViewDelegate>

@property (strong, nonatomic) IBOutlet UIView *menuView;
@property (strong, nonatomic) IBOutlet UIButton *supportMenuButton;
@property (strong, nonatomic) IBOutlet UIButton *callHangupButton;
@property (strong, nonatomic) IBOutlet UIButton *toggleCameraButton;
@property (strong, nonatomic) IBOutlet UIButton *toggleMuteButton;
@property (strong, nonatomic) IBOutlet UIButton *toggleDrawButton;
@property (strong, nonatomic) IBOutlet UIButton *toggleVideoButton;

@property (nonatomic) BOOL videoViewEnabled;

@property (copy, nonatomic) NSString* username;
@property (copy, nonatomic) NSString* password;
@property (copy, nonatomic) NSString* agentToCall;

- (void)login: (NSString*) username password: (NSString*) password;
- (id)initWithController: (UIViewController *)viewController;

@end
