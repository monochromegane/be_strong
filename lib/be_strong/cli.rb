module BeStrong
  class CLI
    def self.run(args = ARGV)
      new.run(args)
    end

    def run(args)
      result = Converter.convert
      result[:applied].each{|file| puts "Apply strong parameter: #{file}"}
      result[:removed].each{|file| puts "Remove attr_[accessible|protected]: #{file}"}
      result
    end
  end
end
