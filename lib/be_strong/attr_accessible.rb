module BeStrong
  class AttrAccessible
    class << self
      def remove_all(dir)
        files = []
        Dir.glob(File.join(dir, '**/*.rb')).each do |file|
          removed = remove(file)
          files << file if removed
        end
        files
      end

      def remove(file)
        buf  = File.open(file, 'r'){|f| f.read}
        code = Code.new(buf).remove_attr_accessible!
        return false unless code.changed?

        File.open(file, 'w'){|f| f.puts(code.to_str)}
        true
      end
    end
  end
end
