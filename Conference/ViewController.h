//
//  ViewController.h
//  iShowYou
//
//  Created by Yue Chang Hu on 12/14/12.
//  Copyright (c) 2012 Curiousminds. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ShowKit/ShowKit.h>


@interface ViewController : UIViewController <UIAlertViewDelegate,SHKTouchesDelegate, SHKVideoCaptureDelegate>
{
    int m_width;
    int m_height;
    int m_count;
}
@property (readwrite, nonatomic) IBOutlet UIView *mainVideoUIView;
@property (readwrite, nonatomic) IBOutlet UIView *prevVideoUIView;
@property (assign) NSTimer * encodeTimer;
- (IBAction)toggleUser:(id)sender;
- (IBAction)runTest:(id)sender;
- (IBAction)share:(id)sender;
- (IBAction)login:(id)sender;
- (IBAction)makeCall:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *shareOutlet;
@property (strong, nonatomic) IBOutlet UIButton *runTestOutlet;
@property (strong, nonatomic) IBOutlet UIButton *toggleUserOutlet;
@property (strong, nonatomic) IBOutlet UIButton *loginOutlet;
@property (strong, nonatomic) IBOutlet UIButton *makeCallOutlet;
- (void)shkTouchesBegan:(CGPoint)point;
- (void)shkTouchesMoved:(CGPoint)point;
- (void)shkTouchesEnded:(CGPoint)point;
- (void)shkTouchesCancelled:(CGPoint)point;

@end
