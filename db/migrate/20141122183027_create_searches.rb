class CreateSearches < ActiveRecord::Migration
  def change
    create_table :searches do |t|
      t.string :url
      t.string :base_selector
      t.string :artist_selector
      t.string :track_selector

      t.timestamps
    end
  end
end
