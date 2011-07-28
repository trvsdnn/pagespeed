# -*- encoding: utf-8 -*-
$:.push File.expand_path('../lib', __FILE__)
require 'pagespeed/version'

Gem::Specification.new do |s|
  s.name        = 'pagespeed'
  s.version     = PageSpeed::VERSION
  s.authors     = ['blahed']
  s.email       = ['tdunn13@gmail.com']
  s.homepage    = ''
  s.summary     = 'Pulls google pagespeed results for a given site'
  s.description = ''

  s.rubyforge_project = 'pagespeed'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
