//
//  DRCameraMinimalInterfaceView.m
//  DRCameraViewSample
//
//  Created by Dal Rupnik on 22/04/14.
//  Copyright (c) 2014 arvystate.net. All rights reserved.
//

#import "DRCameraInterfaceView.h"
#import "DKShapeButton.h"


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


@property (nonatomic, strong) DKShapeButton* captureButton;

/*!
 *
 */
@property (nonatomic, strong) DKShapeButton* flashButton;

@property (nonatomic, strong) DKShapeButton* modeButton;

@property (nonatomic, strong) DKShapeButton* cameraTypeButton;

@property (nonatomic, strong) DKShapeButton* cameraRollButton;


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

    //
    // Add the capture button
    //

    self.captureButton = [[DKShapeButton alloc] initWithFrame:CGRectMake(125.0, self.bounds.size.height - 80.0, 70.0, 70.0)];
    self.captureButton.layer.cornerRadius = 35.0;
    self.captureButton.layer.borderWidth = 1;
    self.captureButton.layer.borderColor = [[UIColor colorWithWhite:1.0 alpha:0.1] CGColor];

    self.captureButton.clipsToBounds = YES;
    self.captureButton.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.3];

    [self.captureButton setDrawingBlock:^(CGRect rect)
    {
        UIColor* cameraFullColor = [UIColor whiteColor];

        UIBezierPath* cameraFullPath = [UIBezierPath bezierPath];
        [cameraFullPath moveToPoint: CGPointMake(48.94, 24.79)];
        [cameraFullPath addLineToPoint: CGPointMake(43.65, 24.79)];
        [cameraFullPath addLineToPoint: CGPointMake(40.57, 21.75)];
        [cameraFullPath addCurveToPoint: CGPointMake(40.56, 21.74) controlPoint1: CGPointMake(40.57, 21.74) controlPoint2: CGPointMake(40.56, 21.74)];
        [cameraFullPath addLineToPoint: CGPointMake(40.55, 21.73)];
        [cameraFullPath addLineToPoint: CGPointMake(40.55, 21.73)];
        [cameraFullPath addCurveToPoint: CGPointMake(38.75, 21) controlPoint1: CGPointMake(40.09, 21.28) controlPoint2: CGPointMake(39.46, 21)];
        [cameraFullPath addLineToPoint: CGPointMake(32.35, 21)];
        [cameraFullPath addCurveToPoint: CGPointMake(30.48, 21.82) controlPoint1: CGPointMake(31.61, 21) controlPoint2: CGPointMake(30.95, 21.32)];
        [cameraFullPath addLineToPoint: CGPointMake(30.48, 21.81)];
        [cameraFullPath addLineToPoint: CGPointMake(27.46, 24.79)];
        [cameraFullPath addLineToPoint: CGPointMake(22.06, 24.79)];
        [cameraFullPath addCurveToPoint: CGPointMake(19.5, 27.32) controlPoint1: CGPointMake(20.65, 24.79) controlPoint2: CGPointMake(19.5, 25.92)];
        [cameraFullPath addLineToPoint: CGPointMake(19.5, 42.47)];
        [cameraFullPath addCurveToPoint: CGPointMake(22.06, 45) controlPoint1: CGPointMake(19.5, 43.87) controlPoint2: CGPointMake(20.65, 45)];
        [cameraFullPath addLineToPoint: CGPointMake(48.94, 45)];
        [cameraFullPath addCurveToPoint: CGPointMake(51.5, 42.47) controlPoint1: CGPointMake(50.35, 45) controlPoint2: CGPointMake(51.5, 43.87)];
        [cameraFullPath addLineToPoint: CGPointMake(51.5, 27.32)];
        [cameraFullPath addCurveToPoint: CGPointMake(48.94, 24.79) controlPoint1: CGPointMake(51.5, 25.92) controlPoint2: CGPointMake(50.35, 24.79)];
        [cameraFullPath closePath];
        [cameraFullPath moveToPoint: CGPointMake(35.5, 41.21)];
        [cameraFullPath addCurveToPoint: CGPointMake(28.46, 34.26) controlPoint1: CGPointMake(31.62, 41.21) controlPoint2: CGPointMake(28.46, 38.09)];
        [cameraFullPath addCurveToPoint: CGPointMake(35.5, 27.32) controlPoint1: CGPointMake(28.46, 30.43) controlPoint2: CGPointMake(31.62, 27.32)];
        [cameraFullPath addCurveToPoint: CGPointMake(42.54, 34.26) controlPoint1: CGPointMake(39.38, 27.32) controlPoint2: CGPointMake(42.54, 30.43)];
        [cameraFullPath addCurveToPoint: CGPointMake(35.5, 41.21) controlPoint1: CGPointMake(42.54, 38.09) controlPoint2: CGPointMake(39.38, 41.21)];
        [cameraFullPath closePath];
        [cameraFullPath moveToPoint: CGPointMake(35.5, 28.58)];
        [cameraFullPath addCurveToPoint: CGPointMake(29.74, 34.26) controlPoint1: CGPointMake(32.32, 28.58) controlPoint2: CGPointMake(29.74, 31.12)];
        [cameraFullPath addCurveToPoint: CGPointMake(35.5, 39.95) controlPoint1: CGPointMake(29.74, 37.4) controlPoint2: CGPointMake(32.32, 39.95)];
        [cameraFullPath addCurveToPoint: CGPointMake(41.26, 34.26) controlPoint1: CGPointMake(38.68, 39.95) controlPoint2: CGPointMake(41.26, 37.4)];
        [cameraFullPath addCurveToPoint: CGPointMake(35.5, 28.58) controlPoint1: CGPointMake(41.26, 31.12) controlPoint2: CGPointMake(38.68, 28.58)];
        [cameraFullPath closePath];
        [cameraFullColor setFill];
        [cameraFullPath fill];
    }
    forState:UIControlStateNormal];

    [self.captureButton setDrawingBlock:^(CGRect rect)
    {
        UIBezierPath* bezierPath = [UIBezierPath bezierPath];
        [bezierPath moveToPoint: CGPointMake(38.75, 21)];
        [bezierPath addLineToPoint: CGPointMake(32.35, 21)];
        [bezierPath addCurveToPoint: CGPointMake(30.48, 21.82) controlPoint1: CGPointMake(31.61, 21) controlPoint2: CGPointMake(30.95, 21.32)];
        [bezierPath addLineToPoint: CGPointMake(27.46, 24.79)];
        [bezierPath addLineToPoint: CGPointMake(22.06, 24.79)];
        [bezierPath addCurveToPoint: CGPointMake(19.5, 27.32) controlPoint1: CGPointMake(20.65, 24.79) controlPoint2: CGPointMake(19.5, 25.92)];
        [bezierPath addLineToPoint: CGPointMake(19.5, 42.47)];
        [bezierPath addCurveToPoint: CGPointMake(22.06, 45) controlPoint1: CGPointMake(19.5, 43.87) controlPoint2: CGPointMake(20.65, 45)];
        [bezierPath addLineToPoint: CGPointMake(48.94, 45)];
        [bezierPath addCurveToPoint: CGPointMake(51.5, 42.47) controlPoint1: CGPointMake(50.35, 45) controlPoint2: CGPointMake(51.5, 43.87)];
        [bezierPath addLineToPoint: CGPointMake(51.5, 27.32)];
        [bezierPath addCurveToPoint: CGPointMake(48.94, 24.79) controlPoint1: CGPointMake(51.5, 25.92) controlPoint2: CGPointMake(50.35, 24.79)];
        [bezierPath addLineToPoint: CGPointMake(43.65, 24.79)];
        [bezierPath addLineToPoint: CGPointMake(40.57, 21.75)];
        [bezierPath addCurveToPoint: CGPointMake(38.75, 21) controlPoint1: CGPointMake(40.09, 21.28) controlPoint2: CGPointMake(39.46, 21)];
        [bezierPath closePath];
        [bezierPath moveToPoint: CGPointMake(35.5, 28.58)];
        [bezierPath addCurveToPoint: CGPointMake(29.74, 34.26) controlPoint1: CGPointMake(32.32, 28.58) controlPoint2: CGPointMake(29.74, 31.12)];
        [bezierPath addCurveToPoint: CGPointMake(35.5, 39.95) controlPoint1: CGPointMake(29.74, 37.4) controlPoint2: CGPointMake(32.32, 39.95)];
        [bezierPath addCurveToPoint: CGPointMake(41.26, 34.26) controlPoint1: CGPointMake(38.68, 39.95) controlPoint2: CGPointMake(41.26, 37.4)];
        [bezierPath addCurveToPoint: CGPointMake(35.5, 28.58) controlPoint1: CGPointMake(41.26, 31.12) controlPoint2: CGPointMake(38.68, 28.58)];
        [bezierPath closePath];
        [bezierPath moveToPoint: CGPointMake(42.54, 34.26)];
        [bezierPath addCurveToPoint: CGPointMake(35.5, 41.21) controlPoint1: CGPointMake(42.54, 38.09) controlPoint2: CGPointMake(39.38, 41.21)];
        [bezierPath addCurveToPoint: CGPointMake(28.46, 34.26) controlPoint1: CGPointMake(31.62, 41.21) controlPoint2: CGPointMake(28.46, 38.09)];
        [bezierPath addCurveToPoint: CGPointMake(35.5, 27.32) controlPoint1: CGPointMake(28.46, 30.43) controlPoint2: CGPointMake(31.62, 27.32)];
        [bezierPath addCurveToPoint: CGPointMake(42.54, 34.26) controlPoint1: CGPointMake(39.38, 27.32) controlPoint2: CGPointMake(42.54, 30.43)];
        [bezierPath closePath];
        [bezierPath moveToPoint: CGPointMake(70, 70)];
        [bezierPath addLineToPoint: CGPointMake(0, 70)];
        [bezierPath addLineToPoint: CGPointMake(0, 0)];
        [bezierPath addLineToPoint: CGPointMake(70, 0)];
        [bezierPath addLineToPoint: CGPointMake(70, 70)];
        [bezierPath closePath];
        [[UIColor whiteColor] setFill];
        [bezierPath fill];

    } forState:UIControlStateHighlighted];


    [self addSubview:self.captureButton];
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
    
    CGFloat heightModifierForAngle = sin (M_PI_4 / 4) * lineRadius;
    
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
