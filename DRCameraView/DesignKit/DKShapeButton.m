//
// Created by Dal Rupnik on 02/05/14.
// Copyright (c) 2014 arvystate.net. All rights reserved.
//

#import "DKShapeButton.h"

@interface DKShapeButton ()

@property (nonatomic, strong) NSMutableDictionary* stateBlocks;

@end

@implementation DKShapeButton

- (NSMutableDictionary *)stateBlocks
{
    if (!_stateBlocks)
    {
        _stateBlocks = [NSMutableDictionary dictionary];
    }

    return _stateBlocks;
}


- (void)drawRect:(CGRect)rect
{
    //
    // Call correct drawing block for current state
    //

    NSString* controlState = [NSString stringWithFormat:@"%d", self.state];

    //NSLog(controlState);

    if (self.stateBlocks[controlState])
    {
        DKDrawingBlock drawingBlock = self.stateBlocks[controlState];

        drawingBlock(rect);

        return;
    }

    //
    // Draw default state block, if we have it
    //

    controlState = [NSString stringWithFormat:@"%d", UIControlStateNormal];

    if (self.stateBlocks[controlState])
    {
        DKDrawingBlock drawingBlock = self.stateBlocks[controlState];

        drawingBlock(rect);
    }
}

- (void)setDrawingBlock:(DKDrawingBlock)block forState:(UIControlState)state
{
    NSString* controlState = [NSString stringWithFormat:@"%d", state];

    self.stateBlocks[controlState] = block;

    //
    // Redraw the button with new drawing block
    //
    [self setNeedsDisplay];
}

- (DKDrawingBlock)drawingBlockForState:(UIControlState)state
{
    NSString* controlState = [NSString stringWithFormat:@"%d", state];

    if (self.stateBlocks[controlState])
    {
        return self.stateBlocks[controlState];
    }

    return nil;
}

- (void)setHighlighted:(BOOL)highlighted
{
    [super setHighlighted:highlighted];

    [self setNeedsDisplay];
}

@end