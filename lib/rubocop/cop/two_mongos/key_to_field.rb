# frozen_string_literal: true

module RuboCop
  module Cop
    module TwoMongos
      # Check MongoMapper's `key` statement and suggest
      # the Mongoid's `field` counterpart.
      #
      # @example
      #   # bad
      #   key :first_name, String
      #
      #   # good
      #   field :first_name, type: String
      class KeyToField < Cop
        include RangeHelp

        MSG = 'Use `field :column_name, type: ColumnType` syntax here.'

        def_node_matcher :match_key_declaration?, <<~PATTERN
          (send nil? :key (sym _) (const ...))
        PATTERN

        def on_send(node)
          add_offense(node) if match_key_declaration?(node)
        end

        def autocorrect(node)
          replacement = "type: #{node.last_argument.source}"
          lambda do |corrector|
            corrector.replace(node.loc.selector, 'field')
            corrector.replace(node.arguments[1].source_range, replacement)
          end
        end
      end
    end
  end
end
