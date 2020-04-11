# frozen_string_literal: true

module RuboCop
  module Cop
    module TwoMongos
      module Proper
        # Rule out all key statement with aliasing.
        # In Mongoid the arg for aliasing is inverted compared to
        # Monomapper aliases. Avoid if possible.
        #
        # @example
        #   #bad
        #   key :username, String, alias: :uname
        #
        #   #good
        #   key :uname, String
        class KeyWithAlias < Cop
          MSG = 'Avoid abbr, field_name, and/or alias in mongomapper. ' \
                'It will need to be inverted in Mongoid.'

          ALIAS_KEYWORDS = %i[
            abbr
            field_name
            alias
          ].freeze

          def_node_matcher :match_key_declaration?, <<~PATTERN
            (send nil? :key (sym _) (const ...) (hash $...))
          PATTERN

          def on_send(node)
            pairs = match_key_declaration?(node)
            return unless pairs

            add_offense(node) if aliased?(pairs)
          end

          def aliased?(pairs)
            pairs.any? { |pair| ALIAS_KEYWORDS.include?(pair.key.value) }
          end
        end
      end
    end
  end
end
