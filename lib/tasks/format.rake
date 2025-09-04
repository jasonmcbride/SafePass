# lib/tasks/format.rake

require 'htmlbeautifier'

namespace :format do
  desc "Beautify all .erb files under app/views"
  task :erb do
    puts "Beautifying .erb files..."

    files = Dir.glob("app/views/**/*.erb")

    if files.empty?
      puts "No ERB files found."
      next
    end

    files.each do |file|
      begin
        original = File.read(file)
        formatted = HtmlBeautifier.beautify(original)

        if original != formatted
          File.write(file, formatted)
          puts "Formatted: #{file}"
        else
          puts "Skipped (already clean): #{file}"
        end
      rescue => e
        puts "Error formatting #{file}: #{e.message}"
      end
    end

    puts "Done."
  end
end
