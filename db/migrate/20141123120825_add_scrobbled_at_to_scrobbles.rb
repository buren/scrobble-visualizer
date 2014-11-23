class AddScrobbledAtToScrobbles < ActiveRecord::Migration
  def change
    add_column :scrobbles, :scrobbled_at, :datetime
  end
end
