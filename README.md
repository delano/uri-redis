# URI-Redis v1.3 (2024-06-15)

Creates a URI object for Redis URLs.

e.g.

    redis://host:port/dbindex

## Usage

```ruby
    require 'uri/redis'

    conf = URI.parse 'redis://localhost:4380/2'
    conf.scheme               # => "redis"
    conf.host                 # => localhost
    conf.port                 # => 4380
    conf.db                   # => 2
    conf.to_s                 # => redis://localhost:4380/2
```

### SSL Support

SSL is supported by using the `rediss` scheme. Note: SSL support is only available in Redis (Server) 6.0 and later and via redis-rb 4.7 and later.

```ruby
    require 'uri/redis'

    conf = URI.parse 'rediss://localhost:4380/2'
    conf.scheme               # => "rediss"
    conf.to_s                 # => rediss://localhost:4380/2
```


## Installation

Get it in one of the following ways:

* `gem install uri-redis`
* `git clone git@github.com:delano/uri-redis.git`


## About

* [Github](https://github.com/delano/uri-redis)


## License

See LICENSE.txt
