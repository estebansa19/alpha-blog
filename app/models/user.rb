class User < ApplicationRecord
  has_many :articles

  validates :username, presence: true, uniqueness: { case_sensitive: false },
    length: { minimum: 3, maximum: 25 }
  validates :email, presence: true, uniqueness: { case_sensitive: false },
    length: { maximum: 105 }, format: { with: URI::MailTo::EMAIL_REGEXP }

  before_save :downcase_email

  has_secure_password

  def downcase_email
    email.downcase
  end
end
