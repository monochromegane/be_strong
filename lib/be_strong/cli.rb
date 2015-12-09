module BeStrong
  class CLI
    def self.run(args = ARGV)
      new.run(args)
    end

    def run(args)
      Converter.convert
    end
  end
end
