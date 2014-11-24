class HomeController < ApplicationController
  def index
  end

  def api_generate
    Thread.new do
      scrobbles = LastFmApi.new.scrobbles(params[:username], max_pages: params[:max_pages])
      Scrobble.create_scrobbles(scrobbles)
    end
    redirect_to tracks_url
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
      Scrobble.create_scrobbles(scrobbles)
    end
    redirect_to tracks_url
  end

  def reset
    [Artist, Track, Scrobble].each(&:delete_all)
    redirect_to root_url
  end
end
