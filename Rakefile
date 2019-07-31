require 'rdoc/task'
require 'rake/testtask'
require File.join(File.dirname(__FILE__), 'lib', 'net', 'ntlm')

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
