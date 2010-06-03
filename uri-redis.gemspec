@spec = Gem::Specification.new do |s|
  s.name = "uri-redis"
  s.rubyforge_project = 'uri-redis'
  s.version = "0.3.0"
  s.summary = "URI-Redis: support for parsing redis://host:port/dbindex"
  s.description = s.summary
  s.author = "Delano Mandelbaum"
  s.email = "delano@solutious.com"
  s.homepage = "http://github.com/delano/uri-redis"
  
  s.extra_rdoc_files = %w[README.rdoc LICENSE.txt CHANGES.txt]
  s.has_rdoc = true
  s.rdoc_options = ["--line-numbers", "--title", s.summary, "--main", "README.rdoc"]
  s.require_paths = %w[lib]
  
  # = MANIFEST =
  # git ls-files
  s.files = %w(
  CHANGES.txt
  LICENSE.txt
  README.rdoc
  Rakefile
  lib/uri/redis.rb
  tryouts/essential_tryouts.rb
  uri-redis.gemspec
  )

  
end
