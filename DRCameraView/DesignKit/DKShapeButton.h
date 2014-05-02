//
// Created by Dal Rupnik on 02/05/14.
// Copyright (c) 2014 arvystate.net. All rights reserved.
//

#import "DKButton.h"

/*!
 * A drawing block should be provided to the button to draw specific state.
 * All drawing is done on UIKit's graphic context.
 */
typedef void (^DKDrawingBlock)(CGRect rect);

/*!
 * Shape button removes the need for UIImage's, which have a large memory footprint.
 * It takes a block of Core Graphics drawing code for each button state.
 */
@interface DKShapeButton : DKButton

- (void)setDrawingBlock:(DKDrawingBlock)block forState:(UIControlState)state;
- (DKDrawingBlock)drawingBlockForState:(UIControlState)state;

@end