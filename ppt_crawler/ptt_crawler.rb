# https://webptt.com/m.aspx?n=bbs/Beauty/index.html
require_relative './html_parser'

class PttCrawler 
    attr_accessor :offset, :range
    DEFAULT_OFFSET = 0
    DEFAULT_RANGE = 10

    def initialize(board = "Beauty")
        @range = DEFAULT_RANGE
        @offset = DEFAULT_OFFSET
        @board = board
        @page = HtmlParser.parse("https://webptt.com/m.aspx?n=bbs/#{board}/index.html")
    end

    def length
        @seed_length ||= @page.css('#action-bar-container')
                              .css('.btn-group-paging')
                              .css('.btn:nth-child(2)')[0]['href']
                              .gsub(/[^\d]/, '').to_i
    end

    def page_range
        start = length - offset
        ((start-range)..start).to_a
    end

    def pages
        @seed ||= page_range.map { |index| PageParser.new(pageUrl(index)) }
    end

    def pageUrl(index)
        "https://webptt.com/m.aspx?n=bbs/#{@board}/index#{index}.html"
    end
end

class PageParser < HtmlParser

    def posts
        @page.css('.r-ent').map do |postHTML| 
            post = PostParser.new(postHTML)
            post.base_url = uri
            post
        end
    end
end