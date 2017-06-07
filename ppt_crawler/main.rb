#! /usr/bin/env ruby
require_relative './ptt_crawler'

pttBeauty = PttCrawler.new("Beauty")
pages = pttBeauty.pages
posts = pages[0].posts

File.write('./data.json', posts.to_json)