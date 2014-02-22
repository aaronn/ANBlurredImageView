//
//  ANBlurredImageView.m
//
//  Created by Aaron Ng on 1/4/14.
//  Copyright (c) 2014 Delve. All rights reserved.
//

#import "ANBlurredImageView.h"
#import "UIImage+BoxBlur.h"

@implementation ANBlurredImageView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    _baseImage = self.image;
    [self generateBlurFramesWithCompletion:^{}];
    
    // Defaults
    self.animationDuration = 0.1f;
    self.animationRepeatCount = 1;
}

// Downsamples the image so we avoid needing to blur a huge image.
-(UIImage*)downsampleImage{
    NSData *imageAsData = UIImageJPEGRepresentation(self.baseImage, 0.001);
    UIImage *downsampledImaged = [UIImage imageWithData:imageAsData];
    return downsampledImaged;
}

#pragma mark -
#pragma mark Animation Methods


-(void)generateBlurFramesWithCompletion:(void(^)())completion{
    
    // Reset our arrays. Generate our reverse array at the same time to save work later on blurOut.
    _framesArray = [[NSMutableArray alloc]init];
    _framesReverseArray = [[NSMutableArray alloc]init];
    
    // Our default number of frames, if none is provided.
    // Keep this low to prevent huge performance issues.
    NSInteger frames = 5;
    if (_framesCount)
        frames = _framesCount;
    
    if (!_blurTintColor)
        _blurTintColor = [UIColor clearColor];
    
    // Set our blur amount, 0-1 if availabile.
    // If < 0, reset to lowest blur. If > 1, reset to highest blur.
    CGFloat blurLevel = _blurAmount;
    if (_blurAmount < 0.0f || !_blurAmount)
        blurLevel = 0.1f;
    
    if (_blurAmount > 1.0f)
        blurLevel = 1.0f;
    
    UIImage *downsampledImage = [self downsampleImage];
    
    // Create our array, set each image as a spot in the array.
    for (int i = 0; i < frames; i++){
        UIImage *blurredImage = [downsampledImage drn_boxblurImageWithBlur:((CGFloat)i/frames)*blurLevel withTintColor:[_blurTintColor colorWithAlphaComponent:(CGFloat)i/frames * CGColorGetAlpha(_blurTintColor.CGColor)]];
        
        if (blurredImage){
            // Our normal animation.
            [_framesArray addObject:blurredImage];
            // Our reverse animation.
            [_framesReverseArray insertObject:blurredImage atIndex:0];
        }
        
    }
    completion();
    
}

-(void)blurInAnimationWithDuration:(CGFloat)duration{
    
    // Set our duration.
    self.animationDuration = duration;
    
    // Set our forwards image array;
    self.animationImages = _framesArray;
    
    // Set our image to the last image to make sure it's permanent on animation end.
    [self setImage:[_framesArray lastObject]];
    
    // BOOM! Blur in.
    [self startAnimating];
}

-(void)blurOutAnimationWithDuration:(CGFloat)duration{
    
    // Set our duration.
    self.animationDuration = duration;
    
    // Set our reverse image array.
    self.animationImages = _framesReverseArray;
    
    // Set our end frame.
    [self setImage:_baseImage];
    
    // BOOM! Blur out.
    [self startAnimating];
}

-(void)blurInAnimationWithDuration:(CGFloat)duration completion:(void(^)())completion{
    
    // Call our blurout with the correct duration.
    [self blurInAnimationWithDuration:duration];
    
    // Our callback
    // Via http://stackoverflow.com/questions/9283270/access-method-after-uiimageview-animation-finish
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, self.animationDuration * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        if(completion){
            completion();
        }
    });
}

-(void)blurOutAnimationWithDuration:(CGFloat)duration completion:(void(^)())completion{
    
    // Call our blurout with the correct duration.
    [self blurOutAnimationWithDuration:duration];
    
    // Our callback
    // Via http://stackoverflow.com/questions/9283270/access-method-after-uiimageview-animation-finish
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, self.animationDuration * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        if(completion){
            completion();
        }
    });
}

@end
