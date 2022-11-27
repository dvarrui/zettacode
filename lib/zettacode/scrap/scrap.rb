require "yaml"
require "httparty"
require "nokogiri"
require "debug"

module Zettacode
  class Scrap
    attr_reader :settings

    def initialize(filepath)
      @configpath = filepath
    end

    def load_settings
      puts "==> Loading settings (#{@configpath})"
      @settings = YAML.load(File.read(@configpath))
      # Show settings
      @settings.each_with_index do |problem, index|
        number = "%02d" % (index + 1)
        puts "    #{number} #{problem[:name]}: #{problem[:url]}"
      end
    end

    def find_langs
      # Scrap page
      @settings.each do |problem|
        # 1. Get page
        response = HTTParty.get(problem[:url])
        unless response.code == 200
          puts "==> httparty: [Error] #{response.code}"
          exit 1
        end

        # 2. Find every LANG (a href ="#LANG")
        langs = []
        document = Nokogiri::HTML(response.body)
        document.css("h2 > span").each do |e|
          id = e.attribute("id")
          langs << id unless id.nil?
        end
        puts "==> Problem: #{problem[:name]} (langs=#{langs.size})"
        puts langs.join("\n")

        langs = []
        elems = document.css("a")
        elems.each do |e|
          href = e.attribute("href")
          filter = /\/wiki\/Category:([\w\d.-_]+)/
          items = filter.match(href)&.captures
          langs << items.first unless items.nil?
        end
        puts "==> Problem: #{problem[:name]} (langs=#{langs.size})"
        puts langs.join("\n")
      end
    end
  end
end
