Pod::Spec.new do |s|
  s.name         = "ANBlurredImageView"
  s.version      = "0.0.2"
  s.summary      = "Animated blur-in and blur-out on UIImageView."
  s.homepage     = "https://github.com/aaronn/ANBlurredImageView"
  s.license      = { :type => 'BSD', :text => 'ANBlurredImageView is licensed under the BSD license.'}
  s.author             = { "aaronykng" => "hi@aaron.ng" }
  s.social_media_url   = "http://twitter.com/aaronykng"
  s.platform     = :ios, "7.0"
  s.source       = { :git => "https://github.com/aaronn/ANBlurredImageView.git", :tag => "0.0.2" }
  s.source_files  = "ANBlurredImageView/*.{h,m}"
end
