#
# Be sure to run `pod lib lint GameSoundManager.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'GameSoundManager'
  s.version          = '1.0.2'
  s.summary          = 'A wrapper to manipulate sounds.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
A wrapper to manipulate sounds and background tracks in your game.
                       DESC

  s.homepage         = 'https://github.com/Morbix/GameSoundManager'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Henrique Morbin' => 'morbin_@hotmail.com' }
  s.source           = { :git => 'https://github.com/Morbix/GameSoundManager.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/Morbin_'

  s.ios.deployment_target = '8.0'

  s.source_files = 'GameSoundManager/Classes/**/*'
  
  # s.resource_bundles = {
  #   'GameSoundManager' => ['GameSoundManager/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'AVFoundation'
  # s.dependency 'AFNetworking', '~> 2.3'
end
