require "./lib/artist.rb"
require "./lib/genre.rb"
require "./lib/song.rb"

songs_array = Dir.entries("data").select {|f| !File.directory? f}

def song_list(array)
	songs = []
	array.each do |song|
		#pull out name, artist, and genre variables
		split_song = song.split(" - ")
		song_artist = split_song[0]
		name_genre = split_song[1].split(" [")
		song_name = name_genre[0]
		song_genre = name_genre[1].chomp("].mp3")
		new_song = song_name.downcase.gsub(" ", "_")
		#create new song object
		songs << new_song = Song.new
		#add name to new song
		new_song.name = song_name

		#see if genre exits and make new genre
		genre_exists = false
		genre_exists(song_genre)
		song_genre = Genre.new unless genre_exists
		new_song.genre = song_genre

		#see if artist exists and make new artist
		artist_exists = false
		artist_exists(song_artist)
		song_artist = Artist.new unless artist_exists
		song_artist.add_song(new_song)
	end
end

def genre_exists(song_genre)
	Genre::GENRES.each do |genre|
		genre_exists = true if genre.name == song_genre
	end
end

def artist_exists(song_artist)
	Artist::ARTISTS.each do |artist|
		artist_exists = true if artist.name == song_artist
	end
end


p song_list(songs_array)