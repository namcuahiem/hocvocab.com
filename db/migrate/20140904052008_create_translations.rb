class CreateTranslations < ActiveRecord::Migration
  def change
    create_table :translations do |t|
      t.references :post, index: true
      t.references :user, index: true
      t.integer :start
      t.integer :end
      t.string :words
      t.string :meaning

      t.timestamps
    end
  end
end
