class AccountTypes < Application
  # provides :xml, :yaml, :js

  def index
    @account_types = AccountType.all
    display @account_types, :layout => layout?
  end

  def show
    id = params[:id]
    @account_type = AccountType.get(id)
    raise NotFound unless @account_type
    display @account_type
  end

  def new
    only_provides :html
    @account_type = AccountType.new
    display @account_type, :layout => layout?
  end

  def edit
    id = params[:id]
    only_provides :html
    @account_type = AccountType.get(id)
    raise NotFound unless @account_type
    display @account_type
  end

  def create
    account_type = params[:account_type]
    @account_type = AccountType.new(account_type)
    if @account_type.save
      redirect resource(:accounts), :message => {:notice => "AccountType was successfully created"}
    else
      message[:error] = "AccountType failed to be created"
      render :new
    end
  end

  def update
    id = params[:id]
    account_type = params[:account_type]
    @account_type = AccountType.get(id)
    raise NotFound unless @account_type
    if @account_type.update(account_type)
       redirect resource(:accounts)
    else
      display @account_type, :edit
    end
  end

  def destroy
    id = params[:id]
    @account_type = AccountType.get(id)
    raise NotFound unless @account_type
    if @account_type.destroy
      redirect resource(:account_types)
    else
      raise InternalServerError
    end
  end

end # AccountTypes
