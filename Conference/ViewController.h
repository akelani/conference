//
//  ViewController.h
//  iShowYou
//
//  Created by Yue Chang Hu on 12/14/12.
//  Copyright (c) 2012 Curiousminds. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ShowKit/ShowKit.h>


@interface ViewController : UIViewController <UIAlertViewDelegate>
@property (readwrite, nonatomic) IBOutlet UIView *mainVideoUIView;
@property (readwrite, nonatomic) IBOutlet UIView *prevVideoUIView;

- (IBAction)toggleUser:(id)sender;
- (IBAction)login:(id)sender;
- (IBAction)makeCall:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *toggleUserOutlet;
@property (strong, nonatomic) IBOutlet UIButton *loginOutlet;
@property (strong, nonatomic) IBOutlet UIButton *makeCallOutlet;

@end
