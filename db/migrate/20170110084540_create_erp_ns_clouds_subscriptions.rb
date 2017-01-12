class CreateErpNsCloudsSubscriptions < ActiveRecord::Migration[5.0]
  def change
    create_table :erp_ns_clouds_subscriptions do |t|
      t.integer :quantity
      t.datetime :registed_at
      t.boolean :archived, default: false
      t.references :creator, index: true, references: :erp_users
      t.references :plan, index: true, references: :erp_ns_clouds_plans
      t.references :account, index: true, references: :erp_ns_clouds_accounts

      t.timestamps
    end
  end
end
