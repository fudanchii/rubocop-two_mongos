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

        def field_type(node)
          begin_pos = 0
          end_pos = 0
          tokens = tokens(node)
          tokens.each_with_index do |token, idx|
            if t_const?(token) && t_comma?(prev_token(tokens, idx))
              begin_pos = token.begin_pos
            end

            if last_token?(tokens, idx) || !t_colon2?(next_token(tokens, idx))
              end_pos = token.end_pos
            end

            next if t_colon2?(token)
          end
          Parser::Source::Range.new(node.loc.expression.source_buffer, begin_pos, end_pos)
        end

        private

        # move to another module!!!

        def t_const?(token)
          token&.type == :tCONSTANT
        end

        def t_comma?(token)
          token&.type == :tCOMMA
        end

        def t_colon2?(token)
          token&.type == :tCOLON2
        end

        def prev_token(tokens, idx)
          tokens[idx - 1]
        end

        def next_token(tokens, idx)
          tokens[idx + 1]
        end

        def last_token?(tokens, idx)
          (tokens.length - 1) == idx
        end
      end
    end
  end
end
