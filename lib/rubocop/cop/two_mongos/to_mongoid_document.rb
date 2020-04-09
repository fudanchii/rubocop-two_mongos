# frozen_string_literal: true

module RuboCop
  module Cop
    module TwoMongos
      # ToMongoidDocument catches the usage of `MongoMapper::Document`.
      #
      # @example
      #   # bad
      #   include MongoMapper::Document
      #
      #   # good
      #   include Mongoid::Document
      class ToMongoidDocument < Cop
        MSG = 'Use `Mongoid::Document` here.'

        def_node_matcher :mongomapper_document?, <<~PATTERN
          (const (const nil? :MongoMapper) :Document)
        PATTERN

        def on_const(node)
          add_offense(node) if mongomapper_document?(node)
        end

        def autocorrect(node)
          lambda do |corrector|
            corrector.replace(node.loc.expression, 'Mongoid::Document')
          end
        end
      end
    end
  end
end
