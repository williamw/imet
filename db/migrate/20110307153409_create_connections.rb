class CreateConnections < ActiveRecord::Migration
  def self.up
    create_table :connections do |t|
      t.string :name
      t.date :when
      t.string :where
      t.text :details
      t.text :social

      t.timestamps
    end
  end

  def self.down
    drop_table :connections
  end
end
