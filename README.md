# Capistrano::Demo

Creating demo-host for git branch.

## Requirements/Restrictions
* git
* nginx
* unicorn

Allow deploy user restart server or run other command without sudo password

## Installation

Add this line to your application's Gemfile:

    gem 'capistrano-demo'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install capistrano-demo
    
In Capfile add line:

    require 'capistrano/demo'


## Usage

TODO: Write usage instructions here

## TODO
1. Database config
2. Nginx config
3. Unicorn config
4. 

## Contributing

1. Fork it ( https://github.com/[my-github-username]/capistrano-demo/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
