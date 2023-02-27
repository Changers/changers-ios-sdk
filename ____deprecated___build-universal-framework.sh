# create folder where we place built frameworks
mkdir build

# build framework for simulators
xcodebuild clean build -project ~/Documents/Changers/Changers-iOS-SDK/iOS-SDK/changers-sdk/changers-sdk.xcodeproj -scheme changers-sdk -destination "generic/platform=iOS Simulator" -derivedDataPath derived_data SKIP_INSTALL=NO BUILD_LIBRARY_FOR_DISTRIBUTION=YES

# create folder to store compiled framework for simulator
mkdir ~/Workspace/Changers-iOS-SDK/SDK/changers-ios-sdk/build/simulator

# copy compiled framework for simulator into our build folder
mv derived_data/Build/Products/Release-iphonesimulator/ChangersSDK.framework build/simulator

#build framework for devices
xcodebuild clean build -project ~/Workspace/Changers-iOS-SDK/iOS-SDK/changers-sdk/changers-sdk.xcodeproj -scheme changers-sdk -derivedDataPath derived_data -destination "generic/platform=iOS" SKIP_INSTALL=NO BUILD_LIBRARY_FOR_DISTRIBUTION=YES

# create folder to store compiled framework for simulator
mkdir ~/Workspace/Changers-iOS-SDK/SDK/changers-ios-sdk/build/devices

# copy compiled framework for simulator into our build folder
cp -rf derived_data/Build/Products/Release-iphoneos/ChangersSDK.framework build/devices

# create folder to store compiled universal framework
mkdir build/universal

####################### Create universal framework #############################
# copy device framework into universal folder
cp -r build/devices/ChangersSDK.framework build/universal/

# create framework binary compatible with simulators and devices, and replace binary in universal framework
lipo -create build/simulator/ChangersSDK.framework/ChangersSDK  build/devices/ChangersSDK.framework/ChangersSDK   -output build/universal/ChangersSDK.framework/ChangersSDK

# copy simulator Swift public interface to universal framework
cp -rf build/simulator/ChangersSDK.framework/Modules/ChangersSDK.swiftmodule/* build/universal/ChangersSDK.framework/Modules/ChangersSDK.swiftmodule
cp -rf build/universal/ChangersSDK.framework ./
