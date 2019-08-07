require_relative 'list_and_grep/keyword_finder'
require_relative 'list_and_grep/version'

##
# Core extension files. Every *.rb file in this directory will be required.
Dir.glob(File.join(File.dirname(__FILE__), 'core_ext', '*.rb')).each do |file|
  require file
end

##
# Set up module and constants. Identify the config file.
module ListAndGrep
  CONFIG_FILE = File.join(ENV['HOME'], '.lsgrc')
end

