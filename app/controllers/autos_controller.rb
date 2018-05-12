class AutosController < ApplicationController
  # Hacemos un before_action de autentificacion de usuario, exceptuando el index, esto para evitar ingresar sin estar logueado
  before_action :authenticate_usuario!, except: [:index, :show] 

  before_action :set_id, only: [:show, :edit, :update, :destroy]

  

  def index
    # Usamos kaminari para hacer la paginacion
    @autos = Auto.all.order(marca: :desc).page(params[:page]).per(5)
    
  end

  def show
    # Primero encontramos el id del registro al cual estamos apuntando, esta seteadoe en ele set_id
    
    # Obtenemos todos los campos de la tabla usuarios don de el id sea igual al campo usuario_id de la tabla autos
    # Esto para obtener el nombre usuario que creo el Registro en la tabla autos
    @usuarios = Usuario.all.where(id:  @auto.usuario_id)
    # llamamos a la fincion update_contador_visita, para aumentar el contador cada vez q visitemos el registro de autos
    @auto.update_contador_visita
  end

  def new
    @auto = Auto.new
  end

  def create
    # Creamos una instancia del modelo auto, y le pasamos los campos en el parametro fuerte
    @auto = Auto.new(params_auto)
    # debemos definir el id de usuario en el modelo auto
    @auto.usuario_id = current_usuario.id # Le decimos que el campo user_id de la tabla autos es el usuario cuyo id de la tabla usuarios
    # Luego guardamos, si es verdad nos redirige a la vista show con el id del auto, de lo contrario hace un render a new
    if @auto.save
      flash[:success] = "Tu Auto #{@auto.marca} #{@auto.modelo} se creo satisfactoriamente"
      redirect_to @auto
    else
      render 'new'
    end    
  end

  def edit
    
  end

  def update
    
    if @auto.update(params_auto)
      flash[:success] = "Has actualizado el auto #{@auto.marca} #{@auto.modelo}"
      redirect_to auto_path
    else
      render 'edit'
    end    
  end

  def destroy
    
    @auto.destroy
    flash[:success] = "Se ha eliminado correctamente el #{@auto.marca} #{@auto.modelo}"
    redirect_to autos_path
  end

  private
  def params_auto
    params.require(:auto).permit(:marca, :modelo, :color, :hp, :foto, :descripcion, :precio)
  end

  def set_id
    @auto = Auto.find(params[:id])
  end
end
