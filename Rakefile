require 'rdoc/task'
require 'rake/testtask'
require 'rake/packagetask'
require 'rubygems/package_task'
require File.join(File.dirname(__FILE__), 'lib', 'net', 'ntlm')

#PKG_NAME = 'rubyntlm'
PKG_NAME = 'pyu-ntlm-http'
PKG_VERSION = "0.1.3.2"

task :default => [:test]

Rake::TestTask.new(:test) do |t|
  t.test_files = FileList[ "test/*.rb" ]
  t.warning = true
  t.verbose = true
end

Rake::RDocTask.new do |rd|
  rd.rdoc_dir = 'doc'
  rd.title = 'Ruby/NTLM library'
  rd.main = "README"
  rd.rdoc_files.include("README", "lib/**/*.rb")
end

spec = Gem::Specification.new do |s|
  s.name = PKG_NAME
  s.version = PKG_VERSION
  s.summary = %q{Ruby/NTLM HTTP library.}
  s.email = %q{kingsley@mindflowsolutions.com}
  s.homepage = %q{http://www.mindflowsolutions.net}
  s.description = %q{Ruby/NTLM HTTP provides NTLM authentication over http.}
  s.authors = ["Kohei Kajimoto,Kingsley Hendrickse"]

  s.files = ["Rakefile", "README"] + Dir.glob("{lib,examples}/**/*.rb")

  s.extra_rdoc_files = %w( README )
  s.rdoc_options.concat ['--main', 'README']
end

Gem::PackageTask.new(spec) do |p|
  p.gem_spec = spec
  p.need_tar = true
  p.need_zip = true
  p.package_dir = 'build'
end
