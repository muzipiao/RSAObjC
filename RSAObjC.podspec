Pod::Spec.new do |s|
  s.name             = 'RSAObjC'
  s.version          = '0.1.1'
  s.summary          = 'iOS 端使用 RSA 加密解密。'

  s.description      = <<-DESC
 基于 ObjC 封装 RSA 加密解密，生成公私钥工具类，方便 iOS 端使用。
                       DESC

  s.homepage         = 'https://github.com/muzipiao/RSAObjC'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'lifei' => 'lifei_zdjl@126.com' }
  s.source           = { :git => 'https://github.com/muzipiao/RSAObjC.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'
  s.source_files = 'RSAObjC/Classes/**/*'
  s.public_header_files = 'RSAObjC/Classes/**/*.h'
  s.frameworks = 'Foundation', 'Security'
  s.requires_arc = true
end
