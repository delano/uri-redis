

require "uri"
require "redis"

# URI::Redis - adds support for Redis URIs to core.
module URI
  # Redis URI
  #
  # This is a subclass of URI::Generic and supports the following URI formats:
  #
  #   redis://host:port/dbindex
  #
  # @example
  #   uri = URI::Redis.build(host: "localhost", port: 6379, db: 2, key: "v1:arbitrary:key")
  #   uri.to_s #=> "redis://localhost:6379/2/v1:arbitrary:key"
  #
  #   uri = URI::Redis.build(host: "localhost", port: 6379, db: 2)
  #   uri.to_s #=> "redis://localhost:6379/2"
  class Redis < URI::Generic
    DEFAULT_PORT = 6379
    DEFAULT_DB = 0

    def self.build(args)
      tmp = Util.make_components_hash(self, args)
      super(tmp)
    end

    def request_uri
      path_query
    end

    def key
      return if path.nil?

      self.path ||= "/#{DEFAULT_DB}"
      (self.path.split("/")[2..] || []).join("/")
    end

    def key=(val)
      self.path = "/" << [db, val].join("/")
    end

    def db
      self.path ||= "/#{DEFAULT_DB}"
      (self.path.split("/")[1] || DEFAULT_DB).to_i
    end

    def db=(val)
      current_key = key
      self.path = "/#{val}"
      self.path << "/#{current_key}"
      self.path
    end

    # Returns a hash suitable for sending to Redis.new.
    # The hash is generated from the host, port, db and
    # password from the URI as well as any query vars.
    #
    # e.g.
    #
    #      uri = URI.parse "redis://127.0.0.1/6/?timeout=5"
    #      uri.conf
    #        # => {:db=>6, :timeout=>"5", :host=>"127.0.0.1", :port=>6379}
    #
    def conf
      hsh = {
        host: host,
        port: port,
        db: db
      }.merge(parse_query(query))
      hsh[:password] = password if password
      hsh
    end

    def serverid
      format("redis://%s:%s/%s", host, port, db)
    end

    private

    # Based on: https://github.com/chneukirchen/rack/blob/master/lib/rack/utils.rb
    # which was originally based on Mongrel
    def parse_query(query, delim = nil)
      delim ||= "&;"
      params = {}
      (query || "").split(/[#{delim}] */n).each do |p|
        k, v = p.split("=", 2).map { |str| str } # NOTE: uri_unescape
        k = k.to_sym
        if (cur = params[k])
          if cur.instance_of?(Array)
            params[k] << v
          else
            params[k] = [cur, v]
          end
        else
          params[k] = v
        end
      end
      params
    end
  end

  register_scheme "REDIS", Redis
end

# Adds a URI method to Redis
class Redis
  def self.uri(conf = {})
    URI.parse format("redis://%s:%s/%s", conf[:host], conf[:port], conf[:db])
  end
  if defined?(Redis::VERSION) && Redis::VERSION >= "2.0.0"
    def uri
      URI.parse format("redis://%s:%s/%s", @client.host, @client.port, @client.db)
    end
  else
    # Redis < 2.0.0
    class Client
      def uri
        URI.parse format("redis://%s:%s/%s", @host, @port, @db)
      end
    end
  end
end
