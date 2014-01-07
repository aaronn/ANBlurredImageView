//
//  ANBlurredImageView.h
//
//  Created by Aaron Ng on 1/4/14.
//  Copyright (c) 2014 Delve. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ANBlurredImageView : UIImageView

/**
 Our base image, stored because we replace self.image when blurring in and out.
 */
@property (strong, nonatomic) UIImage *baseImage;


/**
 The array of blurred images to cycle through.
 */
@property (strong) NSMutableArray *framesArray;

/**
 A reversed version of framesArray. Populates by inserting at 0 each time the normal framesArray is generated.
 */
@property (strong) NSMutableArray *framesReverseArray;

/**
 Number of frames, default value is 5. Increasing this can cause your app to have huge memory issues. Lower is better, especially when dealing with really fast animations. Nobody will notice!
 */
@property (assign) NSInteger framesCount;

/**
 The blur amount. Default amount is 0.1f A CGFloat from 0.0f to 1.0f.
 */
@property (nonatomic) CGFloat blurAmount;

/**
 The blur's tint color. Fades the tint in with the blur. Set the alpha as the final blur alpha.
 */
@property (strong) UIColor *blurTintColor;


/**
 Regenerates your frames. Only call this manually when absolutely necessary, since all frames are already pre-calculated on load. This doubles the amount of work but is necessary if the values aren't configured immediately on load.
 */
-(void)generateBlurFramesWithCompletion:(void(^)())completion;

/**
 Blur in your image with the specificed duration. blurAmount isn't settable here because the frames need to be preloaded. Blur is set in a background thread, if blur isn't ready then nothing happens.
 @param duration A specified duration in a float.
 */
-(void)blurInAnimationWithDuration:(CGFloat)duration;


/**
 Blur out your image with the specificed duration. blurAmount isn't settable here because the frames need to be preloaded. Blur is set in a background thread, if blur isn't ready then nothing happens.
 @param duration A specified duration in a float.
 */
-(void)blurOutAnimationWithDuration:(CGFloat)duration;


/**
 Blur in an image with a duration and a callback.
 @param duration A specified duration in a float.
 @param completion A codeblock timed to the single-run animationTime.
 */
-(void)blurInAnimationWithDuration:(CGFloat)duration completion:(void(^)())completion;


/**
 Blur out an image with a duration and a callback.
 @param duration A specified duration in a float.
 @param completion A codeblock timed to the single-run animationTime.
 */
-(void)blurOutAnimationWithDuration:(CGFloat)duration completion:(void(^)())completion;


@end
