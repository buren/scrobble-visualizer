class AddScrobbledAtSelectorToSearches < ActiveRecord::Migration
  def change
    add_column :searches, :scrobbled_at_selector, :string
  end
end
