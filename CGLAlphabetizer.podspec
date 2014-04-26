Pod::Spec.new do |s|
  s.name             = "CGLAlphabetizer"
  s.version          = "0.1.0"
  s.summary          = "A simple class to easily alphabetize an array of objects, useful for UITableViews like iOS's Music and Contacts apps."
  
  s.homepage         = "https://github.com/chrisladd/CGLAlphabetizer"
#  s.screenshots      = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "Chris Ladd" => "c.g.ladd@gmail.com" }
  s.source           = { :git => "https://github.com/chrisladd/CGLAlphabetizer.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/EXAMPLE'

  s.requires_arc = true

  s.source_files = 'Classes'
  
  s.ios.exclude_files = 'Classes/osx'
  s.osx.exclude_files = 'Classes/ios'
  
end
