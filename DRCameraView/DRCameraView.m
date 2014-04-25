//
//  DRCameraView.m
//
//  Created by Dal Rupnik on 03/04/14.
//  Copyright (c) 2014 arvystate.net. All rights reserved.
//

@import AVFoundation;

#import <ImageIO/CGImageProperties.h>

#import "DRCameraView.h"

@interface DRCameraView ()

@property (nonatomic, strong) AVCaptureSession* session;
@property (nonatomic, strong) AVCaptureVideoPreviewLayer* captureVideoPreviewLayer;

@property(nonatomic, retain) AVCaptureStillImageOutput *stillImageOutput;

@property (nonatomic, strong) UITapGestureRecognizer* recognizer;

@end

@implementation DRCameraView

- (AVCaptureSession *)session
{
    if (!_session)
    {
        _session = [[AVCaptureSession alloc] init];
        _session.sessionPreset = AVCaptureSessionPresetMedium;
    }
    
    return _session;
}

- (AVCaptureVideoPreviewLayer *)captureVideoPreviewLayer
{
    if (!_captureVideoPreviewLayer)
    {
        _captureVideoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:self.session];
        _captureVideoPreviewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
        _captureVideoPreviewLayer.frame = self.bounds;
    }
    
    return _captureVideoPreviewLayer;
}

- (AVCaptureStillImageOutput *)stillImageOutput
{
    if (!_stillImageOutput)
    {
        _stillImageOutput = [[AVCaptureStillImageOutput alloc] init];
        _stillImageOutput.outputSettings = @{ AVVideoCodecKey : AVVideoCodecJPEG };
    }
    
    return _stillImageOutput;
}

- (void)setTorchOn:(BOOL)torchOn
{
    _torchOn = torchOn;
    
    AVCaptureDevice* device = [[self.session.inputs lastObject] device];
    
    [device lockForConfiguration:nil];
    
    if (torchOn)
    {
        [device setTorchMode:AVCaptureTorchModeOn];
        [device setFlashMode:AVCaptureFlashModeOn];
    }
    else
    {
        [device setTorchMode:AVCaptureTorchModeOff];
        [device setFlashMode:AVCaptureFlashModeOff];
    }
    
    [device unlockForConfiguration];
}

- (void)setInterface:(UIView<DRCameraViewDelegate> *)interface
{
    if (_interface)
    {
        [_interface removeFromSuperview];
    }
    
    _interface = interface;
    
    [self addSubview:_interface];
}

- (id)init
{
    self = [super initWithFrame:[[UIScreen mainScreen] bounds]];
    
    if (self)
    {
        [self setup];
    }
    
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        [self setup];
    }
    
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self setup];
}

- (void)setup
{
    //
    // Add preview, so we lazily init everything.
    //
    [self.layer addSublayer:self.captureVideoPreviewLayer];
    
    //
    // Tap gesture recognizer
    //
    
    self.recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedOnView:)];
    
    [self addGestureRecognizer:self.recognizer];
}

- (void)tappedOnView:(UITapGestureRecognizer *)recognizer
{
    if (!self.session.isRunning)
    {
        return;
    }
    
    CGPoint point = [recognizer locationInView:self];
    
    point = [self.captureVideoPreviewLayer captureDevicePointOfInterestForPoint:point];
    
    //NSLog(@"%@", NSStringFromCGPoint(point));
    
    //
    // Focus
    //
    
    NSError* error;
    
    [[[self.session.inputs lastObject] device] lockForConfiguration:&error];
    
    if (!error)
    {
        [[[self.session.inputs lastObject] device] setFocusPointOfInterest:point];
        [[[self.session.inputs lastObject] device] setExposurePointOfInterest:point];
    }
    else
    {
        NSLog(@"Error focusing: %@", error);
    }
    
    [[[self.session.inputs lastObject] device] unlockForConfiguration];
}

- (void)startPreviewStream
{
    if (![self.session.inputs count])
    {
        AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        
        NSError *error = nil;
        AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error:&error];
        
        if (!input && [self.delegate respondsToSelector:@selector(cameraView:failedToLoadWithError:)])
        {
            [self.delegate cameraView:self failedToLoadWithError:error];
            
            return;
        }
        
        if (!input)
        {
            return;
        }
        
        [self.session addInput:input];
        [self.session addOutput:self.stillImageOutput];
        
        if ([self.delegate respondsToSelector:@selector(cameraViewLoadedWithSuccess:)])
        {
            [self.delegate cameraViewLoadedWithSuccess:self];
        }
        
        // Just set torch mode
        self.torchOn = self.isTorchOn;
    }
    
    [self.session startRunning];
}

- (void)stopPreviewStream
{
    [self.session stopRunning];
}

- (void)captureImage
{
    //
    // To take image, we need delegate to receive it, so we save some CPU cycles,
    // by not doing anything if delegate does not respond.
    //
    
    if (![self.delegate respondsToSelector:@selector(cameraView:didCaptureImage:)])
    {
        return;
    }
    
    //
    // Find video connection in all connections.
    //
    
    AVCaptureConnection *videoConnection = nil;
    
    for (AVCaptureConnection *connection in self.stillImageOutput.connections)
    {
        for (AVCaptureInputPort *port in [connection inputPorts])
        {
            if ([[port mediaType] isEqual:AVMediaTypeVideo] )
            {
                videoConnection = connection;
                break;
            }
        }
        if (videoConnection)
        {
            break;
        }
    }
    
    if ([self.stillImageOutput isCapturingStillImage] && [self.delegate respondsToSelector:@selector(cameraView:failedToCaptureImageWithError:)])
    {
        NSError* error = [NSError errorWithDomain:@"ImageCapture already in progress." code:1 userInfo:nil];
        
        [self.delegate cameraView:self failedToCaptureImageWithError:error];
    }
    
    if ([self.stillImageOutput isCapturingStillImage])
    {
        return;
    }
    
    [self.stillImageOutput captureStillImageAsynchronouslyFromConnection:videoConnection completionHandler: ^(CMSampleBufferRef imageSampleBuffer, NSError *error)
     {
         //CFDictionaryRef exifAttachments = CMGetAttachment(imageSampleBuffer, kCGImagePropertyExifDictionary, NULL);
         
         NSData *imageData = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageSampleBuffer];
         UIImage *image = [[UIImage alloc] initWithData:imageData];
         
         [self.delegate cameraView:self didCaptureImage:image];
     }];
}

@end
