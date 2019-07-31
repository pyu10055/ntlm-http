# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name        = "ntlm-http"
  s.version     = "0.1.3.3"
  s.authors     = ["Kohei Kajimoto", "Kingsley Hendrickse", "Michael Ries"]
  s.email       = ["kingsley@mindflowsolutions.com","michael@riesd.com"]
  s.homepage    = ""
  s.summary = %q{Ruby/NTLM HTTP library.}
  s.description = %q{Ruby/NTLM HTTP provides NTLM authentication over http.}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
end
