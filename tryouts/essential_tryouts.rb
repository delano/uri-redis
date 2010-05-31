
library :'uri/redis', 'lib'
tryouts "Essentials" do
  
  dream [2, 'localhost', 6379]
  drill "Can parse a redis URI" do
    uri = URI.parse 'redis://localhost/2'
    [uri.db, uri.host, uri.port]
  end
  
end