require "./lib/artist.rb"
require "./lib/genre.rb"
require "./lib/song.rb"

songs_array = Dir.entries("data").select {|f| !File.directory? f}

def song_list(array)
	array.each do |song|
		split_song = song.split(" - ")
		name = split_song[0]
		artist_genre = split_song[1].split(" [")
		artist = artist_genre[0]
		genre = artist_genre[1].chomp("].mp3")
	end
end

p song_list(songs_array)