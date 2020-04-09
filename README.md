# Rubocop::TwoMongos

Convert Mongomapper usage to its comparable Mongoid syntax.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rubocop-two_mongos', require: false
```

And then execute:

    $ bundle install

## Usage

To be used as RuboCop extension.

in your rubocop file:

```yaml
require
  - rubocop-two_mongos

# already the default
TwoMongos/ToMongoidDocument:
  Enabled: true
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/fudanchii/rubocop-two_mongos.

