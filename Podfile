# platform :ios, '9.0'

target 'MyMovies' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for MyMovies
   pod 'SwiftGen'
   pod "Moya-SwiftyJSONMapper/RxSwift"
   pod 'Kingfisher'
   pod "Reusable"

end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['SWIFT_VERSION'] = '3.0'
    end
  end
end
