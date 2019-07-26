require_relative 'list_and_grep/file_array'
require_relative 'list_and_grep/keyword_finder'
require_relative 'list_and_grep/version'

module ListAndGrep
  CONFIG_FILE = File.join(ENV['HOME'], '.lsgrc')
end

