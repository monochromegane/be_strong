module BeStrong
  class Code
    REG_MASS_ASSIGNMENT_METHOD = /(new|build|build_.*|update|update!|assign_attributes|update_attributes|update_attributes!)([\( )])params\[:(\w*)\]/

    def initialize(code)
      @code = code
    end

    def apply_strong_parameter!
      # replace params[:model] to model_params
      models = []
      code.gsub!(REG_MASS_ASSIGNMENT_METHOD) do
        models << $3
        "#{$1}#{$2}#{$3}_params"
      end

      return code if models.size.zero?

      # add private section
      add_private!

      # add model_params method as private method
      models.each do |model|
        method = StrongParameterMethods.method_for(model)
        next unless method

        next if code.include?("def #{model}_params")

        code.sub!(/^  private$/) do
          "  private\n\n#{method.gsub(/^/, '  ').chomp}"
        end
      end

      code
    end

    def add_private!
      if code.include?('private')
        code
      else
        code.sub!(/^end/) do
          "\n  private\nend"
        end
      end
    end

    def remove_attr_accessible!
      code.gsub!(/( *attr_accessible\(.*?\)$)/m, '')
      code.gsub!(/( *attr_accessible.+?[^,]$)/m, '')
      code
    end

    private

    def code
      @code
    end
  end
end
