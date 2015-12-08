module BeStrong
  class StrongParameterMethods
    def self.method_for(name)
      model = name.to_s.classify.constantize
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
  end
end
