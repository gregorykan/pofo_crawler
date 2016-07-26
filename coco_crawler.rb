require 'nokogiri'
require 'open-uri'
require 'anemone'

url = 'http://coconutpoetry.org/cover19.html'

Anemone.crawl(url) do |anemone|
  page_count = 0
  poem_count = 0
  anemone.focus_crawl do |page|
    page.links.select {|link| link.to_s.include?('coconutpoetry')}
  end
  # anemone.on_every_page do |page|
  #   puts page.doc
  #   # if page.doc && page.doc.css('.poem').any?

  #   #   poem = page.doc.css('.poem').css('div')
  #   #     poem.each do |line|
  #   #       if line.text.length
  #   #         line_with_break = line.text + "\n"
  #   #         f = File.open("output.txt", "a+b")
  #   #         f.write(line_with_break)
  #   #       end
  #   #     end
  #   #     poem_count +=1
  #   # end
  #   page_count +=1
  #   puts "#{poem_count} poems / #{page_count} pages"
  # end
end