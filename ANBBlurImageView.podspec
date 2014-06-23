Pod::Spec.new do |s|

  s.name         = "ANBBlurImageView"
  s.version      = "0.0.1"
  s.summary      = "Subclass of UIImageView for animating the blurring and unblurring of images with a tint color. Useful for quick transitions and bringing focus to the foreground."
  s.homepage     = "https://github.com/aaronn/ANBlurredImageView"
  s.license      = "MIT (example)"
  s.author             = { "Dipak" => "dipak@mywickr.com" }
  s.platform     = :ios, "6.0"
  s.source       = { :git => "git@github.com:aaronn/ANBlurredImageView.git", :tag => "0.0.1" }
  s.source_files  = "ANBlurredImageView/*.{h,m}"
  s.resource  = "icon.png"
  s.framework  = "Accelerate","QuartzCore"
  s.requires_arc = true
end
