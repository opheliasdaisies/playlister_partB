class Artist
  attr_accessor :name, :songs, :genres

  ARTISTS = []
  @@artist_count = 0

  def initialize
    @name
    @songs = []
    @genres = []
    @@artist_count += 1
    ARTISTS << self
  end
  
  def self.reset_artists
    ARTISTS.clear
    @@artist_count = 0
  end

  def self.count
    @@artist_count
  end

  def self.all
    ARTISTS
  end

  def songs_count
    song_num = 0
    songs.each { |song| song_num += 1 }
    song_num
  end

  def add_song(new_song)
    songs << new_song
    songs.each do |song_item|
      unless song_item.genre == nil
        genres << song_item.genre unless genres.include?(song_item.genre)
        song_item.genre.artists << self unless song_item.genre.artists.include?(self)
      end
    end
  end

end