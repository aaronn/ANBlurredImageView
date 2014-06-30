Pod::Spec.new do |s|

  s.name         = "ANBBlurImageView"
  s.version      = "0.0.1"
  s.summary      = "Subclass of UIImageView to blur "
  s.homepage     = "https://github.com/aaronn/ANBlurredImageView"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "Dipak" => "dipak@mywickr.com" }
  s.platform     = :ios, "6.0"
  s.source       = { :git => "git@github.com:Dipak99041012/ANBlurredImageView.git", :tag => "0.0.1" }
  s.source_files  = "ANBlurredImageView/*.{h,m}"
  s.framework  = "Accelerate","QuartzCore"
  s.requires_arc = true
end
