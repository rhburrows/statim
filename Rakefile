
desc "Run the tests"
task :test do
  roundup = File.join(File.dirname(__FILE__), "roundup")
  exec("#{roundup} test/quicki-test.sh")
end

task :default => :test
