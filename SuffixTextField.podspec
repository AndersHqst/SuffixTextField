Pod::Spec.new do |s|
  s.name             = "SuffixTextField"
  s.version          = "1.0"
  s.summary          = "A UITextField that can have an arbitrary suffix text"
  s.homepage         = "https://github.com/AndersHqst/SuffixTextField"
  s.license          = 'MIT'
  s.source           = { :git => "https://github.com/AndersHqst/SuffixTextField", :tag => s.version }
  s.authors          = "AndersHqst"

  s.ios.deployment_target = '8.0'

  s.source_files = 'SuffixTextField.swift'

  s.requires_arc = true
end
