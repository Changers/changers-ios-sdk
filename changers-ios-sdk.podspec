
Pod::Spec.new do |s|
    s.name         = "changers-ios-sdk"
    s.version      = "4.3.0"
    s.summary      = "Changers iOS SDK"
    s.description  = <<-DESC
    The Changers iOS SDK: sustainable mobility tracking, the Changers web
    application, and deep link handling for QR codes and referral links.
    DESC
    s.homepage     = "https://changers.com/"
    s.license = { :type => 'Copyright', :text => <<-LICENSE
                   Copyright 2020             
                  LICENSE
                }
    s.author             = { "Clement Yerochewski" => "c.yerochewski@changers.com" }
    s.source       = { :git => "https://github.com/Changers/changers-ios-sdk.git", :tag => "#{s.version}" }
    s.vendored_frameworks = "ChangersSDK.xcframework"
    s.platform = :ios, '15.0'
    s.swift_version = "5.0"
    s.ios.deployment_target  = '15.0'
end
