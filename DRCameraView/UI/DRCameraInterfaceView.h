//
//  DRCameraInterfaceView.h
//  DRCameraViewSample
//
//  Created by Dal Rupnik on 22/04/14.
//  Copyright (c) 2014 arvystate.net. All rights reserved.
//

#import "DRCameraView.h"

@interface DRCameraInterfaceView : UIView <DRCameraViewDelegate>

@property (nonatomic, getter = shouldShowPhotoCorners) BOOL showPhotoCorners;
@property (nonatomic, getter = shouldShowCenterMask) BOOL showCenterMask;

/*!
 * Shows current camera settings below image (only in horizontal mode)
 */
@property (nonatomic, getter = shouldShowSettingsLabel) BOOL showSettingsLabel;

/*!
 * Allows some theming of the interface, very basic
 */
@property (nonatomic, strong) UIColor* interfaceColor;

@end
