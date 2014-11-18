/*
 File:      SHKEncoder.h

 Framework: ShowKit

 Copyright 2014 ShowKit Inc. All rights reserved.

 */
/*!
 @file  SHKEncoder.h
 @class SHKEncoder

 @brief
 The public api for notifications for video
 
 */
#import <UIKit/UIKit.h>
/*!
 @protocol SHKVideoCaptureDelegate
 @brief
 Notification interface if you want to run your own video capture system
 */

@protocol SHKVideoCaptureDelegate <NSObject>
@required
- (void)     StartCapture;
- (void)     StopCapture;
- (void)     Initialize:(int)width height:(int)height fps:(int)fps;
@end

/*!
    @brief
    Force showkit to encode a frame- will be ignored unless you are running
    your own capture system
 */
@interface SHKEncoder : NSObject
+ (int)shkEncodeFrame:(unsigned char*)pBuf width:(unsigned int)width height:(unsigned int)height length:(unsigned int)len colorspace:(unsigned int)type mediatime:(unsigned int)mt;

+ (void)shkSetDelegate:(id)del;
@end


