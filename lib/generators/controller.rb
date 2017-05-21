require "fileutils"
require "active_support/inflector"

class Controller
	class << self
		def generate_from_template name
			file_path = File.join(File.dirname(__FILE__), "../templates/controllers/api/template_controller.rb.txt")
	    template = File.read(file_path)
	    name = name.singularize.downcase
	    template.gsub! "{{name}}", "#{name}"
	    template.gsub! "{{name_c}}", "#{name.capitalize}"
	    template.gsub! "{{name_p}}", "#{name.pluralize}"
	    template.gsub! "{{name_cp}}", "#{name.capitalize.pluralize}"

	    File.open("app/controllers/api/#{name.pluralize}_controller.rb", "w") do |f|
	      f.write(template)
	    end
		end
	end
end
