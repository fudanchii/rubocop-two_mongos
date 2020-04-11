# frozen_string_literal: true

RSpec.describe RuboCop::Cop::TwoMongos::Proper::KeyWithAlias, :config do
  subject(:cop) { described_class.new(config) }

  it 'registers an offense when key used with abbr keyword' do
    expect_offense(<<~RUBY)
      key :username, String, abbr: :un
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Avoid abbr, field_name, and/or alias in mongomapper. It will need to be inverted in Mongoid.
    RUBY
  end

  it 'registers an offense when key used with alias keyword' do
    expect_offense(<<~RUBY)
      key :username, String, alias: :un
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Avoid abbr, field_name, and/or alias in mongomapper. It will need to be inverted in Mongoid.
    RUBY
  end

  it 'registers an offense when key used with field_name keyword' do
    expect_offense(<<~RUBY)
      key :username, String, field_name: :un
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Avoid abbr, field_name, and/or alias in mongomapper. It will need to be inverted in Mongoid.
    RUBY
  end

  it 'does not register an offense when key used with non alias keyword' do
    expect_no_offenses(<<~RUBY)
      key :username, String, default: 'jenova'
    RUBY
  end
end
