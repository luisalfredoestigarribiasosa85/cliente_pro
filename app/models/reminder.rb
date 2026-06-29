class Reminder < ApplicationRecord
  belongs_to :user
  belongs_to :customer

  before_validation :set_default_done, on: :create

  validates :message, presence: true
  validates :remind_at, presence: true

  scope :pending, -> { where("done = ? OR done IS NULL", false) }
  scope :completed, -> { where(done: true) }
  scope :overdue, -> { pending.where("remind_at < ?", Time.current) }
  scope :upcoming, -> { pending.where("remind_at > ?", Time.current).order(remind_at: :asc) }
  scope :recent, -> { order(created_at: :desc) }

  private

  def set_default_done
    self.done = false if done.nil?
  end
end
