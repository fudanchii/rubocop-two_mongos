# frozen_string_literal: true

RSpec.describe RuboCop::Cop::TwoMongos::ToMongoidDocument, :config do
  subject(:cop) { described_class.new(config) }

  it 'registers an offense when for `include MongoMapper:Document`' do
    expect_offense(<<~RUBY)
      include MongoMapper::Document
              ^^^^^^^^^^^^^^^^^^^^^ Use `Mongoid::Document` here.
    RUBY
  end

  it 'does not register any offenses for other include' do
    expect_no_offenses(<<~RUBY)
      include MongoMapper::Plugins::Quipper::EmailConfirmable
      include Schema::Shared::MediaCacheMethods
    RUBY
  end

  it 'autocorrect `MongoMapper::Document` to `Mongoid::Document` ' do
    expect(autocorrect_source('include MongoMapper::Document'))
      .to eq('include Mongoid::Document')
  end
end
