
Pod::Spec.new do |s|

  # 1
  s.platform     = :ios
  s.ios.deployment_target = '8.0'
  s.name         = "HLoading"
  s.summary      = "HLoading use for iOS app."

  #2
  s.version      = "0.1.0"

  #3
  # s.license    = { :type => "MIT", :file => "LICENSE" }


  #4
  # s.authors            = { "Huy Nguyen" => "manhuy1710@gmail.com" }
  # s.social_media_url   = "https://www.facebook.com/huy.remy.1"

  #5
  # s.homepage = "https://github.com/huy1710/HLoading"

  #6
  s.source     = { :git => "https://github.com/huy1710/HLoading.git", :tag => "#{s.version}" }

end
