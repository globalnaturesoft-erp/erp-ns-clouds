class CreateErpNsCloudsAccounts < ActiveRecord::Migration[5.0]
  def change
    create_table :erp_ns_clouds_accounts do |t|
      t.string :image_url
      t.string :domain
      t.string :username
      t.string :password
      t.string :name
      t.string :legal_representative
      t.string :phone
      t.string :email
      t.string :address
      t.string :website
      t.string :fax
      t.string :tax
      t.boolean :archived, default: false
      t.references :creator, index: true, references: :erp_users
      t.references :industry, index: true, references: :erp_industries_industries
      t.references :country, index: true, references: :erp_areas_countries
      t.references :state, index: true, references: :erp_areas_states

      t.timestamps
    end
  end
end
