class AddAdditionalPictureColumnsToRecipes < ActiveRecord::Migration
  def change
    add_column :recipes, :picture1, :string
    add_column :recipes, :picture2, :string
    add_column :recipes, :picture3, :string
  end
end
