Pod::Spec.new do |s|

s.name         = 'ZJPageControl'
s.summary      = 'ZJPageControl is a custom animated page control to replace UIPageControl.'
s.version      = '1.0'
s.license      = { :type => 'MIT', :file => 'LICENSE' }
s.authors      = "Evan"
s.homepage     = 'https://github.com/EvanZhou0319/ZJPageControl'
s.platform     = :ios, '7.0'
s.ios.deployment_target = '7.0'
s.requires_arc = true
s.source       = { :git => 'https://github.com/EvanZhou0319/ZJPageControl.git', :tag => s.version.to_s }
s.source_files = 'ZJPageControl/*.{h,m}'
s.frameworks   = 'UIKit'

end
