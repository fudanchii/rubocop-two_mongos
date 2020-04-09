# frozen_string_literal: true

require 'rubocop'

require_relative 'rubocop/two_mongos'
require_relative 'rubocop/two_mongos/version'
require_relative 'rubocop/two_mongos/inject'

RuboCop::TwoMongos::Inject.defaults!

require_relative 'rubocop/cop/two_mongos/to_mongoid_document'
require_relative 'rubocop/cop/two_mongos/key_to_field'
