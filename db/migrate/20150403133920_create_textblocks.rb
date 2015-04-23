class CreateTextblocks < ActiveRecord::Migration
  def change
    create_table :textblocks do |t|
      t.text :content

      t.timestamps null: false
    end
  end
end
