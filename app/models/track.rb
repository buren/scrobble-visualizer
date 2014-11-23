class Track < ActiveRecord::Base
  belongs_to :artist

  validates_presence_of :name, :artist
  validates_uniqueness_of :name

  def self.count_by_artist(limit = 10)
    top_fifty = group(:artist_id)
    .count
    .sort_by { |id, count| count }
    .reverse[0..limit].to_h

    Artist.where(id: top_fifty.map { |id, _| id })
      .map { |artist| [artist.name, top_fifty[artist.id]] }
      .sort_by { |e| e.last }.reverse
  end
end
