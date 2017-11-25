class CreateAutos < ActiveRecord::Migration[5.0]
  def change
    create_table :autos do |t|
      t.string :marca
      t.string :modelo
      t.string :color
      t.integer :hp
      t.text :descripcion
      t.decimal :precio
      t.integer :contador_visita, default: 0
      t.string :foto
      # Esta linea agrega una columna integer llamada user_id con la que haremos referencia al usuario
      t.references :usuario, foreign_key: true

      t.timestamps
    end
  end
end
