//
//  DRCameraMinimalInterfaceView.m
//  DRCameraViewSample
//
//  Created by Dal Rupnik on 22/04/14.
//  Copyright (c) 2014 arvystate.net. All rights reserved.
//

#import "DRCameraInterfaceView.h"

const CGFloat DRCameraViewInterfacePhotoCornerLength = 20.0;
const CGFloat DRCameraViewInterfaceFocalPointRadius = 18.0;

@interface DRCameraInterfaceView ()

@property (nonatomic, strong) UIColor* cornerColor;

/*!
 * Focal rings color
 */
@property (nonatomic, strong) UIColor* focalCenterColor;
@property (nonatomic, strong) UIColor* focalOuterRingColor;
@property (nonatomic, strong) UIColor* focalInnerRingColor;

@end

@implementation DRCameraInterfaceView

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

- (void)setInterfaceColor:(UIColor *)interfaceColor
{
    _interfaceColor = interfaceColor;
    
    self.cornerColor = [interfaceColor colorWithAlphaComponent:0.3];
    
    self.focalCenterColor = [interfaceColor colorWithAlphaComponent:0.4];
    self.focalInnerRingColor = [interfaceColor colorWithAlphaComponent:0.2];
    self.focalOuterRingColor = [interfaceColor colorWithAlphaComponent:0.3];
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

- (void)setup
{
    //
    // This is a must, because otherwise it will overlay the camera preview
    //
    self.backgroundColor = [UIColor clearColor];
    
    self.showCenterMask = YES;
    self.showPhotoCorners = YES;
    
    self.interfaceColor = [UIColor whiteColor];
}

- (void)drawRect:(CGRect)rect
{
    //
    // Drawing photo corners
    //
    
    if (self.shouldShowPhotoCorners)
    {
        // Top left corner
        [self drawCornerAtPoint:CGPointMake(20.0, 56.0) rotation:M_PI + M_PI_2 withLength:DRCameraViewInterfacePhotoCornerLength];
        
        // Top right corner
        [self drawCornerAtPoint:CGPointMake(rect.size.width - 20.0, 56.0) rotation:M_PI withLength:DRCameraViewInterfacePhotoCornerLength];
        
        // Bottom left corner
        [self drawCornerAtPoint:CGPointMake(20.0, rect.size.height - 90.0) rotation:0.0 withLength:DRCameraViewInterfacePhotoCornerLength];
        
        // Bottom right corner
        [self drawCornerAtPoint:CGPointMake(rect.size.width - 20.0, rect.size.height - 90.0) rotation:M_PI_2 withLength:DRCameraViewInterfacePhotoCornerLength];
    }
    
    if (self.shouldShowCenterMask)
    {
        [self drawMaskAtPoint:self.center];
    }
}

/*!
 * Draws a corner at specific rotation, provided in radians
 */
- (void)drawCornerAtPoint:(CGPoint)point rotation:(double)rotation withLength:(CGFloat)length
{
    //
    // Corner consists of a single bezier path line.
    //
    
    UIBezierPath* corner = [UIBezierPath bezierPath];
    [corner moveToPoint:CGPointMake(point.x + (cos(rotation) * length), point.y - (sin(rotation) * length))];
    [corner addLineToPoint:point];
    [corner addLineToPoint:CGPointMake(point.x - (sin(rotation) * length), point.y - (cos(rotation) * length))];
    
    corner.lineWidth = 1.0;
    
    [self.cornerColor setStroke];
    
    [corner stroke];
}

- (void)drawMaskAtPoint:(CGPoint)point
{
    CGFloat radius = 18.0;
    
    //
    // Inner half circle
    //
    
    UIBezierPath* bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint:CGPointMake(point.x - radius, point.y)];
    [bezierPath addArcWithCenter:CGPointMake(point.x, point.y) radius:radius startAngle:M_PI endAngle:M_PI * 2 clockwise:NO];
    [bezierPath closePath];
    
    [self.focalCenterColor setFill];
    [bezierPath fill];
    
    //
    // Outer ring has a radius of 30.0 and width of 10.0 pt, so inner radius is 200
    //
    
    CGFloat outerRadius = 30.0;
    CGFloat innerRadius = 20.0;
    
    UIBezierPath* bezier2Path = [UIBezierPath bezierPath];
    bezier2Path.usesEvenOddFillRule = YES;
    
    
    [bezier2Path moveToPoint:CGPointMake(point.x - innerRadius, point.y)];
    [bezier2Path addArcWithCenter:CGPointMake(point.x, point.y) radius:innerRadius startAngle:M_PI endAngle:M_PI * 2 clockwise:YES];
    [bezier2Path addArcWithCenter:CGPointMake(point.x, point.y) radius:innerRadius startAngle:0.0 endAngle:M_PI clockwise:YES];
    [bezier2Path closePath];
    
    [bezier2Path moveToPoint:CGPointMake(point.x - outerRadius, point.y)];
    [bezier2Path addArcWithCenter:CGPointMake(point.x, point.y) radius:outerRadius startAngle:M_PI endAngle:M_PI * 2 clockwise:YES];
    [bezier2Path addArcWithCenter:CGPointMake(point.x, point.y) radius:outerRadius startAngle:0.0 endAngle:M_PI clockwise:YES];
    [bezier2Path closePath];
    
    
    [self.focalInnerRingColor setFill];
    [bezier2Path fill];
    
    //
    // Outer lines
    //
    
    CGFloat lineRadius = 70.0;
    CGFloat lineLength = 22.0;
    
    UIBezierPath* topLine = [UIBezierPath bezierPath];
    
    CGFloat heightModifierForAngle = sin(M_PI_4 / 4) * lineRadius;
    
    [topLine moveToPoint:CGPointMake(point.x - lineRadius - lineLength, point.y - heightModifierForAngle)];
    [topLine addArcWithCenter:CGPointMake(point.x, point.y) radius:lineRadius startAngle:M_PI + (M_PI_4 / 4) endAngle:M_PI * 2 - (M_PI_4 / 4) clockwise:YES];
    [topLine addLineToPoint:CGPointMake(point.x + lineRadius + lineLength, point.y - heightModifierForAngle)];
    
    UIBezierPath* bottomLine = [UIBezierPath bezierPath];
    
    [bottomLine moveToPoint:CGPointMake(point.x - lineRadius - lineLength, point.y + heightModifierForAngle)];
    [bottomLine addArcWithCenter:CGPointMake(point.x, point.y) radius:lineRadius startAngle:M_PI - (M_PI_4 / 4) endAngle:M_PI * 2 + (M_PI_4 / 4) clockwise:NO];
    [bottomLine addLineToPoint:CGPointMake(point.x + lineRadius + lineLength, point.y + heightModifierForAngle)];
    
    [self.focalOuterRingColor setStroke];
    
    [topLine stroke];
    [bottomLine stroke];


}

@end
