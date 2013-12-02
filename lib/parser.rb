class Parser
	attr_accessor :songs_array, :songs

	def initialize(dir)
		@songs_array = Dir.entries(dir).select {|f| !File.directory? f}
		@songs = []
	end

	def song_list
		songs_array.each do |song|
			song_artist = get_artist(song)
			song_name = get_name(song)
			song_genre = get_genre(song)
			new_song = create_song(song_name)		
			songs << new_song
			new_genre = return_or_create_genre(song_genre)
			new_artist = return_or_create_artist(song_artist)
			new_song.genre = new_genre
			new_song.artist = new_artist
			new_artist.add_song(new_song)
		end
		songs
	end


	def get_artist(song)
		split_song = song.split(" - ")
		split_song[0]
	end

	def get_name(song)
		split_song = song.split(" - ")
		split_song[1].split(" [")[0]
	end

	def get_genre(song)
		split_song = song.split(" - ")
		split_song[1].split(" [")[1].chomp("].mp3")
	end

	def create_song(song)
		new_song = Song.new
		new_song.name = song
		new_song
	end

	def return_or_create_genre(genre_name)
		Genre.all.each do |genre|
			return genre if genre.name == genre_name
		end
		new_genre = Genre.new
		new_genre.name = genre_name
		new_genre
	end

	def return_or_create_artist(artist_name)
		Artist.all.each do |artist|
			return artist if artist.name == artist_name
		end
		new_artist = Artist.new
		new_artist.name = artist_name
		new_artist
	end

end