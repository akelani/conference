/*
 File:      SHKStatsStruct.h

 Framework: ShowKit

 Copyright 2014 Curious Minds Inc. All rights reserved.

 */
/*!
 @file  SHKStatsStruct.h
 @class SHKStatsStruct.h

 @brief
 */

#ifndef __HAVE_STATS_STRUCT__
#define __HAVE_STATS_STRUCT__

typedef struct StatsStruct {
    int brVideoRecv;
    int brVideoSend;
    int brAudioRecv;
    int brAudioSend;
    int brDataRecv;
    int brDataSend;
    int brEstRecv;
    int brEstSend;
    int plAudio;
    int plAudioOopl;
    int plVideo;
    int rtLatency;
    
    int cntVideoRecv;
    int cntVideoSend;
    int cntAudioRecv;
    int cntAudioSend;
    int cntDecode;
    
    int brVideoRecvAvg4;
    int brVideoSendAvg4;
    int brAudioRecvAvg4;
    int brAudioSendAvg4;
    int brDataRecvAvg4;
    int brDataSendAvg4;
    int brEstRecvAvg4;
    int brEstOutAvg4;
    int plAudioAvg4;
    int plAudioOoplAvg4;
    int plVideoAvg4;
    int rtLatencyAvg4;
    
    int brVideoRecvAvg;
    int brVideoSendAvg;
    int brAudioRecvAvg;
    int brAudioSendAvg;
    int brDataRecvAvg;
    int brDataSendAvg;
    int brEstRecvAvg;
    int brEstSendAvg;
    int plAudioAvg;
    int plAudioOoplAvg;
    int plVideoAvg;
    int rtLatencyAvg;
} StatsStruct;

#endif
