# frozen_string_literal: true

require_relative "lib/zettacode/version"

Gem::Specification.new do |spec|
  spec.name = "zettacode"
  spec.version = Zettacode::VERSION
  spec.authors = ["David Vargas Ruiz"]
  spec.email = ["dvarrui@protonmail.com"]
  spec.license = "GPL-3.0"

  spec.summary = "Manage files from Rosetta Code web site."
  spec.description = "Magage files from Rosetta Code web site."
  spec.homepage = "https://github.com/dvarrui/zettacode"
  spec.required_ruby_version = ">= 3.1.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = "https://github.com/dvarrui/zettacode/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = "bin"
  spec.executables << "zettacode"
  spec.executables << "zcode"
  spec.require_paths = ["lib"]

  # spec.files = Dir.glob(File.join("lib", "**", "*.*"))

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"
  spec.add_runtime_dependency "colorize", "~> 0.8"
  spec.add_runtime_dependency "httparty", "~> 0.20"
  spec.add_runtime_dependency "optparse", "~> 0.2"
  spec.add_runtime_dependency "nokogiri", "~> 1.13"
  # spec.add_runtime_dependency "thor", "~> 1.2"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
