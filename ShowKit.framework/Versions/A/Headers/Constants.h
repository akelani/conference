
/*
    File:       Constants.h
 
    Framework:  ShowKit
 
    Copyright 2013 Curious Minds Inc. All rights reserved.
 
*/

/*!

 @file Constants.h
 @brief NSDictionary keys and values for setting ShowKit state.
 
 The top values for each key are set by default.  Some keys, such as ConnectionStatusKey and the RemoteClient keys, are read only.
    
 Notifications are posted to the `NSNotificationCenter`.

 
 Usage:
 
     [ShowKit setState: SHKTorchModeOn forKey: SHKTorchModeKey];
 
     NSNumber * inBitrate = [ShowKit getStateForKey: SHKConnectionStatusCurrentDataRateInKey];
 
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(shkConnectionStatusChanged:) name:SHKConnectionStatusChangedNotification object:nil];
*/

#import <Foundation/Foundation.h>

/*! @cond */
#ifdef __cplusplus
#   define SHK_EXTERN extern "C"
#else
#   define SHK_EXTERN extern
#endif
/*! @endcond */

/*!
 @var SHKMainDisplayViewKey

 @brief This key sets the view that will display the remote user's video stream.  
 Takes a `UIView` as a value. Default is `nil`.

 @param UIView

 */
SHK_EXTERN NSString * const     SHKMainDisplayViewKey;
SHK_EXTERN NSString * const     SHKMainDisplayViewKeyInternal;
/*!
 @var SHKPreviewDisplayViewKey
 
 @brief This key sets the view that will display the local user's camera preview.  
 Takes a `UIView` as a value. Default is `nil`.

 @param UIView

 */
SHK_EXTERN NSString * const     SHKPreviewDisplayViewKey;
SHK_EXTERN NSString * const     SHKPreviewDisplayViewKeyInternal;

/*!
 @var SHKLogfileKey
 
 @param NSString
 
 @brief Set a logfile for ShowKit to output errors and debug information.  
 
 Default is `nil`.  To stop logging, set `SHKLogfileKey` to `nil`.
 */

SHK_EXTERN NSString * const     SHKLogfileKey;


/*!

 @var SHKUserMessageReceivedNotification
 
 
 @brief This notification is fired when a message is received from the remote user via `+(BOOL) [ShowKit sendMessage:]`
 */

SHK_EXTERN NSString * const     SHKUserDataReceivedNotification; /*! @cond */
SHK_EXTERN NSString * const     SHKUserMessageReceivedNotification; /*! @cond */
SHK_EXTERN NSString * const         SHKUserMessageKey; /*! @endcond */

// All keys below this will only take NSString* const


/*!
 
 @var SHKConnectionStatusChangedNotification
 
 @brief This notification is fired when the connection state changes.  You may access the new status via `SHKConnectionStatusKey`.
 */
SHK_EXTERN NSString * const     SHKConnectionStatusChangedNotification;

/*!
 
 @var SHKConnectionStatusKey [Read-Only]

 @brief  This will return the current connection status.  
 All statuses stand on their own with the exception of `SHKConnectionStatusCallIncoming`, which will include the calling user in UserObject, and `SHKConectionStatusCallFailed`, which will return
 an NSError in the UserObject parameter with the following status codes:

        500: User Does Not Exist           :: User is attempting to call a user who does not exist on the ShowKit system.
        501: User Unavailable              :: User is attempting to call a user who is not online
        502: Calling Service Unreachable   :: User is on a network that is preventing ShowKit from making a call, though they may still receive calls.
        599: Unknown Error                 :: An unknown error has occurred, please contact ShowKit support with a logfile and steps to reproduce.
 
 @return Current connection status

 */

SHK_EXTERN NSString * const     SHKConnectionStatusKey;/*! @cond */
SHK_EXTERN NSString * const         SHKConnectionStatusNotConnected;
SHK_EXTERN NSString * const         SHKConnectionStatusConnectionChanged;
SHK_EXTERN NSString * const         SHKConnectionStatusConnectionLost;
SHK_EXTERN NSString * const         SHKConnectionStatusLoggedIn;
SHK_EXTERN NSString * const         SHKConnectionStatusLoginFailed;
SHK_EXTERN NSString * const         SHKConnectionStatusCallIncoming;
SHK_EXTERN NSString * const         SHKConnectionStatusCallOutgoing;
SHK_EXTERN NSString * const         SHKConnectionStatusCallFailed;
SHK_EXTERN NSString * const         SHKConnectionStatusInCall;
SHK_EXTERN NSString * const         SHKConnectionStatusCallTerminating;
SHK_EXTERN NSString * const         SHKConnectionStatusCallTerminated;/*! @endcond */



/*!
 
 @var SHKConnectionStatusCurrentDataRateOutKey [Read-Only]
 @brief The current measured output data rate
 @return NSNumber   Current sending data rate.
*/
SHK_EXTERN NSString * const     SHKConnectionStatusCurrentDataRateOutKey;
/*!

 @var SHKConnectionStatusCurrentDataRateInKey [Read-Only]
 @brief The current measured input data rate
 @return NSNumber  Current receiving data rate.
 */
SHK_EXTERN NSString * const     SHKConnectionStatusCurrentDataRateInKey;

/*!

 @var SHKEncryptionModeKey

 @brief This setting will enable or disable encryption on the video, audio, and data streams between clients.

 @param NSString* const         `SHKEncryptionModeDisabled, SHKEncryptionModeOptional, SHKEncryptionModeMandatory`

 */
SHK_EXTERN NSString* const      SHKEncryptionModeKey; /*! @cond */
SHK_EXTERN NSString* const          SHKEncryptionModeDisabled;
SHK_EXTERN NSString* const          SHKEncryptionModeOptional;
SHK_EXTERN NSString* const          SHKEncryptionModeMandatory;
SHK_EXTERN NSString* const          SHKEncryptionModeEnabled;       // Deprecated  SHKEncryptionModeEnabled = SHKEncryptionModeMandatory

/*! @endcond */

/*!

 @var SHKAudioInputModeKey

 @brief Set the audio input mode to recording or muted.

 @param NSString* const         `SHKAudioInputModeRecording, SHKAudioInputModeMuted`

 */
 
SHK_EXTERN NSString * const     SHKAudioInputModeKey;/*! @cond */
SHK_EXTERN NSString * const         SHKAudioInputModeRecording;
SHK_EXTERN NSString * const         SHKAudioInputModeMuted;/*! @endcond */


/*!
 
 @var SHKAudioInputDeviceKey
 
 @brief Set the audio device.  If the device is set to `SHKAudioDeviceBuiltIn`, external microphones and headphones will not be used.
 
 @param NSString * const        `SHKAudioDeviceAuto, SHKAudioDeviceBuiltIn`
 */
SHK_EXTERN NSString * const     SHKAudioDeviceKey                  ;/*! @cond */
SHK_EXTERN NSString * const         SHKAudioDeviceAuto             ;
SHK_EXTERN NSString * const         SHKAudioDeviceBuiltIn          ;/*! @endcond */

/*!
 
 @var SHKSetActivityOnBackgroundKey
 
 @brief Set what should happen when the app goes into or returns from the background, and no call is active
 
 @param NSString * const        `SHKShutdownRestartShowkit, SHKAudioDeviceBuiltIn`
 */
SHK_EXTERN NSString * const     SHKSetActivityOnBackgroundKey                  ;/*! @cond */
SHK_EXTERN NSString * const         SHKBGShutdownRestartShowkit             ;
SHK_EXTERN NSString * const         SHKBGAcceptCallOnUnsuspend          ;  // default behavior
SHK_EXTERN NSString * const         SHKBGActivityDefault          ;/*! @endcond */

// get backgrounded state
SHK_EXTERN NSString * const     SHKAppBackgroundedKey                  ;
SHK_EXTERN NSString * const         SHKInBackground             ;
SHK_EXTERN NSString * const         SHKInForeground          ;/*! @endcond */

/*!
 
 @var SHKVideoInputDeviceKey
 
 @brief Set the current video input device.

 @param NSString* const         `SHKVideoInputDeviceFrontCamera, SHKVideoInputDeviceBackCamera, SHKVideoInputDeviceScreen, SHKVideoInputDeviceNone`

 */

SHK_EXTERN NSString * const     SHKVideoInputDeviceKey; /*! @cond */
SHK_EXTERN NSString * const         SHKVideoInputDeviceFrontCamera;
SHK_EXTERN NSString * const         SHKVideoInputDeviceBackCamera;
SHK_EXTERN NSString * const         SHKVideoInputDeviceScreen;
SHK_EXTERN NSString * const         SHKVideoInputDeviceNone; /*! @endcond */

/*!
 
 @var SHKVideoScaleModeKey
 
 @brief Set how the remote video is presented in the view.
 
 Set the video scale on the `SHKMainDisplayView` in the following ways:
 - Crop :: Crop the image, maintaining aspect and filling view.
 - Fit  :: Fit the image within the view, maintaining aspect and leaving black bars in excess space.
 - Fill :: Fill the view, disregarding aspect ratio.

 @param NSString* const         `SHKVideoScaleModeCrop, SHKVideoScaleModeFit, SHKVideoScaleModeFill`

 */

SHK_EXTERN NSString * const     SHKVideoScaleModeKeyInternal; /*! @cond */
SHK_EXTERN NSString * const     SHKVideoScaleModeKey; /*! @cond */
SHK_EXTERN NSString * const         SHKVideoScaleModeCrop;  
SHK_EXTERN NSString * const         SHKVideoScaleModeFit;    
SHK_EXTERN NSString * const         SHKVideoScaleModeFill;  /*! @endcond */


/*!
 
 @var SHKVideoInputDeviceResolutionKey
 
 @brief Set the preferred video resolution.
 
 720P video is currently only available on the following devices:
 - iPhone 5 and higher,
 - iPod Touch 5th generation and higher,
 - iPad 4th generation and higher, and iPad Mini 1st generation and higher.

 Other devices will default to Standard (VGA) with the exception of single-core devices whcih will use Low (QVGA).

 Video resolution will scale up and down from Low to the highest set value depending on network conditions

 This value must be set before a call is made or received.

 @param NSString* const         `SHKVideoInputDeviceResolutionStandard, SHKVideoInputDeviceResolution720p, SHKVideoInputDeviceResolutionLow`
 
 */

SHK_EXTERN NSString * const     SHKVideoInputDeviceResolutionKey; /*! @cond */
SHK_EXTERN NSString * const         SHKVideoInputDeviceResolutionStandard;
SHK_EXTERN NSString * const         SHKVideoInputDeviceResolution720p;
SHK_EXTERN NSString * const         SHKVideoInputDeviceResolutionLow; /*! @endcond */

/*!
 
 @var SHKVideoInputDeviceFPSKey

 @brief Set the preferred video frame rate.
 
 Single-core devices are locked at 15FPS. All others can do 30FPS.

 This value must be set before a call is made or received.
 
 @param NSString* const         `SHKVideoInputDeviceFPS30, SHKVideoInputDeviceFPS15`
 
 */

SHK_EXTERN NSString * const     SHKVideoInputDeviceFPSKey; /*! @cond */
SHK_EXTERN NSString * const         SHKVideoInputDeviceFPS30;
SHK_EXTERN NSString * const         SHKVideoInputDeviceFPS15; /*! @endcond */


/*!
 
 @var SHKCoNavigationModeKey
 
 @brief Enable or disable Co-Navigation
 
 @param NSString* const         `SHKCoNavigationOff, SHKCoNavigationOn`
 
 */

SHK_EXTERN NSString * const     SHKCoNavigationModeKey; /*! @cond */
SHK_EXTERN NSString * const         SHKCoNavigationOn;
SHK_EXTERN NSString * const         SHKCoNavigationOff; /*! @endcond */


/*!
 
 @var SHKVideoDecodeDeviceKey
 
 @brief Set the preferred video decoder.
 
 Using Software will provide more immediate playback at the expense of CPU resources.  The software decoder does not require buffering the same
 way the iOS hardware decoder does.
 
 @param NSString* const         `SHKVideoDecodeDeviceHardware, SHKVideoDecodeDeviceSoftware`

 */
SHK_EXTERN NSString * const     SHKVideoDecodeDeviceKey; /*! @cond */
SHK_EXTERN NSString * const         SHKVideoDecodeDeviceAuto;
SHK_EXTERN NSString * const         SHKVideoDecodeDeviceHardware;
SHK_EXTERN NSString * const         SHKVideoDecodeDeviceSoftware;
/*! @endcond */
/*!

 @var SHKVideoInputDeviceScreenModeKey
 
 @brief Set the video input device.

 If you are sharing OpenGLES content and do not wish to share UIKit content, SHKVideoInputDeviceScreenModeGLESAccelerated will
 provide GLES sharing at lower CPU and GPU cost.

 @param NSString* const         `SHKVideoInputDeviceScreenModeNormal, SHKVideoInputDeviceScreenModeGLESAccelerated`
 
 */

SHK_EXTERN NSString * const     SHKVideoInputDeviceScreenModeKey; /*! @cond */
SHK_EXTERN NSString * const         SHKVideoInputDeviceScreenModeNormal;            // Capture UIKit and GLES.
SHK_EXTERN NSString * const         SHKVideoInputDeviceScreenModeGLESAccelerated;   // Do not attempt to capture UIKit data.
/*! @endcond */

/*!
 
 @var SHKVideoLocalPreviewModeKey
 
 @brief Enable or disable showing a preview of the local user's camera in the Main Display view when not in a call.

 @param NSString* const         `SHKVideoLocalPreviewEnabled, SHKVideoLocalPreviewDisabled`
 
 */

SHK_EXTERN NSString * const     SHKVideoLocalPreviewModeKey; /*! @cond */
SHK_EXTERN NSString * const         SHKVideoLocalPreviewEnabled;
SHK_EXTERN NSString * const         SHKVideoLocalPreviewDisabled; /*! @endcond */

/*!
 
 @var SHKGestureCaptureModeKey
 
 @brief Set the gesture sharing to either broadcast touches the local user is making, receive touches broadcast by the remote user, or disable.
 
 @param NSString * const        `SHKGestureCaptureModeOff, SHKGestureCaptureModeBroadcast, SHKGestureCaptureModeReceive`
 
 */

SHK_EXTERN NSString * const     SHKGestureCaptureModeKey; /*! @cond */
SHK_EXTERN NSString * const         SHKGestureCaptureModeOff;
SHK_EXTERN NSString * const         SHKGestureCaptureModeBroadcast;
SHK_EXTERN NSString * const         SHKGestureCaptureModeReceive; /*! @endcond */

/*!
 
 @var SHKGestureCaptureNeedsUpdateKey

 @brief Force the gesture capture session to update its mapping of active UIKit controls.

 @param NSString * const            `SHKGestureCaptureNeedsUpdateTrue, SHKGestureCaptureNeedsUpdateFalse`
 

 */

SHK_EXTERN NSString * const     SHKGestureCaptureNeedsUpdateKey; /*! @cond */
SHK_EXTERN NSString * const         SHKGestureCaptureNeedsUpdateTrue;
SHK_EXTERN NSString * const         SHKGestureCaptureNeedsUpdateFalse; /*! @endcond */


/*!
 
 @var SHKGestureCaptureLocalIndicatorsModeKey

 @brief Enable or disable displaying local and remote touches on screen.
 
 @param NSString* const             `SHKGestureCaptureLocalIndicatorsOff, SHKGestureCaptureLocalIndicatorsOn`

 
 */

SHK_EXTERN NSString * const     SHKGestureCaptureLocalIndicatorsModeKey; /*! @cond */
SHK_EXTERN NSString * const         SHKGestureCaptureLocalIndicatorsOff;
SHK_EXTERN NSString * const         SHKGestureCaptureLocalIndicatorsOn; /*! @endcond */


/*!
 
 @var Drawing mode controls
 
 @brief Enable or disable displaying local and remote touches on screen.
 
 */

SHK_EXTERN NSString * const    SHKDrawMode ;
SHK_EXTERN NSString * const         SHKDrawModeOn ;
SHK_EXTERN NSString * const         SHKDrawModeOff ;


SHK_EXTERN NSString * const    SHKDrawColor ;
SHK_EXTERN NSString * const         SHKDrawColorRed ;
SHK_EXTERN NSString * const         SHKDrawColorPurple ;
SHK_EXTERN NSString * const         SHKDrawColorBlack ;
SHK_EXTERN NSString * const         SHKDrawColorGreen ;
SHK_EXTERN NSString * const         SHKDrawColorBlue ;
SHK_EXTERN NSString * const         SHKDrawColorGold ;
SHK_EXTERN NSString * const         SHKDrawColorDefault ;
SHK_EXTERN NSString * const         SHKDrawColorRotate ;


/*!
 
 @var SHKVideoOrientationLocalKey/SHKVideoOrientationRemoteKey
 
 @brief Enable or disable displaying local and remote touches on screen.

 */
/*
// set
SHK_EXTERN NSString * const     SHKVideoOrientationLocalDefaultKey;
SHK_EXTERN NSString * const        SHKVideoOrientationLocalAuto;
SHK_EXTERN NSString * const        SHKVideoOrientationLocalPortrait;
SHK_EXTERN NSString * const        SHKVideoOrientationLocalPortraitUpsideDown;
SHK_EXTERN NSString * const         SHKVideoOrientationLocalLandscapeLeft;
SHK_EXTERN NSString * const         SHKVideoOrientationLocalLandscapeRight;

// set
SHK_EXTERN NSString * const    SHKVideoOrientationRemoteDefaultKey ;
SHK_EXTERN NSString * const         SHKVideoOrientationRemoteAuto ;
SHK_EXTERN NSString * const         SHKVideoOrientationRemotePortrait ;
SHK_EXTERN NSString * const        SHKVideoOrientationRemotePortraitUpsideDown;
SHK_EXTERN NSString * const         SHKVideoOrientationRemoteLandscapeLeft;
SHK_EXTERN NSString * const       SHKVideoOrientationRemoteLandscapeRight;
*/



/*!
 
 @var SHKTorchModeKey


 @brief Enable or disable the torch associated with a particular camera.  
 If the camera does not have a torch, it will be set to `SHKTorchModeUnsupported` if
 attempting to enable the torch.  `SHKTorchModeAuto` will automatically enable or disable torch depending on lighting conditions.

 @param NSString* const         `SHKTorchModeOff, SHKTorchModeOn, SHKTorchModeAuto, SHKTorchModeUnsupported`
 
 */

SHK_EXTERN NSString * const     SHKTorchModeKey; /*! @cond */
SHK_EXTERN NSString * const         SHKTorchModeOff;
SHK_EXTERN NSString * const         SHKTorchModeOn;
SHK_EXTERN NSString * const         SHKTorchModeAuto;
SHK_EXTERN NSString * const         SHKTorchModeUnsupported; /*! @endcond */


/*!
 
 @var SHKRemoteClientStateChangedNotification

 @brief Remote client has changed ShowKit state.
 
 These are remote client state updates.  The Key value will appear in the SHKNotification.Key field, and the state will be in the SHKNotification.Value field.
 You will receive initial state at the beginning of a call and any time the remote user changes state, you will be notified.  The following keys may be sent with the notification:
 
 - SHKRemoteClientVideoStateKey
    - SHKRemoteClientVideoStateStarted
    - SHKRemoteClientVideoStateStopped
 - SHKRemoteClientAudioStateKey
    - SHKRemoteClientAudioStateStarted
    - SHKRemoteClientAudioStateStopped
 - SHKRemoteClientGestureStateKey
    - SHKRemoteClientGestureStateStarted
    - SHKRemoteClientGestureStateStopped
 - SHKRemoteClientVideoInputKey
    - SHKRemoteClientVideoInputFront
    - SHKRemoteClientVideoInputBack
    - SHKRemoteClientVideoInputScreen
 - SHKRemoteClientDeviceOrientationKey
    - SHKRemoteClientDeviceOrientationPortrait
    - SHKRemoteClientDeviceOrientationPortraitUpsideDown
    - SHKRemoteClientDeviceOrientationLandscapeLeft
    - SHKRemoteClientDeviceOrientationLandscapeRight
 
 Additionally you may query each of the Keys with `[ShowKit getStateForKey:]`
*/
// read-only
SHK_EXTERN NSString * const     SHKRemoteClientStateChangedNotification;
/*! @cond */
// read-only
SHK_EXTERN NSString * const     SHKRemoteClientVideoStateKey;
SHK_EXTERN NSString * const         SHKRemoteClientVideoStateStopped;
SHK_EXTERN NSString * const         SHKRemoteClientVideoStateStarted;

// read-only
SHK_EXTERN NSString * const     SHKRemoteClientAudioStateKey;
SHK_EXTERN NSString * const         SHKRemoteClientAudioStateStopped;
SHK_EXTERN NSString * const         SHKRemoteClientAudioStateStarted;
// read-only
SHK_EXTERN NSString * const     SHKRemoteClientGestureStateKey;
SHK_EXTERN NSString * const         SHKRemoteClientGestureStateStopped;
SHK_EXTERN NSString * const         SHKRemoteClientGestureStateStarted;
// read-only
SHK_EXTERN NSString * const     SHKRemoteClientVideoInputKey;
SHK_EXTERN NSString * const         SHKRemoteClientVideoInputFront;
SHK_EXTERN NSString * const         SHKRemoteClientVideoInputBack;
SHK_EXTERN NSString * const         SHKRemoteClientVideoInputScreen;

// read-only
SHK_EXTERN NSString * const     SHKRemoteClientDeviceOrientationKey;
SHK_EXTERN NSString * const         SHKRemoteClientDeviceOrientationPortrait;
SHK_EXTERN NSString * const         SHKRemoteClientDeviceOrientationPortraitUpsideDown;
SHK_EXTERN NSString * const         SHKRemoteClientDeviceOrientationLandscapeLeft;
SHK_EXTERN NSString * const         SHKRemoteClientDeviceOrientationLandscapeRight;

/*!
 @var SHKConnectionMaxDataRateOutKey
 @return NSNumber   MAX RATE
 */
SHK_EXTERN NSString * const     SHKConnectionMaxVideoRateOutKey;
SHK_EXTERN NSString * const     SHKConnectionMaxVideoRateInKey;

/*! @endcond */

#undef SHK_EXTERN