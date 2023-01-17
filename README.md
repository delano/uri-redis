# URI-Redis v1.0-RC1

Creates a URI object for Redis URLs.

e.g.

    redis://host:port/dbindex

## Usage
**
    require 'uri/redis'

    conf = URI.parse 'redis://localhost:4380/2'
    conf.host                 # => localhost
    conf.port                 # => 4380
    conf.db                   # => 2
    conf.to_s                 # => redis://localhost:4380/2
    conf
**
## Installation

Get it in one of the following ways:

* `gem install uri-redis`
* `git clone git+ssh://github.com/delano/uri-redis.git`


## About

* [Github](https://github.com/delano/uri-redis)


## Credits

* delano (https://delanotes.com/)


## License

See LICENSE.txt
