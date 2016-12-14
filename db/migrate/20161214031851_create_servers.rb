class CreateServers < ActiveRecord::Migration[5.0]
  def change
    create_table :servers do |t|
      t.string :uid
      t.string :name
      t.string :so
      t.string :ip
      t.decimal :disk_used
      t.decimal :disk_used_percent
      t.decimal :memory_used
      t.decimal :memory_used_percent
      t.decimal :cpu_used
      t.text :cpu_processes
      t.text :memory_processes
      t.integer :user_id

      t.timestamps
    end
  end
end
