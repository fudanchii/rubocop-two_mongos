# Rubocop::TwoMongos [![Build Status](https://travis-ci.com/fudanchii/rubocop-two_mongos.svg?branch=master)](https://travis-ci.com/fudanchii/rubocop-two_mongos)

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

There are 2 kind of cops: `TwoMongos/Proper/*` and `TwoMongos/*`, the `Proper` cops were meant to catch _unproper_ usage of MongoMapper and will recommend the proper one if possible, this will make conversion to Mongoid more feasible.

in your rubocop file:

```yaml
require
  - rubocop-two_mongos

# already the default
# see config/default.yml for all cops list
TwoMongos/ToMongoidDocument:
  Enabled: true

TwoMongos/KeyToField:
  Enabled: true
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/fudanchii/rubocop-two_mongos.

