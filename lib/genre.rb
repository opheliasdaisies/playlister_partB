class Genre
  attr_accessor :name, :songs, :artists

  GENRES = []

  def initialize
    @name
    @songs = []
    @artists = []
    GENRES << self
  end

  def self.all
    GENRES
  end

  def self.reset_genres
    GENRES.clear
  end

end