module BeStrong
  class Converter
    def self.convert(controller_path: 'app/controllers', model_path: 'app/models')
      StrongParameter.apply_all(controller_path)
      AttrAccessible.remove_all(model_path)
    end
  end
end
