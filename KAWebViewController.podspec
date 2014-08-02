Pod::Spec.new do |s|

    s.name              = 'KAWebViewController'
    s.version           = '0.2.0'
    s.summary           = 'A UIWebView ViewController to be used with a UINavigationController or on its own as a modal segue'
    s.homepage          = 'https://github.com/adamskyle/KAWebViewController'
    s.license           = {
        :type => 'MIT',
        :file => 'LICENSE'
    }
    s.author            = {
        'Kyle Adams' => 'kpe.adams@gmail.com'
    }
    s.source            = {
        :git => 'https://github.com/adamskyle/KAWebViewController.git',
        :tag => s.version.to_s
    }
    s.platform          = :ios
    s.source_files      = 'KAWebViewController/*.{m,h}'
    s.resources         = 'KAWebViewController/KAWebViewController.xcassets'
    s.requires_arc      = true

end