//
//  ANViewController.m
//  ANBlurredImageViewDemo
//
//  Created by Aaron Ng on 1/5/14.
//  Copyright (c) 2014 Delve. All rights reserved.
//

#import "ANViewController.h"

@interface ANViewController ()

@end

@implementation ANViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // Fewer is better, default is 5 because this was intended for quick transitions. 20 is for demonstration purposes & a smoother animation.
    [_imageView setFramesCount:20];
    
    // Best to set blurAmount and blurTint early on, since frames are precalculated. // If you need to change them, call generateBlurFramesWithCompletion but use sparingly because of performance issues.
    [_imageView setBlurAmount:1];
    
    _tinted = NO;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)blur:(id)sender{
    if (_tinted)
    {
        // Might take a while if we gotta recalculate frames.
        [NSThread detachNewThreadSelector:@selector(threadStartAnimating:) toTarget:self withObject:nil];
        
        // Clear is the default blur color if none is set. We're resetting this because one gets set if blurWithTint is called.
        [_imageView setBlurTintColor:[UIColor clearColor]];
        
        // Recalculate normal blur without tint.
        [_imageView generateBlurFramesWithCompletion:^{
            dispatch_async(dispatch_get_main_queue(), ^{
                [_spinner stopAnimating];
            });
            // Blur with duration, also has a version w/ a callback.
            [_imageView blurInAnimationWithDuration:0.25f];
        }];
    }
    else{
        [_imageView blurInAnimationWithDuration:0.25f];
    }
    _tinted = NO;
    
}

- (void) threadStartAnimating:(id)data {
    // Just here for demonstration, really. In case you set the framesCount really high, it might be good to present a spinner.
    [_spinner startAnimating];
}


-(IBAction)blurWithTint:(id)sender{
    
    if (!_tinted){
        // Might take a while if we gotta recalculate frames.
        [NSThread detachNewThreadSelector:@selector(threadStartAnimating:) toTarget:self withObject:nil];
        
        // Arbitrary blur color. Fades in alpha from 0 to selected alpha.
        [_imageView setBlurTintColor:[UIColor colorWithWhite:0.11f alpha:0.5]];
        
        // Recalculate frames, or risk them not showing.
        // Call sparingly, best if everything is set before in viewDidLoad or earlier to prevent recalculation.
        [_imageView generateBlurFramesWithCompletion:^{
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [_spinner stopAnimating];
            });
            [_imageView blurInAnimationWithDuration:0.25f];
            
        }];
    }
    else{
        [_imageView blurInAnimationWithDuration:0.25f];
    }
    // If user presses non-tint blur, know to re-calculate frames without tint.
    _tinted = YES;
    
}

-(IBAction)unBlur:(id)sender{
    // Reversed blur animation.
    [_imageView blurOutAnimationWithDuration:0.5f];
}

@end
