//
//  DRViewController.m
//  DRCameraViewSample
//
//  Created by Dal Rupnik on 03/04/14.
//  Copyright (c) 2014 arvystate.net. All rights reserved.
//

#import "DRCameraView.h"
#import "DRCameraInterfaceView.h"

#import "DRViewController.h"

@interface DRViewController ()
@property (weak, nonatomic) IBOutlet DRCameraView *cameraView;

@end

@implementation DRViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.cameraView.interface = [[DRCameraInterfaceView alloc] init];
    
    [self.cameraView startPreviewStream];

}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}


@end
