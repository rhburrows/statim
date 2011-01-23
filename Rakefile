
desc "Run the tests"
task :test do
  roundup = File.join(File.dirname(__FILE__), "roundup")
  system "#{roundup} test/*-test.sh"
end

desc "Simulate Ruby's autotest (requires filewatcher and growl)"
task :autotest do
  files = "*.sh test/*.sh"
  cmd = "./roundup test/*-test.sh | grep Tests: | growlnotify"
  system "filewatcher -i 1 \"#{files}\" \"#{cmd}\""
end

task :default => :test
