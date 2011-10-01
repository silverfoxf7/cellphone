class CreatePhoners < ActiveRecord::Migration
  def self.up
    create_table :phoners do |t|
      t.datetime :when
      t.string :phone
      t.integer :minutes
      t.string :destination
      t.integer :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :phoners
  end
end
