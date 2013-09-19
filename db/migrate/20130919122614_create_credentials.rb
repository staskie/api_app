class CreateCredentials < ActiveRecord::Migration
  def change
    create_table :credentials do |t|
      t.string :uuid
      t.string :secret_token
    end
  end
end
