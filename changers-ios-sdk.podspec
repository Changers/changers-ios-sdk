
Pod::Spec.new do |s|
    s.name         = "changers-ios-sdk"
    s.version      = "1.4.0"
    s.summary      = "A brief description of Changers iOS SDK project."
    s.description  = <<-DESC
    An extended description of Changers iOS SDK project.
    DESC
    s.homepage     = "https://changers.com/"
    s.license = { :type => 'Copyright', :text => <<-LICENSE
                   Copyright 2020             
                  LICENSE
                }
    s.author             = { "Clement Yerochewski" => "c.yerochewski@changers.com" }
    s.source       = { :git => "https://github.com/Changers/changers-ios-sdk.git", :tag => "#{s.version}" }
    s.public_header_files = "ChangersSDK.framework/Headers/*.h"
    s.source_files = "ChangersSDK.framework/Headers/*.h"
    s.vendored_frameworks = "ChangersSDK.framework"
    s.platform = :sos
    s.swift_version = "5.0"
    s.ios.deployment_target  = '11.0'
    s.user_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }
    s.pod_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }
end
