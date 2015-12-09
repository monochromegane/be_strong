module BeStrong
  class StrongParameterMethods
    def self.method_for(name)
      model = Model.new(name)
      permits = model.accessible_attributes.map{|attr| ":#{attr}"}.join(', ')
      permit_method = permits.present? ? ".permit(#{permits})" : ''

      <<-"EOS".strip_heredoc
        def #{name}_params
          params.require(:#{name})#{permit_method}
        end
      EOS
    rescue NameError
      nil
    end

    class Model
      def initialize(name)
        @klass = name.to_s.classify.constantize
      end

      def accessible_attributes
        accssible = @klass.accessible_attributes
        return accssible if accssible.size.nonzero?

        @klass.attribute_names - @klass.protected_attributes.to_a
      end
    end
  end
end
