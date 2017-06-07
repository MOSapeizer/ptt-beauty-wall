require 'nokogiri'
require 'open-uri'
require 'uri'
require_relative './post_parser'

class HtmlParser
    attr_accessor :uri

    def initialize(url)
        @uri = URI(url)
        @page = parse(url)
    end

    def parse(url)
        rawHTML = open(url)
        Nokogiri::HTML(rawHTML)
    end

    def self.parse(url)
        Nokogiri::HTML(open(url))
    end

    def uri
        "#{@uri.scheme}://#{@uri.host}"
    end
end