//
//  YXYViewController.m
//  ImageMask
//
//  Created by 杨萧玉 on 14-4-9.
//  Copyright (c) 2014年 杨萧玉. All rights reserved.
//

#import "YXYViewController.h"

@interface YXYViewController ()
@property (weak, nonatomic) IBOutlet UIButton *uploadBtn;

@end

@implementation YXYViewController
@synthesize FengjieMask;
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    FengjieMask.radius = 20;
    [FengjieMask beginInteraction];
    FengjieMask.imageMaskFilledDelegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark ImageMaskFilledDelegate
- (void) imageMaskView:(ImageMaskView *)maskView clearPercentDidChanged:(float)clearPercent{
    if (clearPercent > 50) {
        [UIView animateWithDuration:2
                         animations:^{
                             FengjieMask.userInteractionEnabled = NO;
                             FengjieMask.alpha = 0;
                             FengjieMask.imageMaskFilledDelegate = nil;
                         }
                         completion:^(BOOL finished) {
                         }];
    }
}

- (IBAction)uploadAction:(id)sender {
    [self.FengjieMask setAlpha:1];
    [self.uploadBtn setAlpha:0];  
    
//    [UIView animateWithDuration:1.0 animations:^(void) {
////        image1.alpha = 0;
////        image2.alpha = 1;
//        self.FengjieMask.alpha = 1;
//    }];
    
    UIImage * a = [self imageWithView:self.view];
    NSLog(@"%a",a.size.height);
    
}

- (UIImage *) imageWithView:(UIView *)view
{
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.opaque, 0.0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return img;
}

-(BOOL)prefersStatusBarHidden {
    
    return YES;
    
}


@end
