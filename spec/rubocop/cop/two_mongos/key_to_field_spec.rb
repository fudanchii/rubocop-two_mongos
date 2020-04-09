# frozen_string_literal: true

RSpec.describe RuboCop::Cop::TwoMongos::KeyToField, :config do
  subject(:cop) { described_class.new(config) }

  it 'registers an offense when using `key` syntax' do
    expect_offense(<<~RUBY)
      key :username, String
      ^^^^^^^^^^^^^^^^^^^^^ Please use field syntax here.
    RUBY
  end

  it 'does not register an offense when using `field`' do
    expect_no_offenses(<<~RUBY)
      field :username, type: String
    RUBY
  end

  it 'autocorrect `key` to `field` syntax' do
    expect(autocorrect_source('key :username, String'))
      .to eq('field :username, type: String')
  end

  it 'autocorrect key with complex type to correct field syntax' do
    expect(autocorrect_source('key :user_id, BSON::ObjectId'))
      .to eq('field :user_id, type: BSON::ObjectId')
  end
end
