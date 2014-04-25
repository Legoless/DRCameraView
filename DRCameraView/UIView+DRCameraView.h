//
//  UIView+DRCameraView.h
//  DRCameraViewSample
//
//  Created by Dal Rupnik on 22/04/14.
//  Copyright (c) 2014 arvystate.net. All rights reserved.
//

#import "DRCameraView.h"

@interface UIView (DRCameraView)

/*!
 * Returns parent camera view, useful in camera view interfaces, to get rid of a controller handling
 * the communication between view and camera view.
 */
- (DRCameraView *)parentCameraView;

@end
