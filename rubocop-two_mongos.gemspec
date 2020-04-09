# frozen_string_literal: true

require_relative 'lib/rubocop/two_mongos/version'

Gem::Specification.new do |spec|
  spec.name          = 'rubocop-two_mongos'
  spec.version       = RuboCop::TwoMongos::VERSION
  spec.authors       = ['Nurahmadie']
  spec.email         = ['nurahmadie@gmail.com']

  spec.summary       = 'mongomapper to mongoid translator'
  spec.description   = 'mongomapper to mongoid translator'
  spec.required_ruby_version = Gem::Requirement.new('>= 2.3.0')

  spec.metadata['source_code_uri'] = 'https://github.com/fudanchii/rubocop-two_mongos'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been
  # added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`
      .split("\x0")
      .reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'rubocop'
end
