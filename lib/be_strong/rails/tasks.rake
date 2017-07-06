namespace :be_strong do
  desc 'Apply strong parameter method and remove attr_accessible, attr_protected.'
  task convert: :environment do |task, args|
    result = case args.extras.count
    when 0
      BeStrong::Converter.convert()
    when 1
      BeStrong::Converter.convert(controller_path: args.extras.first)
    when 2
      BeStrong::Converter.convert(controller_path: args.extras.first, model_path: args.extras.last)
    else
      raise "Usage: rake be_strong:convert[controller_path,model_path]"
    end
    result[:applied].each {|file| puts "Apply strong parameter: #{file}"}
    result[:removed].each {|file| puts "Remove attr_[accessible|protected]: #{file}"}
  end
end
