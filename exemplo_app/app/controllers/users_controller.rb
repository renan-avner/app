class UsersController < ApplicationController
   before_action :logged_in_user, only: [:index, :edit, :update] 
   # antes de dos metodos endex,edit,update o usuario deve ter passado pela função 
   
   before_action :correct_user,   only: [:edit, :update]
   before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
   before_action :admin_user,     only: :destroy 

  def show
     @user = User.find(params[:id]) # faz a busca de um usuario usando o id 

  end

  def index
    @users = User.paginate(page: params[:page])
  end


  def new    #função news
    @user = User.new  #cria um novo usuario
  end

 def create
    @user = User.new(user_params)
    if @user.save
      @user.send_activation_email
      flash[:info] = "Please check your email to activate your account."
      redirect_to root_url
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id]) # pega o usuario com o id informado 
    
  end

   def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated" #exibe mensagem 
      redirect_to @user   #redirecionar a pagina para perfil
    else
      render 'edit'  #se nao redireciona para funcao edit
    end
  end

  

    def user_params
      params.require(:user).permit(:name, :email, :password,  #paramentros requeridos
                                   :password_confirmation)
    end

    # Confirms a logged-in user.
    def logged_in_user
      unless logged_in?
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end

    # Confirms the correct user.
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless @user == current_user
    end

    def destroy
       User.find(params[:id]).destroy # chama o metodo destroy da sessao para o user com o id especifico 
       flash[:success] = "User deleted"
       redirect_to users_url
    end

      # Confirms an admin user.
    def admin_user
      redirect_to(root_url) unless current_user.admin? # se current_user.admin for falso redireciona para pagina principal
    end


end