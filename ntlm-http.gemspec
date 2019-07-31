# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name        = "pyu-ntlm-http"
  s.version     = "0.1.3.3"
  s.authors     = ["Kohei Kajimoto", "Kingsley Hendrickse", "Michael Ries"]
  s.email       = ["kingsley@mindflowsolutions.com","michael@riesd.com"]
  s.homepage = %q{https://rubygems.org/gems/pyu-ntlm-http}
  s.summary = %q{Ruby/NTLM HTTP library.}
  s.description = %q{Ruby/NTLM HTTP provides NTLM authentication over http.}

  s.files = ["Rakefile", "README"] + Dir.glob("{lib,examples}/**/*.rb")

  s.extra_rdoc_files = %w( README )
  s.rdoc_options.concat ['--main', 'README']
end
