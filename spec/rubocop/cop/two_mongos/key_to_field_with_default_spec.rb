# frozen_string_literal: true

RSpec.describe RuboCop::Cop::TwoMongos::KeyToFieldWithDefault, :config do
  subject(:cop) { described_class.new(config) }

  it 'registers an offense when using `key` syntax' do
    expect_offense(<<~RUBY)
      key :username, String, default: 'anon123'
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Use `field :column_name, type: ColumnType` syntax here.
    RUBY
  end

  it 'does not register an offense when using `field`' do
    expect_no_offenses(<<~RUBY)
      field :username, type: String
    RUBY
  end

  it 'autocorrect key with complex type to correct field syntax' do
    expect(autocorrect_source('key :user_name, String, default: "garnis"'))
      .to eq('field :user_name, type: String, default: "garnis"')
  end
end
