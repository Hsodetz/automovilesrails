class Auto < ApplicationRecord
  # Con esta linea hacemos referencia al modelo usuario, diciendo que este modelo pertenece al modelo usuario.
  belongs_to :usuario

  mount_uploader :foto, ImagenUploader

  # Crearemos las validaciones
  validates :marca, :color, :hp,
            presence: {message: "El campo no puede estar vacio"},
            length:   {minimum: 2,message: "Minimo dos caracteres"},
            length:   {maximum: 20, message: "Maximo diez caracteres"}
            
  validates :modelo,
            presence: {message: "El campo no puede estar vacio"},
            length:   {minimum: 1, message: "Minimo una caracteres"},
            length:   {maximum: 10, message: "Maximo diez caracteres"}

  validates :descripcion,
            presence: {message: "El campo no puede estar vacio"},
            length:   {minimum: 10, message: "Minimo 10 caracteres"},
            length:   {maximum: 1500, message: "Maximo 1500 caracteres"}  
  
  validates :foto,
            presence: {message: "El campo no puede estar vacio"}          
                      
  # Validando las imagenes
  validates_integrity_of  :foto
  validates_processing_of :foto          

  # Creamos una funcion para aumentar el contador de visitas cada vez que ingresemos a la vista show del registro          
  def update_contador_visita
    self.update(contador_visita: contador_visita + 1)
  end          


private

def imagen_size_validation
  errors[:foto] << "Debe ser de menos de 500Kb" if imagen.size > 0.5.megabytes
end
end
