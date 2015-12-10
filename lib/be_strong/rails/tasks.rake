namespace :be_strong do
  desc 'Apply strong parameter method and remove attr_accessible, attr_protected.'
  task convert: :environment do
    result = Converter.convert
    result[:applied].each{|file| puts "Apply strong parameter: #{file}"}
    result[:removed].each{|file| puts "Remove attr_[accessible|protected]: #{file}"}
  end
end
