//
//  ViewController.m
//  AlertViewAnimation
//
//  Created by steven on 13-8-15.
//  Copyright (c) 2013年 steven. All rights reserved.
//

#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface ViewController ()
@property (retain, nonatomic) IBOutlet UIView *STAlertView;
@property (retain, nonatomic) IBOutlet UIView *contentView;
- (IBAction)hideAlertAction:(id)sender;
- (IBAction)showAlertAction:(id)sender;

@end

@implementation ViewController


- (void)dealloc {
    [_STAlertView release];
    [_contentView release];
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor blackColor];
    self.STAlertView.backgroundColor = [UIColor clearColor];
    self.contentView.layer.cornerRadius = 3.0f;
    self.contentView.layer.borderColor = [UIColor colorWithWhite:0.9 alpha:0.9].CGColor;
    self.contentView.layer.borderWidth = 2.0f;
//    [self show];
}

- (void)show{
    self.STAlertView.center = self.view.center;
    [self.view addSubview:self.STAlertView];
    CAKeyframeAnimation *popAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    popAnimation.duration = 0.4;
    popAnimation.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.01f, 0.01f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1f, 1.1f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9f, 0.9f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DIdentity]];
    popAnimation.keyTimes = @[@0.2f, @0.5f, @0.75f, @1.0f];
    popAnimation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                     [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                     [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [self.STAlertView.layer addAnimation:popAnimation forKey:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)hideAlertAction:(id)sender {
    CAKeyframeAnimation *hideAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    hideAnimation.duration = 0.4;
    hideAnimation.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1f, 1.1f, 1.0f)],
                             [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0f, 1.0f, 1.0f)],
                             [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.00f, 0.00f, 0.00f)]];
    hideAnimation.keyTimes = @[@0.2f, @0.5f, @0.75f];
    hideAnimation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                      [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                      [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    hideAnimation.delegate = self;
    [self.STAlertView.layer addAnimation:hideAnimation forKey:nil];
    
}

- (IBAction)showAlertAction:(id)sender {
    if ([self.STAlertView superview] == nil) {
        [self show];
    }
}
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    [self.STAlertView removeFromSuperview];
}

@end
