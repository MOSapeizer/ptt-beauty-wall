require 'uri'
require 'json'
require 'nokogiri'

class PostParser
    attr_accessor :base_url

    def initialize(postHTML)
        @post = postHTML
        @base_url = "."
    end

    def score
        @score ||= @post.css('.nrec').text
    end

    def titleText
        @titleText ||= @post.css('.title a').text
    end

    def tag
        @tag ||= titleText.split(" ").first.to_s
    end

    def title
        @title ||= titleText.sub(tag, "").strip
    end

    def url
        @url ||= @post.css('.title a')
                      .inject("") { |s, c| s + c['href'] }
        @url.gsub(/^\./, @base_url)
    end

    def timestamp
        @timestamp ||= @post.css('.date').text
    end

    def author
        @author ||= @post.css('.author').text
    end

    def images
        @images ||= PostImagesParser.new(url).images
    end

    def to_json(*a)
        to_h.to_json(*a)
    end

    def to_h
        {
            score: score,
            tag: tag,
            title: title,
            url: url,
            timestamp: timestamp,
            author: author,
            images: images
        }
    end
end

module URI
class HTTP
    def isImage?
        Net::HTTP.start(host, port) do |http|
            return http.head(request_uri)['Content-Type']
                       .start_with? 'image'
        end
    end
end
end

class PostImagesParser
    def initialize(url)
        puts "parse #{url}"
        getHTML(url) unless url.strip.empty?
    end

    def getHTML(url)
        rawHTML = open(url)
        @uri = URI(url)
        @page = Nokogiri::HTML(rawHTML) 
    end

    def images
        page.css('#main-content > a')
            .map { |a| a['href'] }
            # .select { |imageURL| URI(imageURL).isImage? }
    end

    private
    def page
        @page || Nokogiri::HTML("")
    end
end
