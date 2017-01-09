class CreateErpNsCloudsPlans < ActiveRecord::Migration[5.0]
  def change
    create_table :erp_ns_clouds_plans do |t|
      t.string :name
      t.decimal :price
      t.string :period
      t.text :description
      t.boolean :archived, default: false
      t.references :creator, index: true, references: :erp_users

      t.timestamps
    end
  end
end
