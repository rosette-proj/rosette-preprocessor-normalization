[![Build Status](https://travis-ci.org/rosette-proj/rosette-preprocessor-normalization.svg)](https://travis-ci.org/rosette-proj/rosette-preprocessor-normalization) [![Code Climate](https://codeclimate.com/github/rosette-proj/rosette-preprocessor-normalization/badges/gpa.svg)](https://codeclimate.com/github/rosette-proj/rosette-preprocessor-normalization) [![Test Coverage](https://codeclimate.com/github/rosette-proj/rosette-preprocessor-normalization/badges/coverage.svg)](https://codeclimate.com/github/rosette-proj/rosette-preprocessor-normalization/coverage)

rosette-preprocessor-normalization
====================

Normalizes text for the Rosette internationalization platform using the [Unicode normalization algorithm](http://unicode.org/reports/tr15/).

## Installation

`gem install rosette-preprocessor-normalization`

Then, somewhere in your project:

```ruby
require 'rosette/preprocessors/normalization-preprocessor'
```

### Introduction

This library is generally meant to be used with the Rosette internationalization platform that extracts translatable phrases from git repositories. rosette-preprocessor-normalization is capable of running the Unicode normalization algorithm over translations before they are serialized.

### Usage with rosette-server

Let's assume you're configuring an instance of [`Rosette::Server`](https://github.com/rosette-proj/rosette-server). Adding normalization pre-processor support would cause your configuration to look something like this:

```ruby
# config.ru
require 'rosette/core'
require 'rosette/serializer/json-serializer'
require 'rosette/extractors/json-extractor'

rosette_config = Rosette.build_config do |config|
  config.add_repo('my_awesome_repo') do |repo_config|
    repo_config.add_serializer('json/key-value') do |serializer_config|
      serializer_config.add_preprocessor('normalization') do |pre_config|
        pre_config.set_normalization_form(:nfc)
      end
    end
  end
end

server = Rosette::Server::ApiV1.new(rosette_config)
run server
```

Supported normalization forms are `:nfc`, `:nfd`, `:nfkc`, and `:nfkd`. See [Unicode Technical Report 15](http://unicode.org/reports/tr15/) for more information.

It may not be immediately obvious why normalization is important, especially because in most cases normalization does not have any visual effect on translation text. Normalization works behind the scenes by ensuring that accents, composed characters (eg. Korean Hangul), etc follow a common form. For example, the character "ñ" can be expressed using one or two Unicode code points. Normalization form NFC combines the "n" character and the "˜" accent into a single codepoint (`0xF1`), while normalization form NFD separates them into distinct codepoints (`0x6E` and `0x303`). Most visual display systems (eg. browsers, terminals, etc) will display both the same way, making the two forms visually indistinguishable. Normalization comes in handy, for example, when you need to compare two strings or use them to build a search index. In the Ruby programming language, the strings `"\u00F1"` and `"\u006E\u0303"` are not eqivalent, although visually they look identical.

## Requirements

This project must be run under jRuby. It uses [expert](https://github.com/camertron/expert) to manage java dependencies via Maven. Run `bundle exec expert install` in the project root to download and install java dependencies.

## Running Tests

`bundle exec rake` or `bundle exec rspec` should do the trick.

## Authors

* Cameron C. Dutro: http://github.com/camertron
