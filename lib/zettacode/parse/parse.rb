require "colorize"
require "fileutils"
require "debug"

module Zettacode
  module Parse
    def self.echo(title, text)
      print title.rjust(12).colorize(:green)
      puts " #{text}"
    end

    def self.call(filepath)
      content, name = read_content_from filepath
      dirty_examples = scrap_examples_from content
      clean_examples = clean dirty_examples
      save_files_to name, clean_examples
    end

    def self.read_content_from(filepath)
      unless File.exist?(filepath)
        echo "ERROR", "File not found! (#{filepath})"
        exit 1
      end

      echo "Parsing", filepath
      content = File.read(filepath)
      title = /<title>([\w\d\s._-]+.[\w\d\s._-]+)<\/title>/
      name = title.match(content).captures.first
      name.tr!("/", ".")
      name.tr!(" ", "_")
      name.downcase!
      folder = File.join("data", name)
      FileUtils.mkdir(folder) unless Dir.exist? folder
      [content, name]
    end

    def self.scrap_examples_from(content)
      examples = []
      example = nil
      skip = true
      content.split("\n").each do |line|
        if line.start_with? "=={{header|"
          skip = false
          examples << example unless example.nil?
          example = {lang: line, code: []}
        elsif line.downcase.start_with? "{{out}}"
          skip = true
          next
        elsif skip
          next
        else
          example[:code] << line
        end
      end
      examples << example
      examples
    end

    def self.clean(dirty_examples)
      examples = []
      dirty_examples.each do |example|
        # lang = /header\|([\w\d\s.\-_*\(\)]+)/.match(example[:lang])&.captures&.first
        lang = example[:lang][11, example[:lang].size - 15]
        filename = lang.tr(" ", "_").downcase
        filename.tr!("/", "-")
        syntax = nil
        lines = example[:code]
        raw = lines.join("\n")

        # Clean syntaxhighlight tag
        lines.each do |line|
          # &lt;syntaxhighlight lang="LANG"&gt;
          filter = /&lt;syntaxhighlight\s+lang="([\w\d]+)"&gt;/
          value = filter.match(line)&.captures&.first
          unless value.nil?
            syntax = value
            line.gsub!("&lt;syntaxhighlight lang=\"#{value}\"&gt;", "")
          else
            line.tr!("</text>", "")
            line.tr!("</revision>", "")
            line.tr!("</page>", "")
            line.tr!("</mediawiki>", "")
            line = nil if line.strip.start_with? "<sha1>"
          end
        end

        code = lines.join("\n")
        code.tr!("&lt;/syntaxhighlight&gt;", "")
        code.tr!("&lt;pre&gt;", "")
        code.tr!("&lt;/pre&gt;", "")
        code.tr!("&lt;", "<")
        code.tr!("&gt;", ">")
        examples << {
          lang: lang,
          filename: filename,
          syntax: syntax,
          code: code,
          raw: raw }
      end
      examples
    end

    def self.save_files_to(name, examples)
      folder = File.join("data", name)
      examples.each do |example|
        filepath = File.join(folder, "#{example[:filename]}.txt")
        File.open(filepath, 'w') { |file| file.write(example[:code]) }
      end
      echo "Folder", folder
      echo "Saving", "#{examples.size} files"
    end
  end
end
