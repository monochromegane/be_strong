module BeStrong
  class Converter
    def self.convert(controller_path: 'app/controllers', model_path: 'app/models')
      applied = StrongParameter.apply_all(controller_path)
      removed = AttrAccessible.remove_all(model_path)
      {applied: applied, removed: removed}
    end
  end
end
