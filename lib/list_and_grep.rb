require 'yaml'

class Array
  def columnize(spacing = 2)
    n = self.max_by(&:length).length
    verbose_save, $VERBOSE = $VERBOSE, nil
    self.each_slice(`/usr/bin/env tput cols`.to_i / (n + spacing)) do |row|
      puts row.map { |e| "%-#{n}s" % e }.join(' ' * spacing)
    end
    $VERBOSE = verbose_save
  rescue => e
    puts "Couldn't columnize list due to #{e}. Printing in one column:"
    puts self
  end

  def reject_by_visibility(type)
    self.reject do |f|
      case type
      when 'all'    then %w(. ..).include?(f)
      when 'hidden' then !f.start_with?('.') || %w(. ..).include?(f)
      else  f.start_with?('.')
      end
    end
  end

  def select_by_filetype(mode)
    self.select do |f|
      case mode
      when 'executables'     then File.file?(f) && File.executable?(f)
      when 'non-executables' then File.file?(f) && !File.executable?(f)
      when 'files'           then File.file?(f)
      when 'directories'     then File.directory?(f)
      else  File.exist?(f)
      end
    end
  end
end

class ListAndGrep

  VERSION =  2.3
  RELEASE = 'October 2018'

  def initialize(keyword, opts)
    @keyword = keyword
    @opts    = opts
    @config  = YAML.load_file(
      File.join(File.dirname(__FILE__), '..', 'config', 'config.yml'))
    @config['use_color'] = @opts[:use_color] if @opts.key?(:use_color)
    @config['match_color'] = "\e[0m" unless @config['use_color']
  end

  def return_values
    unless files.any?
      echo "'#{@config[:error_color]}#{@keyword}\e[0m' not found!"
      return
    end
    echo "Found when searching #{@opts[:type]} #{@opts[:mode]}:"
    @opts[:columnize] ? files.columnize(2) : (puts colorize(files))
  end

  private

  def conflict_msg(flags)
    "Can't use the following flags together: #{flags.inspect}\n#{::USAGE}"
  end

  def echo(str)
    puts str if @opts[:verbose]
  end

  def files
    @files ||=
      if @opts[:match]
        list.grep(/#{@keyword}/)
      else
        list.grep(/#{@keyword}/i)
      end
  end

  def colorize(array)
    array.map do |e|
      replace = e.match(/#{@keyword}/i).to_s
      e.gsub(replace, "#{@config['match_color']}#{replace}\e[0m")
    end
  end

  def list
    @list ||=
      Dir.entries('.').reject_by_visibility(@opts[:type]).
      select_by_filetype(@opts[:mode])
  end

end

