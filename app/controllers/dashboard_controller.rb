class DashboardController < ApplicationController
  def index
    @customers = current_user.customers
    @total_customers = @customers.count
    @customers_by_status = @customers.group(:status).count
    @customers_needing_follow_up = @customers.overdue_follow_up.count
    @pending_reminders = current_user.reminders.pending.upcoming.limit(5)
    @recent_customers = @customers.recent.limit(5)
    @overdue_reminders = current_user.reminders.overdue.count
  end
end