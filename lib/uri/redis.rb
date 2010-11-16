require 'uri'
require 'redis'

module URI
  class Redis < URI::Generic
    VERSION = '0.4' unless defined?(URI::Redis::VERSION)
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
    
    def key
      return if self.path.nil?
      self.path ||= "/#{DEFAULT_DB}"
      self.path.split('/')[2..-1].join('/')
    end
    
    def key=(val)
      self.path = '/' << [db, val].join('/')
    end
    
    def db
      self.path ||= "/#{DEFAULT_DB}"
      (self.path.split('/')[1] || DEFAULT_DB).to_i
    end
    
    def db=(val)
      current_key = key
      self.path = "/#{val}"
      self.path << "/#{current_key}"
      self.path
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