class CustomersController < ApplicationController
  before_action :set_customer, only: %i[show edit update destroy]

  def index
    @customers = current_user.customers
      .search_by(params[:query])
      .by_status(params[:status])
      .recent
  end

  def show
    @reminders = @customer.reminders.recent.limit(5)
  end

  def new
    @customer = current_user.customers.build
  end

  def edit
  end

  def create
    @customer = current_user.customers.build(customer_params)

    if @customer.save
      redirect_to @customer, notice: "Cliente creado exitosamente."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @customer.update(customer_params)
      redirect_to @customer, notice: "Cliente actualizado exitosamente."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @customer.destroy
    redirect_to customers_url, notice: "Cliente eliminado."
  end

  private

  def set_customer
    @customer = current_user.customers.find(params[:id])
  end

  def customer_params
    params.require(:customer).permit(:name, :phone, :status, :notes, :last_contact_date)
  end
end