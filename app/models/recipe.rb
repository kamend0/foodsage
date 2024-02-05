class Recipe < ApplicationRecord
    has_one_attached :cover_image
    belongs_to :user
    has_many :ingredients, dependent: :destroy, inverse_of: :recipe
    accepts_nested_attributes_for :ingredients, reject_if: :all_blank, allow_destroy: true

    validates :title, presence: true
    validates :description, presence: true
    validates :servings, presence: true
    validates :instructions, presence: true
end
