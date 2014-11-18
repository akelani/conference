/*
 File:      SHKTouches.h

 Framework: ShowKit

 Copyright 2013 Curious Minds Inc. All rights reserved.

 */
/*!
 @file  SHKTouches.h
 @class SHKTouches

 @brief
 The public api for touch and gesture sharing.
 
 */
#import <UIKit/UIKit.h>


/*!
    @brief
    Force ShowKit to update the controls if actionable controls are added after viewDidAppear.
    Will Force ShowKit to update the UIViewController.  In most cases this does not need to be called, however if actionable controls have been added to a view after viewDidAppear this will need to be called.

    NOT CURRENTLY IMPLEMENTED

@class SHKTouches;
@interface UIViewController (SHKTouches)
- (void)shkNeedsUpdate;
@end
  */

/*! 
 @protocol SHKTouchesDelegate
 @brief
 Implement this protocol to receive touch points sent by the remote client if receiving gestures.  It is not necessary to set the SHKTouches delegate.
 
 */
@protocol SHKTouchesDelegate <NSObject>
@required
/*! 
 Called when remote touches begin.
 @param gesture         Pointer to the calling SHKGesture session
 @param point           Point touch began at.
 */
 
- (void)shkTouchesBegan:(CGPoint)point;
/*!
 Called when remote touches move.
 @param gesture         Pointer to the calling SHKGesture session
 @param point           Point touch moved to.
 */

- (void)shkTouchesMoved:(CGPoint)point;
/*!
 Called when remote touches end.
 @param gesture         Pointer to the calling SHKGesture session
 @param point           Point touch ended at.
 */

- (void)shkTouchesEnded:(CGPoint)point;
/*!
 Called when remote touches are canceled.
 @param gesture         Pointer to the calling SHKGesture session
 @param point           Point touch was canceled.
 */

- (void)shkTouchesCancelled:(CGPoint)point;
@end

/*!
 @brief
This method allows you to set your delegate for receiving these events
 */
@interface SHKTouches : NSObject
+ (void)shkSetDelegate:(id)del;
@end


