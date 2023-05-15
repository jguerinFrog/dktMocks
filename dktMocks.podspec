#
# Be sure to run `pod lib lint dktMocks.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'dktMocks'
  s.version          = '0.1.0'
  s.summary          = 'Mocks lib for DKT'
  s.description      = 'Dynamic mock lib for dkt project from capgemini'
  s.homepage         = 'https://github.com/jguerinFrog/dktMocks'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'julien.guerin30@gmail.com' => 'julien.guerin@capgemini.com' }
  s.source           = { :git => 'https://github.com/julien.guerin30@gmail.com/dktMocks.git', :tag => s.version.to_s }

  s.ios.deployment_target = '14.0'

  s.source_files = 'dktMocks/Classes/**/*'
  

end
