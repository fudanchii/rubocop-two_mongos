# frozen_string_literal: true

module RuboCop
  module Cop
    module TwoMongos
      # Check MongoMapper's `key` statement and suggest
      # the Mongoid's `field` counterpart.
      #
      # @example
      #   # bad
      #   key :username, String, default: "usagi_tsukino"
      #
      #   # good
      #   field :username, type: String, default: "usagi_tsukino"
      class KeyToFieldWithDefault < Cop
        include RangeHelp

        MSG = 'Use `field :column_name, type: ColumnType, ' \
              'default: DefaultValue` syntax here.'

        def_node_matcher :match_key_declaration?, <<~PATTERN
          (send nil? :key (sym _) (const ...) (hash (pair (sym :default) _)))
        PATTERN

        def on_send(node)
          add_offense(node) if match_key_declaration?(node)
        end

        def autocorrect(node)
          replacement = "type: #{node.arguments[1].source}"
          defval = node.last_argument.pairs.first.value.source
          replacement = "#{replacement}, default: #{defval}"

          lambda do |corrector|
            corrector.replace(node.loc.selector, 'field')
            corrector.replace(node.arguments[1].source_range, replacement)
            corrector.remove(last_arg_range(node))
          end
        end

        def last_arg_range(node)
          range_between(
            node.arguments[1].loc.expression.end_pos,
            node.loc.expression.end_pos
          )
        end
      end
    end
  end
end
