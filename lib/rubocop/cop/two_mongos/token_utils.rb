# frozen_string_literal: true

module RuboCop
  module Cop
    module TwoMongos
      module TokenUtils # :nodoc:
        def field_type(node)
          begin_pos = 0
          end_pos = 0
          tokens = tokens(node)
          tokens.each_with_index do |token, idx|
            if t_const?(token) && t_comma?(prev_token(tokens, idx))
              begin_pos = token.begin_pos
            end

            if last_token?(tokens, idx) || !t_colon2?(next_token(tokens, idx))
              next end_pos = token.end_pos
            end
          end
          Parser::Source::Range
            .new(node.loc.expression.source_buffer, begin_pos, end_pos)
        end

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
