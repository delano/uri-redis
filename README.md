# URI-Redis v1.1.0 (2024-04-04)

Creates a URI object for Redis URLs.

e.g.

    redis://host:port/dbindex

## Usage

```ruby
    require 'uri/redis'

    conf = URI.parse 'redis://localhost:4380/2'
    conf.host                 # => localhost
    conf.port                 # => 4380
    conf.db                   # => 2
    conf.to_s                 # => redis://localhost:4380/2
    conf
```


## Installation

Get it in one of the following ways:

* `gem install uri-redis`
* `git clone git+ssh://github.com/delano/uri-redis.git`


## About

* [Github](https://github.com/delano/uri-redis)


## License

See LICENSE.txt
