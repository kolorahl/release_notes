if ARGV.length != 2
  puts "Must supply two arguments: previous release commit and current release commit, in that order."
  exit(1)
end

class Changes
  attr_reader :added, :deleted, :modified

  def initialize(changes)
    @added    = []
    @deleted  = []
    @modified = []
    if (changes.is_a?(String))
      parse_string(changes)
    elsif (changes.respond_to?(:each))
      parse(changes)
    else
      puts "Changes must be passed in as a string or an enumerable structure that supports :each."
      exit(2)
    end
  end

  def list_to_lines(list, prefix='*')
    list.map do |element|
      "#{prefix} #{element}"
    end.join("\n")
  end

  def to_s
    add = list_to_lines(@added, '  +')
    mod = list_to_lines(@modified, '  *')
    del = list_to_lines(@deleted, '  -')
    "Added:\n#{add}\n\nModified:\n#{mod}\n\nDeleted:\n#{del}"
  end

  private

  def parse(changes)
    changes.each do |change|
      parts = /^\s*([AMD])\s+(.+)$/.match(change)
      if parts.nil?
        puts "Unrecognized format: #{change}"
      else
        if parts[1] == 'A'
          @added << parts[2]
        elsif parts[1] == 'M'
          @modified << parts[2]
        elsif parts[1] == 'D'
          @deleted << parts[2]
        end
      end
    end
  end

  def parse_string(changes)
    parse(changes.split("\n"))
  end
end

prev = ARGV[0]
curr = ARGV[1]

summary = `git shortlog #{prev}..#{curr} --no-merges`
changes = Changes.new(`git diff --name-status #{prev}..#{curr}`)

puts "#{summary}\n#{changes}\n"
