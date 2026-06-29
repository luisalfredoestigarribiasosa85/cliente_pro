class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :customers, dependent: :destroy
  has_many :reminders, dependent: :destroy
  has_many :message_templates, dependent: :destroy

  validates :business_name, presence: true

  def subscription_active?
    # Placeholder for future payment integration
    # Will check subscription status via dLocal / PagoPar
    true
  end

  def plan_name
    # Placeholder for subscription plans
    "Gratuito"
  end
end