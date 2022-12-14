require "colorize"
require "fileutils"
require_relative "../version"

module Zettacode
  module Parse
    def self.call(filepath)
      raw_content, folder = read_content_from filepath

      dirty_global = scrap_global_from raw_content
      global = clean_global dirty_global
      save_global global, to: folder

      dirty_examples = scrap_examples_from raw_content
      examples = clean_examples dirty_examples
      save_examples examples, to: folder
    end

    def self.echo(title, text)
      print title.rjust(12).colorize(:green)
      puts " #{text}"
    end

    def self.read_content_from(filepath, basefolder = Zettacode::BASEFOLDER)
      if File.directory? filepath
        echo "ERROR", "Can't parse directories!"
        exit 1
      elsif !File.exist?(filepath)
        echo "ERROR", "File not found!"
        exit 1
      end

      echo "Parsing", filepath
      content = File.read(filepath)
      title = /<title>([\w\s.-]+.[\w\s.-]+)<\/title>/
      name = title.match(content).captures.first
      name.tr!("/", ".")
      name.tr!(" ", "_")
      name.downcase!
      folder = File.join(basefolder, name)
      FileUtils.mkdir_p(folder) unless Dir.exist? folder
      [content, folder]
    end

    def self.scrap_examples_from(content)
      examples = []
      example = nil
      counter = 1
      lang = "unkown"
      section = :skip
      content.split("\n").each do |line|
        if line.start_with? "=={{header|"
          section = :code
          examples << example unless example.nil?
          lang = line
          counter = 1
          example = {lang: lang, code: [], index: counter}
        elsif line.downcase.start_with? "{{out}}"
          section = :skip
        elsif line.start_with? "=== "
          section = :code
          examples << example unless example.nil?
          counter +=1
          example = {lang: lang, code: [], index: counter}
        elsif section == :skip
          next
        elsif section == :code
          example[:code] << line
        else
          echo "ERROR", "XML malformed!"
        end
      end
      examples << example
      examples
    end

    def self.scrap_global_from(content)
      global = { task: nil, lines: [] }
      section = :skip
      content.split("\n").each do |line|
        if section == :skip && line.strip.start_with?("<text bytes=")
          section = :global
          global[:taks] = line.split(">")&.last
        elsif line.start_with? "=={{header|"
          section = :end
        elsif section == :global
          global[:lines] << line
        elsif section == :end
          next
        else
          echo "ERROR", "XML malformed!"
        end
      end
      global
    end

    def self.clean_global(dirty_global)
      dirty_global
    end

    def self.clean_examples(dirty_examples)
      examples = []
      dirty_examples.each do |example|
        # lang = /header\|([\w\d\s.\-_*\(\)]+)/.match(example[:lang])&.captures&.first
        lang = example[:lang][11, example[:lang].size - 15]
        filename = lang.tr(" ", "_").downcase
        filename.tr!("/", "-")
        if example[:index] > 1
          filename = "#{filename}_#{example[:index]}"
        end
        syntax = nil
        lines = example[:code]
        raw = lines.join("\n")

        # Clean syntaxhighlight tag
        lines.each do |line|
          next if line == ""
          # &lt;syntaxhighlight lang="LANG"&gt;
          filter = /&lt;syntaxhighlight\s+lang="([\w]+)"&gt;/
          value = filter.match(line)&.captures&.first
          unless value.nil?
            syntax = value
            line.gsub!("&lt;syntaxhighlight lang=\"#{value}\"&gt;", "")
          else
            line.gsub!("</text>", "")
            line.gsub!("</revision>", "")
            line.gsub!("</page>", "")
            line.gsub!("</mediawiki>", "")
            line = nil if line.strip.start_with? "<sha1>"
          end
        end

        code = lines.join("\n")
        code.gsub!("&amp;", "&")
        code.gsub!("&lt;/syntaxhighlight&gt;", "")
        code.gsub!("&lt;pre&gt;", "")
        code.gsub!("&lt;/pre&gt;", "")
        code.gsub!("&lt;", "<")
        code.gsub!("&gt;", ">")
        code.gsub!("&lt;code&gt;", "'")
        code.gsub!("&lt;/code&gt;", "'")
        examples << {
          lang: lang,
          filename: filename,
          syntax: syntax,
          code: code,
          raw: raw
        }
      end
      examples
    end

    def self.save_global(global, to: 'folder')
      true
    end

    def self.save_examples(examples, to: 'folder')
      folder = to
      examples.each do |example|
        filepath = File.join(folder, "#{example[:filename]}.txt")
        File.open(filepath, "w") { |file| file.write(example[:code]) }
      end
      echo "Folder", folder
      echo "Saving", "#{examples.size} files"
    end
  end
end
