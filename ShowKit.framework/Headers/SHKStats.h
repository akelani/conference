/*
 File:      SHKStats.h

 Framework: ShowKit

 Copyright 2014 Curious Minds Inc. All rights reserved.

 */
/*!
 @file  SHKStats.h
 @class SHKStats

 @brief
a public API for receving stats
 */
#include "SHKStatsStruct.h"

/*! 
 @protocol SHKStatsDelegate
 @brief
 Implement this protocol to receive statistics info
 
 */
@protocol SHKStatsDelegate <NSObject>
@required
/*! 
 Called when remote touches begin.
 @param gesture         Pointer to the calling SHKGesture session
 @param point           Point touch began at.
 */
 
- (void)shkStatsNotification:(StatsStruct*)stats;
/*!
 Called when remote touches move.
 @param gesture         Pointer to the calling SHKGesture session
 @param point           Point touch moved to.
 */
@end

/*!
 @brief
This method allows you to set your delegate for receiving these events
 */
@interface SHKStats : NSObject
+ (void)shkSetDelegate:(id)del;
@end


