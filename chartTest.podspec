@version = "0.1.2"

Pod::Spec.new do |s|
  s.name          = "chartTest"
  s.version       = @version
  s.summary       = "一款多种特效的折线图"
  s.description   = "一款多种特效的折线图"
  s.homepage      = "https://github.com/lihaiyang123/LHYChartView"
  s.license       = { :type => "MIT", :file => "LICENSE" }
  s.author        = { "lihaiyang123" => "lihaiyang730325@qq.com" }
  s.ios.deployment_target   = '8.0'
  s.source        = { :git => "https://github.com/lihaiyang123/LHYChartView.git", :tag => "v#{s.version}" }
  s.source_files  = 'chartTest/chartTest/charView/*'
  s.requires_arc  = true
  s.framework     = "UIKit"
  s.dependency 'Masonry'
end

