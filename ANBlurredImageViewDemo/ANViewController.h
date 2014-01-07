//
//  ANViewController.h
//  ANBlurredImageViewDemo
//
//  Created by Aaron Ng on 1/5/14.
//  Copyright (c) 2014 Delve. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ANBlurredImageView.h"
@interface ANViewController : UIViewController
@property (strong) IBOutlet ANBlurredImageView *imageView;

// Blur without tint.
@property (assign) IBOutlet UIButton *blurButton;

// If tinted and blurButton is called, recalc frames.
@property (assign) BOOL tinted;

// Blur by playing the animation with a tint.
@property (assign) IBOutlet UIButton *blurWithTintButton;

// Unblur by playing the animation in reverse.
@property (assign) IBOutlet UIButton *unblurButton;

// Activity Indicator
@property (assign) IBOutlet UIActivityIndicatorView *spinner;
@end
