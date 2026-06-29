class RemindersController < ApplicationController
  before_action :set_reminder, only: %i[edit update destroy toggle_done]

  def index
    @reminders = current_user.reminders.recent
    @pending_reminders = current_user.reminders.pending.upcoming
    @overdue_reminders = current_user.reminders.overdue
  end

  def new
    @reminder = current_user.reminders.build
    @reminder.remind_at = Time.current + 1.hour
  end

  def edit
  end

  def create
    @reminder = current_user.reminders.build(reminder_params)

    if @reminder.save
      redirect_to reminders_path, notice: "Recordatorio creado exitosamente."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @reminder.update(reminder_params)
      redirect_to reminders_path, notice: "Recordatorio actualizado."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @reminder.destroy
    redirect_to reminders_path, notice: "Recordatorio eliminado."
  end

  def toggle_done
    @reminder.update(done: !@reminder.done)
    redirect_to reminders_path, notice: @reminder.done ? "Recordatorio completado." : "Recordatorio reabierto."
  end

  private

  def set_reminder
    @reminder = current_user.reminders.find(params[:id])
  end

  def reminder_params
    params.require(:reminder).permit(:customer_id, :message, :remind_at, :done)
  end
end