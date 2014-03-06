//
//  ViewController.h
//  iShowYou
//
//  Created by Yue Chang Hu on 12/14/12.
//  Copyright (c) 2012 Curiousminds. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ShowKit/ShowKit.h>


#define TESTING_DYNAMIC_VIEWS 0
#define TEST_GESTURE_TOUCHES 0
#define TEST_VIDEO_CAPTURE 0

@interface ViewController : UIViewController <UIAlertViewDelegate
#if TESTING_VIDEO_CAPTURE
,SHKVideoCaptureDelegate
#endif
#if TESTING_GESTURE_TOUCHES
,SHKTouchesDelegate
#endif
>
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
#if TESTING_VIDEO_CAPTURE
- (void)StartCapture;
- (void)StopCapture
- (void)Initialize:(int)width height:(int)height fps:(int)fps;
#endif
#if TESTING_GESTURE_TOUCHES
- (void)shkTouchesBegan:(CGPoint)point;
- (void)shkTouchesMoved:(CGPoint)point;
- (void)shkTouchesEnded:(CGPoint)point;
- (void)shkTouchesCancelled:(CGPoint)point;
#endif

@end
