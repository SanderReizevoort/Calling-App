source 'https://github.com/CocoaPods/Specs.git'

workspace 'CallingApp'

abstract_target 'TwilioVoice' do
  pod 'TwilioVoice', '~> 2.0.0'
  use_frameworks!

  
  
  target 'CallingApp' do
    pod 'Koloda'
    platform :ios, '10.0'
    project 'CallingApp.xcproject'
  end
  
  post_install do |installer|
      `find Pods -regex 'Pods/pop.*\\.h' -print0 | xargs -0 sed -i '' 's/\\(<\\)pop\\/\\(.*\\)\\(>\\)/\\"\\2\\"/'`
  end
end
