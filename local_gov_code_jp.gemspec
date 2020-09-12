require_relative 'lib/local_gov_code_jp/version'

Gem::Specification.new do |spec|
  spec.name          = "local_gov_code_jp"
  spec.version       = LocalGovCodeJp::VERSION
  spec.authors       = ["qsona"]
  spec.email         = ["mori.jmk@gmail.com"]

  spec.summary       = "A Ruby Implementation of Local Gov Code (地方公共団体コード) data"
  spec.description   = "A Ruby Implementation of Local Gov Code (地方公共団体コード) data. This library just wraps nojimage/local-gov-code-jp 's data and provide several methods."
  spec.homepage      = "https://github.com/qsona/local-gov-code-jp-ruby"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/qsona/local-gov-code-jp-ruby"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
end
