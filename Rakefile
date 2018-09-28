EXECUTABLE = File.join('/', 'usr', 'local', 'bin', 'lsg')
INSTALL_PATH = File.expand_path(File.join(__dir__), '..')

desc "Install to `/usr/local/bin`"
task :install do
  File.open(EXECUTABLE, 'w+') do |file|
    file.write("#!/usr/bin/env bash\n")
    file.write("ruby #{INSTALL_PATH}/bin/lsg $@\n")
  end
  File.chmod(0755, EXECUTABLE)
end

desc "Uninstall..."
task :uninstall do
  File.delete(EXECUTABLE) if File.file?(EXECUTABLE)
end

desc "Tagging and pulling from master"
task :update do
  sh("git tag #{Time.now.strftime('%Y-%m-%d-%H%M')}")
  sh("git pull origin master")
end

desc "Checking out last deployment tag"
task :rollback do
  tags = `git tag`.strip.split("\n")
  sh("git checkout #{tags.last}")
end

