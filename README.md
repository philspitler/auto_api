# AutoApi

AutoApi generates a RESTful API on the fly.  If you call gets on items that do not exist, you get back what you'd expect if the object didn't exist.  If you POST to something, even if it doesn't exist, it will create it on the fly, which then can be retreived from the database.  It runs on Sinatra and MongoDB.

## Installation

Add this line to your application's Gemfile:

    gem 'auto_api'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install auto_api

## Usage

### Configure config.ru

Add the following to your config.ru file:

```ruby
require './auto_api.rb'

map '/api' do #can use whatever path or add version or anything since this is modular
  run AutoApi::Base
end
```

## Contributing

1. Fork it ( https://github.com/philspitler/auto_api/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
