class HomeController < ApplicationController
  def index
  end

  def generate
    Search.create!(
      url:                   params[:url],
      base_selector:         params[:base_selector],
      artist_selector:       params[:artist_selector],
      track_selector:        params[:track_selector],
      scrobbled_at_selector: params[:scrobbled_at_selector]
    )
    Thread.new do
      scrobbles = ScrobbleService.new(params[:username], params.to_h).scrobbles
      scrobbles.each do |scrobble|
        artist = Artist.where(name: scrobble[:artist]).first_or_create
        track  = Track.where(name: scrobble[:track], artist: artist).first_or_create
        Scrobble.create!(artist: artist, track: track, scrobbled_at: scrobble[:scrobbled_at].to_time(:utc))
      end
    end
    redirect_to tracks_url
  end

  def reset
    [Artist, Track, Scrobble].each(&:delete_all)
    redirect_to root_url
  end
end
