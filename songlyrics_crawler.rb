require 'nokogiri'
require 'open-uri'
require 'anemone'

url = 'http://www.songlyrics.com/'

Anemone.crawl(url) do |anemone|
  anemone.storage = Anemone::Storage.Redis
  page_count = 0
  song_count = 0
  anemone.focus_crawl do |page|
    page.links.select {|link| link.to_s.include?('songlyrics')}
  end
  anemone.on_every_page do |page|
    if page.doc && page.doc.css('#songLyricsDiv').any?
      page.doc.css('#songLyricsDiv').css('p').each do |line|
        if line.text.length
          f = File.open("song_lyrics.txt", "a+b")
          f.write(line.text)
        end
      end
        song_count +=1
    end
    page_count +=1
    puts "#{song_count} songs / #{page_count} pages"
  end
end
