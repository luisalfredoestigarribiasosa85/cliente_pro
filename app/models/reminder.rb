class Reminder < ApplicationRecord
  belongs_to :user
  belongs_to :customer

  validates :message, presence: true
  validates :remind_at, presence: true

  scope :pending, -> { where(done: false) }
  scope :completed, -> { where(done: true) }
  scope :overdue, -> { pending.where("remind_at < ?", Time.current) }
  scope :upcoming, -> { pending.where("remind_at > ?", Time.current).order(remind_at: :asc) }
  scope :recent, -> { order(created_at: :desc) }
end