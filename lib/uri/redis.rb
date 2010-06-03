require 'uri'
require 'redis'

module URI
  class Redis < URI::Generic
    DEFAULT_PORT = 6379
    DEFAULT_DB = 0
    
    def self.build(args)
      tmp = Util::make_components_hash(self, args)
      return super(tmp)
    end
    
    def initialize(*arg)
      super(*arg)
    end
    
    def request_uri
      r = path_query
    end
    
    def db
      val = path.tr('/', '')
      val.empty? ? DEFAULT_DB : val.to_i
    end
    
    def db=(val)
      self.path = "/#{val}"
    end
    
    def conf
      tmp = {
        :host => host,
        :port => port,
        :db   => db
      }
      tmp[:password] = password if password
      tmp
    end
    
    def serverid
      'redis://%s:%s/%s' % [host, port, db]
    end
    
  end
  
  @@schemes['REDIS'] = Redis
end


class Redis
  def self.uri(conf={})
    URI.parse 'redis://%s:%s/%s' % [conf[:host], conf[:port], conf[:db]]
  end
  if defined?(Redis::VERSION) && Redis::VERSION >= "2.0.0"
    def uri
      URI.parse 'redis://%s:%s/%s' % [@client.host, @client.port, @client.db]
    end
  else
    class Client
      def uri
        URI.parse 'redis://%s:%s/%s' % [@host, @port, @db]
      end
    end
  end
end