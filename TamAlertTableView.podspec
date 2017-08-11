Pod::Spec.new do |s|
    s.name         = "TamAlertTableView"
    s.version      = '1.0.0'
    s.summary      = "A short description of TamAlertTableView."
    s.homepage      =  'https://github.com/thatha123/TamAlertTableView'
    s.license       =  'MIT'
    s.authors       = {'Tam' => '1558842407@qq.com'}
    s.platform      =  :ios,'8.0'
    s.source        = {:git => 'https://github.com/thatha123/TamAlertTableView.git',:tag => "v#{s.version}" }
    s.source_files  =  'TamAlertTableViewDemo/TamAlertTableView/*.{h,m}'
    s.requires_arc  =  true
end
