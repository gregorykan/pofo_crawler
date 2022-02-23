require 'nokogiri'
require 'open-uri'
require 'anemone'

url = 'http://www.poetryfoundation.org/'

Anemone.crawl(url) do |anemone|
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
            puts line.text
          end
        end
        poem_count +=1
    end
    page_count +=1
    puts "#{poem_count} poems / #{page_count} pages"
    # puts "Poem count #{poem_count}"
    # puts "Page count: #{page_count}"

    # if page.doc && page.doc.css('#poem div.poem') && page.doc.css('#poem div.poem').css('div') && !page.url.to_s.include?('poetrymagazine')
    #   poem = page.doc.css('#poem div.poem').css('div')
    #   poem.each do |line|
    #     if line.text.length < 100 && (line.text.include? 'water')
    #       puts line.text
    #     end
    #   end
    # end

  end
end