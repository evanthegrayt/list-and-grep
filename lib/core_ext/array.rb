# Extends the Array class.

class Array
  def reject_by_visibility(type)
    reject do |f|
      case type
      when 'all'    then %w(. ..).include?(f)
      when 'hidden' then !f.start_with?('.') || %w(. ..).include?(f)
      else  f.start_with?('.')
      end
    end
  end

  def select_by_filetype(mode)
    select do |f|
      case mode
      when 'executables'     then File.file?(f) && File.executable?(f)
      when 'non_executables' then File.file?(f) && !File.executable?(f)
      when 'files'           then File.file?(f)
      when 'directories'     then File.directory?(f)
      else true
      end
    end
  end

  def colorize(keyword, color)
    color ||= "\e[0;92m"
    map do |e|
      replace = e.match(/#{keyword}/i).to_s
      e.gsub(replace, "#{color}#{replace}\e[0m")
    end
  end
end

