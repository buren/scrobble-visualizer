class CreateScrobbles < ActiveRecord::Migration
  def change
    create_table :scrobbles do |t|
      t.belongs_to :artist, index: true
      t.belongs_to :track, index: true

      t.timestamps
    end
  end
end
