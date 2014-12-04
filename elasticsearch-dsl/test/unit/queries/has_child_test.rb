require 'test_helper'

module Elasticsearch
  module Test
    module Queries
      class HasChildTest < ::Test::Unit::TestCase
        include Elasticsearch::DSL::Search::Queries

        context "HasChild query" do
          subject { HasChild.new }

          should "be converted to a Hash" do
            assert_equal({ has_child: {} }, subject.to_hash)
          end

          should "have option methods" do
            subject = HasChild.new

            subject.type 'bar'
            subject.query 'bar'
            subject.score_mode 'bar'
            subject.min_children 'bar'
            subject.max_children 'bar'

            assert_equal %w[ max_children min_children query score_mode type ],
                         subject.to_hash[:has_child].keys.map(&:to_s).sort
            assert_equal 'bar', subject.to_hash[:has_child][:type]
          end

          should "take a block" do
            subject = HasChild.new do
              type 'bar'
              query match: { foo: 'bar' }
            end
            assert_equal({ has_child: { type: 'bar', query: { match: { foo: 'bar' } } } }, subject.to_hash)
          end

          should "take a block for option method" do
            subject = HasChild.new do
              type 'bar'
              query do
                match :foo do
                  query 'bar'
                end
              end
            end
            assert_equal({ has_child: { type: 'bar', query: { match: { foo: { query: 'bar'} } } } }, subject.to_hash)
          end
        end
      end
    end
  end
end
