#!/usr/bin/env ruby

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

  VERSION = 2.2
  RELEASE = 'May 2017'

  def initialize(opts)
    @opts = opts
  end

  def return_values
    if files.any?
      echo "Found when searching #{@opts[:type]} #{@opts[:mode]}:"
      @opts[:columnize] ? files.columnize(2) : (puts files)
    else
      echo "No '#{@opts[:keyword]}' not found!"
      exit 2
    end
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
        list.grep(/#{@opts[:keyword]}/)
      else
        list.grep(/#{@opts[:keyword]}/i)
      end
  end

  def list
    @list ||=
      Dir.entries('.').reject_by_visibility(@opts[:type]).
      select_by_filetype(@opts[:mode])
  end

end

