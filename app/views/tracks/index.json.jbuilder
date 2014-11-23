json.array!(@tracks) do |track|
  json.extract! track, :id, :name, :artist_id
  json.url track_url(track, format: :json)
end
