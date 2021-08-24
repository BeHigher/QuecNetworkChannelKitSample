# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'
source 'https://github.com/CocoaPods/Specs.git'
source 'https://github.com/BeHigher/IoTPublicSpeces.git'

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      target.build_settings(config.name)['CLANG_ALLOW_NON_MODULAR_INCLUDES_IN_FRAMEWORK_MODULES'] = 'YES'
    end
  end
end

target 'QuecNetworkChannelKitSample' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  pod "QuecNetworkChannelKit"

  # Pods for QuecNetworkChannelKitSample

  target 'QuecNetworkChannelKitSampleTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'QuecNetworkChannelKitSampleUITests' do
    # Pods for testing
  end

end
