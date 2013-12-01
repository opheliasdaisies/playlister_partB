class Song
  attr_accessor :name, :artist
  attr_reader :genre

	def initialize
    @name
    @genre
    @artist
	end

  def genre= (new_genre)
    @genre = new_genre
    @genre.songs << self
  end

end