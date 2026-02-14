class Book < ApplicationRecord
    validates :title, presence: true
    validates :description, presence: true, on: :update
    # validates :title, format: { with: /\A[a-zA-Z]+\z/, message: "は英文字で記述してください" }
    validates :title, length: { in: 8..12,
               too_long: "タイトルは最大12桁です",
               too_short: "タイトルは最小8桁です",
              }
    validates :price, numericality: true
    validates :number, numericality: { only_integer: true}, uniqueness: true
    validates :genre, presence: true, if: :description_present

    TODAY = Time.now.midnight
    scope :today_search, -> {where(created_at: TODAY..TODAY.tomorrow)}

    scope :title_search, ->(title) {where(title: title)}

    enum genre: [:novel, :history, :travel, :anime, :picture_book, :technical_book]

    private
    def description_present
        description.present?
    end
end
