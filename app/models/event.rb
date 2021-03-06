class Event < ApplicationRecord
	has_attached_file :image, styles: { small: "200x100", med: "200x200", large: "300x300" }	
	validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/	
    belongs_to :user
    has_many :comments, dependent: :destroy
    has_many :attendances, dependent: :destroy
	has_many :users, through: :attendances, dependent: :destroy

end
