BDB_SPEC = Gem::Specification.new do |s|
    s.platform  =   Gem::Platform::RUBY
    s.required_ruby_version = '>=1.8.4'
    s.name      =   "bdb"
    s.version   =   "0.0.2"
    s.authors   =  ["Moustafa Emara", "Muhammed Ali", "Matt Bauer", "Dan Janowski"]
    s.email     =  "moustafa.emara@espace.com.eg"
    s.summary   =   "A Ruby interface to BerkeleyDB"
    s.files     =   ['bdb.gemspec',
                     'ext/bdb.c',
                     'ext/bdb.h',
                     'ext/extconf.rb',
                     'lib/berkeleydb.rb',
                     'lib/btree.rb',
                     'lib/hash_table.rb',
                     'lib/queue.rb',
                     'lib/btree_index.rb',
                     'lib/model.rb',
                     'LICENSE',
                     'README.textile',
                     'Rakefile']
    s.test_files =  ['test/cursor_test.rb',
                     'test/db_test.rb',
                     'test/env_test.rb',
                     'test/stat_test.rb',
                     'test/test_helper.rb',
                     'test/txn_test.rb']
    s.extensions = ["ext/extconf.rb"]
 
    s.homepage = "http://github.com/mattbauer/bdb"
 
    s.require_paths = ["lib", "ext"]
    s.has_rdoc      = false
end
