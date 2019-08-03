class AddCoordinateToYama < ActiveRecord::Migration[6.0]
  def change
    add_column :yamas, :lat, :decimal, precision: 9, scale: 6, after: :type
    add_column :yamas, :lng, :decimal, precision: 9, scale: 6, after: :lng
  end
end
