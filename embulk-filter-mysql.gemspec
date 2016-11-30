
Gem::Specification.new do |spec|
  spec.name          = "embulk-filter-mysql"
  spec.version       = "0.1.1"
  spec.authors       = ["toyama0919"]
  spec.summary       = "Mysql filter plugin for Embulk. Execute prepared statements query."
  spec.description   = "Mysql filter plugin for Embulk. Execute prepared statements query."
  spec.email         = ["toyama0919@gmail.com"]
  spec.licenses      = ["MIT"]
  spec.homepage      = "https://github.com/toyama0919/embulk-filter-mysql"

  spec.files         = `git ls-files`.split("\n") + Dir["classpath/*.jar"]
  spec.test_files    = spec.files.grep(%r{^(test|spec)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'ffi-mysql'
  spec.add_development_dependency 'embulk', ['>= 0.8.15']
  spec.add_development_dependency 'bundler', ['>= 1.10.6']
  spec.add_development_dependency 'rake', ['>= 10.0']
end
