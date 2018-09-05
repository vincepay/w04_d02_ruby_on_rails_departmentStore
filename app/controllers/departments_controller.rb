class DepartmentsController < ApplicationController
  
  # before_action :set_department, only: [:show, :edit, :update, :destroy]
  
  # ---------------------------------------------------------------
  def index
    @departments = Department.all
    render :index 
  end

  def show
    @department = Department.find(params[:id])
  end
  # ---------------------------------------------------------------
  def new
    @department = Department.new
    render partial: "form"
    # The user fills in a form when het goes to the /departments/new   page. And when he presses "Create Department" it goes to the create method . the params are what the user inserted in the fields of the formk
    # as seen in the _form.html.erb,   the first field is placed in variable :name   and 2nd field  in variable  :acronym.   These 2 variables are really keys to the 'params'  hash which will be sent to the   department#create method

    # for the required fields, if the user doesn't place anything, and tries to submit, box appears saying "please fill out this field"
    # ??? So never goes to /views/departments/new.html.erb
  end

  def create 
    x = params.require(:department).permit(:name, :acronym)  # NOTE if dont put ':' --> undefined local variable or method 'acronym'
    # x = params.require(:department).permit(:name) --->   {"name"=> "Deli"}
    # Department.new(x)   ---> #<Department:0x00007f30bc4012a0 id: nil, name: "Deli", acronym: nil, created_at: nil, updated_at: nil>
    # so this has nil acronym , but to get both name AND acronym
    # --> <ActionController::Parameters {"name"=>"Deli", "acronym"=>"dl"} permitted: true>  
    # Department.
    @department = Department.new(x)
    
    if @department.save 
      # departments_path   -->  "/departments"
      # I think   @department.save   tries to save this new entry in to the table, and returns true if successful
      redirect_to departments_path  
    else
      render :new
    end
  end

  # ---------------------------------------------------------------
  def edit
    # binding.pry
    # params = {"controller"=>"departments", "action"=>"edit", "id"=>"3"}
    @department = Department.find(params[:id])
    render partial: "form"
  end

  def update
    # binding.pry 
    # When the user tries to 'edit' a department, and fills the form, and presses the 'Update department' button,
    # this function is called and a parameter is sent to it which is:
    # params = 
    #  {"_method"=>"patch", 
    #   "authenticity_token"=>"MKzquajH4Nsdwo+LR07eML9JjAdpKynmKbJg25pcNlkA+JgiCydzVfclJw7s2Pei9oW1cT9oxzp+EM+WK24PZQ==", 
    #   "department"=>{"name"=>"Electronics", "acronym"=>"Elx"}, 
    #   "commit"=>"Update Department", 
    #   "controller"=>"departments", 
    #   "action"=>"update", 
    #   "id"=>"1"}

    @department = Department.find(params[:id])
    x = params.require(:department).permit(:name, :acronym)
    if @department.update(x)
      redirect_to @department 
    else
      render :edit
    end
  end
  # ---------------------------------------------------------------
  def destroy
    @department = Department.find(params[:id])
    @department.delete
    # departments_path   -->  "/departments"
    redirect_to departments_path
  end

  # ---------------------------------------------------------------
  private
    def set_department
      @department = Repartment.find(params[:id])
    end

    def department_params
      params.require(:department).permit(:name)
    end




end
