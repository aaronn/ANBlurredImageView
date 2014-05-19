# ANBlurredImageView
Subclass of UIImageView for animating the blurring and unblurring of images with a tint color. Useful for quick transitions and bringing focus to the foreground.

![Blurred View](http://cl.ly/image/1m0O382f3g1F/blur-3.gif)

## Installation
Drag the following files into your project. Made to work with iOS7+.

    ANBlurredImageView.h
    ANBlurredImageView.m
    UIImage+BoxBlur.h
    UIImage+BoxBlur.m

## Usage
This was made for fast transitions and builds on top of UIImageView's startAnimation and stopAnimation. 

Default values are as follows: 

    frameCount = 5; // Number of frames, 
    blurTintColor =  [UIColor clearColor]; // If an alpha is specified, starts at 0 alpha and works its way up to the alpha value with each frame.
    blurAmount = 0.1f; // Takes between 0 and 1.

Blur your image by calling any of the following on your imageView:

    -(void)blurInAnimationWithDuration:(CGFloat)duration;
    -(void)blurOutAnimationWithDuration:(CGFloat)duration;
    -(void)blurInAnimationWithDuration:(CGFloat)duration completion:(void(^)())completion;
    -(void)blurOutAnimationWithDuration:(CGFloat)duration completion:(void(^)())completion;

Set all your values as early as possible, ideally in the superview's viewDidload. **Since we're calculating frames, any change to the frameCount, blurTintColor, blurAmount or the image after the view has loaded requires that you call the following method to ensure your changes are processed.**

    -(void)generateBlurFramesWithCompletion:(void(^)())completion;



## Demo
Demo shows normal blurring, tinted blurring and unblurring. The demo uses more frames than you might need, so switching between normal blur and tinted blurring takes some time to recalculate the frames based on image size and frame count. 

## Credits
The image box blur algorithm is from [IndieAmbitions Blog](http://indieambitions.com/idevblogaday/perform-blur-vimage-accelerate-framework-tutorial/?utm_source=feedburner&utm_medium=feed&utm_campaign=Feed%3A+IndieAmbitions+%28Indie+Ambitions%29). UIImage category is modified from [ios-relatimeblur](https://github.com/alexdrone/ios-realtimeblur). 

**Follow me on Twitter at [@aaronykng](http://www.twitter.com/aaronykng).**

## License
Do whatever you'd like. I'd appreciate a link back and a mention if you use it though!