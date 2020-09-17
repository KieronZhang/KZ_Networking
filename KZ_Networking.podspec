
Pod::Spec.new do |s|

    s.name = 'KZ_Networking'
    s.version = '0.1.11'
    s.summary = 'iOS & macOS NetWorkingAndCache.'
    s.homepage = 'https://github.com/KieronZhang/KZ_Networking'
    s.license = {:type => 'MIT', :file => 'LICENSE'}
    s.author = {'KieronZhang' => 'https://github.com/KieronZhang'}

    s.source = {:git => 'https://github.com/KieronZhang/KZ_Networking.git', :tag => s.version, :submodules => true}
    s.xcconfig = {'OTHER_LDFLAGS' => '-ObjC'}
    s.requires_arc = true

    s.ios.frameworks = 'Foundation', 'UIKit', 'CoreTelephony', 'MobileCoreServices', 'CoreGraphics', 'Security', 'SystemConfiguration'
    s.osx.frameworks = 'Foundation', 'AppKit', 'CoreServices', 'CoreGraphics', 'Security', 'SystemConfiguration'

    s.ios.deployment_target = '8.0'
    s.osx.deployment_target = '10.10'

    s.ios.vendored_frameworks = 'KZ_Networking/KZ_Networking_iOS.framework'
    s.osx.vendored_frameworks = 'KZ_Networking/KZ_Networking_macOS.framework'

    s.dependency 'KZ_DatabaseModel'
    s.dependency 'KZ_Categories'

end
