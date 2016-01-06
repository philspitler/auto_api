# AutoApi
[![Gem Version](https://badge.fury.io/rb/auto_api.svg)](https://badge.fury.io/rb/auto_api)

AutoApi generates a RESTful API on the fly.  If you call gets on items that do not exist, you get back what you'd expect if the object didn't exist.  If you POST to something, even if it doesn't exist, it will create it on the fly, which then can be retreived from the database.  It runs on Sinatra and MongoDB.

## What this Provides
You just start calling endpoints and it just works.  It’s pretty useless if you start off by making GET requests.  You just get back empty arrays or 404s.  However, start storing anything you want at all and then when making GET reqeusts, you will received the appropriate objects.

AutoApi handles all the normal RESTful single level routes, for example:

```
GET /forums

GET /forums/asdf1234

POST /forums #forum created with reqeust.POST data

PUT /forums/asdf1234 #forum asdf1234 updated with request.POST data

DELETE /forums/asdf1234 #deletes forum asdf1234 (note: related data is not cleaned up at this point)

DELETE /forums #deletes ALL forums (note: related data is not cleaned up at this point)

```

AutoApi will handle nested calls for GET (list), POST, and DELETE (list) for example:

```
GET /forums/asdf1234/topics

POST /forums/asdf1234/topics #a new topic is created from request.POST and associated to forum asdf1234

DELETE /forums/asdf1234/topics #deletes all the topics for the forum (note: data related to the deleted topics is not cleaned up at this point)
```

Note: forums and topics are used it this example, but topics could have posts.  Or you could use this for user data or really whatever else you want a RESTful interface for.  I can see this being great for rapid front-end prototyping.

## Installation

Add this line to your application's Gemfile:

    gem 'auto_api'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install auto_api

## Requirements

    - Ruby
    - Sinatra
    - MongoDB

## Usage

### Config File

    - Rename config/mongoid.yml.example to config/mongoid.yml
    - Make whatever changes to the config file to work in your environment

### Configure config.ru

Add the following to your config.ru file:

```ruby
require 'auto_api'

map '/api' do #can use whatever path or add version or anything since this is modular
  run AutoApi::Base
end
```

## Roadmap

There are many things I see going into this in the future.  My first priorities are:

    - Destroy orphaned data in the database
    - Destroy objects that no longer contain data in the DB to free memory
    - Enable the ability to run in a “mock” environment which cleans up after every call.
    - Any other useful features that emerge as I developing and using it
    - note: requests are always welcome (especially pull requests)

## Warning

This is currently in a prototype/alpha phase.

## Tests / Specs (coming soon)

In order to get this out in the wild as soon as possible, I am pusing the prototype.  Full tests/specs are to come in the very near future.

## Contributing

1. Fork it ( https://github.com/philspitler/auto_api/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
