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
		new_genre = return_or_create_genre(song_genre)
		new_artist = return_or_create_artist(song_artist)
		new_song.genre = new_genre
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

def return_or_create_genre(genre)
	Genre.all.each do |genre|
		return genre if genre.name == genre
	end
	new_genre = Genre.new
	new_genre.name = genre
	new_genre
end

def return_or_create_artist(artist)
	Artist.all.each do |artist|
		return artist if artist.name == artist
	end
	new_artist = Artist.new
	new_artist.name = artist
	new_artist
end

def artist_exist?(song_artist)

	false
end




p song_list = song_list(songs_array)
# song_list.each do |song|
# 	p song.genre
# end
p Genre.all
p Artist.all
