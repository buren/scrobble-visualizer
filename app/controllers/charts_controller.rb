class ChartsController < ApplicationController
  def unique_tracks_by_artist
    render json: Track.count_by_artist(25)
  end

  def scrobbles_by_day
    render json: Scrobble.group_by_day(:scrobbled_at).count
  end

  def scrobbles_by_hour
    render json: Scrobble.group_by_hour_of_day(:scrobbled_at, format: '%H').count
  end

  def scrobbles_by_week
    render json: Scrobble.group_by_week(:scrobbled_at, format: '%W').count
  end

  def top_artist_scrobbles
    counts  = Scrobble.group(:artist_id).order('count_id desc').limit(25).count('id')
    artists = Artist.where(id: counts.keys)
    render json: artists.map { |artist| [artist.name, counts[artist.id]] }.sort_by { |e| e.last }.reverse
  end

  def top_track_scrobbles
    counts = Scrobble.group(:track_id).order('count_id desc').limit(25).count('id')
    tracks = Track.where(id: counts.keys)
    render json: tracks.map { |track| [track.name, counts[track.id]] }.sort_by { |e| e.last }.reverse
  end
end
