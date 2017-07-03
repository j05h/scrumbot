Sequel.migration do
  up do
    DB.create_table :reports do
      primary_key :id
      String :text,    null: false
      String :user,    null: false
      String :channel, null: false
      Time   :created_at
      Time   :updated_at
    end
  end

  down do
    DB.drop_table :reports
  end
end

