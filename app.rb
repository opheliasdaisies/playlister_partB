require "./lib/artist.rb"
require "./lib/genre.rb"
require "./lib/song.rb"

songs_array = Dir.entries("data").select {|f| !File.directory? f}

def song_list(array)
	array.each do |song|
		split_song = song.split(" - ")
		song_artist = split_song[0]
		name_genre = split_song[1].split(" [")
		song_name = name_genre[0]
		song_genre = name_genre[1].chomp("].mp3")
		song_name = song_name.downcase.gsub(" ", "_")
	end
end

p song_list(songs_array)