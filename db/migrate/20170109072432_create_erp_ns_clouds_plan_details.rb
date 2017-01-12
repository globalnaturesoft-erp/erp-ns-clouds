class CreateErpNsCloudsPlanDetails < ActiveRecord::Migration[5.0]
  def change
    create_table :erp_ns_clouds_plan_details do |t|
      t.string :name
      t.string :icon
      t.text :description
      t.references :creator, index: true, references: :erp_users
      t.references :plan, index: true, references: :erp_ns_clouds_plans

      t.timestamps
    end
  end
end
