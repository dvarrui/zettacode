namespace :devel do
  desc "Create launcher"
  task :launcher do
    puts "[INFO] Creating symbolic link into /usr/local/bin"
    basedir = File.join(File.dirname(__FILE__), "..")
    system("sudo ln -s #{basedir}/zettacode /usr/local/bin/zettacode")
    system("sudo ln -s /usr/local/bin/zettacode /usr/local/bin/zcode")
  end
end
