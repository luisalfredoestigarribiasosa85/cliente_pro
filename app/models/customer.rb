class Customer < ApplicationRecord
  belongs_to :user
  has_many :reminders, dependent: :destroy

  enum :status, { new: 0, interested: 1, frequent: 2, lost: 3 }, prefix: true

  validates :name, presence: true
  validates :phone, presence: true
  validates :status, presence: true

  scope :overdue_follow_up, -> { where("last_contact_date < ? OR last_contact_date IS NULL", 30.days.ago) }
  scope :by_status, ->(status) { where(status: status) if status.present? }
  scope :search_by, ->(query) {
    return all if query.blank?
    where("name ILIKE :q OR phone ILIKE :q", q: "%#{query}%")
  }
  scope :recent, -> { order(created_at: :desc) }

  def whatsapp_link
    cleaned = phone.gsub(/[^0-9]/, "")
    "https://wa.me/#{cleaned}"
  end

  def last_contact_days_ago
    return nil unless last_contact_date
    (Date.current - last_contact_date).to_i
  end

  def needs_follow_up?
    last_contact_date.nil? || last_contact_date < 30.days.ago
  end

  def status_badge_color
    case status
    when "new" then "bg-blue-100 text-blue-800"
    when "interested" then "bg-yellow-100 text-yellow-800"
    when "frequent" then "bg-green-100 text-green-800"
    when "lost" then "bg-red-100 text-red-800"
    end
  end
end
