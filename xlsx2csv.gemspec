$LOAD_PATH.unshift File.dirname(__FILE__) + '/lib'
require 'xlsx2csv/version'

Gem::Specification.new do |spec|
  spec.name        = 'xlsx2csv'
  spec.summary     = 'XLSX to CSV converter'
  spec.version     = Xlsx2Csv::VERSION
  spec.authors     = ['Eugene Sheverdin']
  spec.email       = ['scaint88@gmail.com']

  spec.executables = ['xlsx2csv']
  spec.files       = Dir['lib/**/*', 'bin/*', 'spec/**/*', 'README.md']
  spec.homepage    = 'https://github.com/abmcloud/xlsx2csv'
  spec.test_files  = Dir["spec/**/*_spec.rb"]
  spec.license     = 'Nonstandard'

  spec.add_dependency 'ox', '~> 2.3'
  spec.add_dependency 'slop', '~> 4.6'

  spec.add_development_dependency 'rspec', '~> 0'
end
