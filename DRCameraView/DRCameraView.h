//
//  DRCameraView.h
//
//  Created by Dal Rupnik on 03/04/14.
//  Copyright (c) 2014 arvystate.net. All rights reserved.
//

@import AVFoundation;

@protocol DRCameraViewInterfaceDelegate <NSObject>

@optional

- (void)cameraViewInterfaceDidTapChooseImageButton:(id)cameraViewInterface;

- (void)cameraViewInterfaceDidTapCaptureButton:(id)cameraViewInterface;

@end

@protocol DRCameraViewDelegate <NSObject>

@optional

- (void)cameraViewLoadedWithSuccess:(id)cameraView;

- (void)cameraView:(id)cameraView failedToLoadWithError:(NSError *)error;

- (void)cameraView:(id)cameraView didCaptureImage:(UIImage *)image;

- (void)cameraView:(id)cameraView failedToCaptureImageWithError:(NSError *)error;

- (void)cameraView:(id)cameraView willFocusToPoint:(CGPoint)point;

- (UIView *)cameraView:(id)cameraView viewForFocusAtPoint:(CGPoint)point;

- (void)cameraView:(id)cameraView didFocusToPoint:(CGPoint)point;

//
// Video support will come at a later update.
//

/*
- (void)cameraView:(id)cameraView willBeginRecordingToURL:(NSURL *)file;

- (void)cameraView:(id)cameraView didBeginRecordingToURL:(NSURL *)file;

- (void)cameraView:(id)cameraView willStopRecordingToURL:(NSURL *)file;

- (void)cameraView:(id)cameraView didStopRecordingToURL:(NSURL *)file;
*/

@end

/*!
 * Camera view type
 */
typedef enum : NSUInteger
{
    DRCameraViewTypeVideo,
    DRCameraViewTypePhoto
} DRCameraViewType;

/*!
 * Main camera view class, renders camera input to the layer
 */
@interface DRCameraView : UIView

/*!
 * Wrapper property for interface view. Can also use subviews or subviews of it's superview.
 * This ensures the creator of the UIView knows it will receive delegate methods, same as delegate.
 * If this property is nil, you can still use a entirely custom interface, but you will have to handle
 * all the communication yourself.
 */
@property (nonatomic, strong) UIView<DRCameraViewDelegate>* interface;

@property (nonatomic, weak) id<DRCameraViewDelegate> delegate;

@property (nonatomic, getter = isFlashlightOn) BOOL flashlightOn;

@property (nonatomic, getter = isTorchOn) BOOL torchOn;

@property (nonatomic, getter = isMuted) BOOL muted;

@property (nonatomic) BOOL allowsTapToFocus;

@property (nonatomic) BOOL allowsPinchToZoom;

@property (nonatomic) DRCameraViewType cameraType;

@property (nonatomic) double zoomScale;

/*!
 * Choose front or rear camera
 */
@property (nonatomic) AVCaptureDevicePosition cameraPosition;

- (void)startPreviewStream;

- (void)stopPreviewStream;

- (void)captureImage;

- (void)startRecordingVideoToURL:(NSURL *)url;

- (void)startRecordingVideoToURL:(NSURL *)url sessionPreset:(NSString *)sessionPreset;

- (void)stopRecordingVideo;

@end
