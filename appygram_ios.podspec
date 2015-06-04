#
# Be sure to run `pod lib lint appygram_ios.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "appygram_ios"
  s.version          = "0.1.0"
  s.summary          = "iOS connector library for Appygram written in Swift."
  s.description      = <<-DESC
                       iOS connector library for Appygram written in Swift.

                       Use this library to easily create and send messages to your Appygram account.
                       DESC
  s.homepage         = "https://github.com/GoGoCarl/appygram_ios"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "Carl Scott" => "carl.scott@solertium.com" }
  s.source           = { :git => "https://github.com/GoGoCarl/appygram_ios.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/GoGoCarl'

  s.platform     = :ios, '8.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'appygram_ios' => ['Pod/Assets/*.png']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'ObjectMapper', '~> 0.12'
  s.dependency 'Alamofire', '~> 1.2'
  s.dependency 'AlamofireObjectMapper', '~> 0.2'

end
