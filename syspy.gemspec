Gem::Specification.new do |gem|
  gem.name    = "syspy"
  gem.version = "0.0.32"
  gem.date    = Date.today.to_s

  gem.summary = "Captures TDS (Sybase / MSSQL) packages directly from a network interface."

  gem.description = File.open(File.join(File.dirname(__FILE__),"README.md")).read()

  gem.authors  = ["Matthias Balmer"]
  gem.email    = "mbalmer@smss.ch"
  gem.homepage = "https://github.com/balmma/syspy"
  
  gem.add_dependency("bindata")

  # ensure the gem is built out of versioned files
  gem.files = Dir["lib/**/*","bin/*"]
   
  gem.bindir       = 'bin' 
  gem.executables = ["syspy"]
  gem.has_rdoc = false
  gem.post_install_message = "To use syspy as standalone application run \"sudo syspy <interface> <destination_ip> <destination_port>\"" 
end