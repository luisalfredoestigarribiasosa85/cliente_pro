class MessageTemplatesController < ApplicationController
  before_action :set_template, only: %i[edit update destroy]

  def index
    @templates = current_user.message_templates.recent
  end

  def new
    @template = current_user.message_templates.build
  end

  def edit
  end

  def create
    @template = current_user.message_templates.build(template_params)

    if @template.save
      redirect_to message_templates_path, notice: "Plantilla creada exitosamente."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @template.update(template_params)
      redirect_to message_templates_path, notice: "Plantilla actualizada."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @template.destroy
    redirect_to message_templates_path, notice: "Plantilla eliminada."
  end

  private

  def set_template
    @template = current_user.message_templates.find(params[:id])
  end

  def template_params
    params.require(:message_template).permit(:title, :content)
  end
end