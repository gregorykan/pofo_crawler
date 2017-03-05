require 'nokogiri'
require 'open-uri'
require 'anemone'

url = 'http://www.poetryfoundation.org/'

Anemone.crawl(url) do |anemone|
  anemone.storage = Anemone::Storage.Redis
  page_count = 0
  poem_count = 0
  anemone.focus_crawl do |page|
    page.links.select {|link| link.to_s.include?('poetryfoundation')}
  end
  anemone.on_every_page do |page|
    if page.doc && page.doc.css('.poem').any?

      poem = page.doc.css('.poem').css('div')
        poem.each do |line|
          if line.text.length
            f = File.open("poems.txt", "a+b")
            f.write(line.text)
          end
        end
        poem_count +=1
    end
    page_count +=1
    puts "#{poem_count} poems / #{page_count} pages"
  end
end
