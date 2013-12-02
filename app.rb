require_relative "./lib/artist.rb"
require_relative "./lib/genre.rb"
require_relative "./lib/song.rb"

songs_array = Dir.entries("data").select {|f| !File.directory? f}

def song_list(array)
	songs = []
	array.each do |song|
		song_artist = get_artist(song)
		song_name = get_name(song)
		song_genre = get_genre(song)
		new_song = create_song(song_name)		
		songs << new_song
		new_genre = create_genre(song_genre)
		new_artist = create_artist(song_artist)
		# new_song.genre = new_genre
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
	new_song = song.downcase.gsub(" ", "_")
	new_song = Song.new
	new_song.name = song
	new_song
end

def create_genre(genre)
	return if genre_exists?(genre)
	new_genre = Genre.new
	new_genre.name = genre
end

def genre_exists?(song_genre)
	Genre::GENRES.each do |genre|
		genre.name == song_genre ? genre_exists = true : genre_exists = false
	end
end

def create_artist(artist)
	return if artist_exist?(artist)
	new_artist = Artist.new
	artist.name = artist
end

def artist_exist?(song_artist)
	Artist::ARTISTS.each do |artist|
		artist.name == song_artist ? artist_exists = true : artist_exists = false
	end
end




p song_list = song_list(songs_array)
# song_list.each do |song|
# 	p song.genre
# end
p Genre.all
p Artist.all
