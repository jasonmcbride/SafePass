class Entry < ApplicationRecord
  belongs_to :user

  validates :name, presence: true
  validates :url, presence: true, format: { with: URI::regexp(%w[http https]), message: "must be a valid URL" }
  validates :username, presence: true
  validates :password, presence: true

  encrypts :username, :password, deterministic: true

  scope :search_name, ->(name) { where("name ILIKE ?", "%#{name}%") if name.present? }
  
  def self.search(name) 
    search_name(name).order(name: :desc)
  end
end
