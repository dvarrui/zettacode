namespace :devel do
  desc "Create launcher"
  task :launcher do
    puts "[INFO] Creating symbolic link into /usr/local/bin"
    basedir = File.join(File.dirname(__FILE__), "..")
    system("sudo ln -s #{basedir}/bin/zettacode /usr/local/bin/zettacode")
  end
end
