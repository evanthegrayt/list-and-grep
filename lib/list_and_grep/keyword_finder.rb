require 'yaml'

module ListAndGrep
class KeywordFinder

  attr_reader :keyword

  def initialize(keyword, opts = {})
    @keyword = keyword
    @opts = File.exist?(CONFIG_FILE) ? YAML.load_file(CONFIG_FILE) : {}
    @opts.merge!(opts)
    @opts['use_color'] ||= false
  end

  def matches
    return unless matched_files.any?
    return matched_files unless opts['use_color']
    matched_files.colorize(keyword, opts['color'])
  end

  private

  def matched_files
    @matched_files ||= files_by_type.select do |e|
      match? ? e.downcase.include?(keyword.downcase) : e.include?(keyword)
    end
  end

  def files_by_type
    @files_by_type ||= Dir.entries('.').
      reject_by_visibility(opts['type']).
      select_by_filetype(opts['mode'])
  end

  def opts
    @opts
  end

  def match?
    @opts['match']
  end

end
end

