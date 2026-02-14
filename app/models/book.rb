class Book < ApplicationRecord
    validates :title, presence: true, length: {
      in: 8..12,
      too_long: "タイトルは最大12桁です",
      too_short: "タイトルは最小8桁です"
    }
    # validates :title, format: { with: /\A[a-zA-Z]+\z/, message: "は英文字で記述してください" }
    validates :description, presence: true, on: :update
    validates :price, numericality: true
    validates :number, numericality: { only_integer: true}, uniqueness: true
    validates :genre, presence: true, if: :description_present

    validate :title_language_check

    TODAY = Time.now.midnight
    scope :today_search, -> {where(created_at: TODAY..TODAY.tomorrow)}

    scope :title_search, ->(title) {where(title: title)}

    enum genre: [:novel, :history, :travel, :anime, :picture_book, :technical_book]

    private
    def description_present
        description.present?
    end

    def title_language_check
        if title && title.match(/\A[a-zA-Z\s]+\z/) && !description.match(/\A[a-zA-Z\s]+\z/)
            errors.add(:description, "タイトルが英文字のときは、説明も英文字でなければならない")
        end
    end
end
