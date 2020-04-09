# frozen_string_literal: true

module RuboCop
  module Cop
    module TwoMongos
      # Check MongoMapper's `key` statement and suggest
      # the Mongoid's `field` counterpart.
      #
      # @example
      #   # bad
      #   key :username
      #
      #   # good
      #   field :username
      #
      #   # bad
      #   key :first_name, String
      #
      #   # good
      #   field :first_name, type: String
      class KeyToField < Cop
        include RuboCop::Cop::TwoMongos::TokenUtils

        MSG = 'Please use field syntax here.'

        def_node_matcher :key_declaration, <<~PATTERN
          (send nil? :key (sym $_) (const $...))
        PATTERN

        def on_send(node)
          return add_offense(node) if key_declaration(node)
        end

        def autocorrect(node)
          type_text = node.children[3].source
          lambda do |corrector|
            corrector.replace(node.loc.selector, 'field')
            corrector.replace(field_type(node), "type: #{type_text}")
          end
        end
      end
    end
  end
end
