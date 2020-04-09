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
        MSG = 'Use `field :column_name, type: ColumnType` syntax here.'

        def_node_matcher :key_declaration, <<~PATTERN
          (send nil? :key (sym _) (const ...))
        PATTERN

        def on_send(node)
          return add_offense(node) if key_declaration(node)
        end

        def autocorrect(node)
          lambda do |corrector|
            corrector.replace(node.loc.selector, 'field')
            corrector.replace(
              node.last_argument.source_range,
              "type: #{node.children[3].source}"
            )
          end
        end
      end
    end
  end
end
