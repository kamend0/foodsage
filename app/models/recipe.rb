class Recipe < ApplicationRecord
    has_many :ingredients, dependent: :destroy

    validates :title, presence: true
    validates :description, presence: true
    validates :servings, presence: true
    validates :instructions, presence: true    
end
