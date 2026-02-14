class Book < ApplicationRecord
    before_validation :validation_prework
    after_validation :validation_afterwork
    before_save :save_prework, if: :description_present
    after_save :save_afterwork, unless: :description_present
    before_create :create_prework
    after_create :create_afterwork
    before_update :update_prework
    after_update :update_afterwork
    before_destroy :destroy_prework
    after_destroy :destroy_afterwork
    after_commit :commit_afterwork
    after_rollback :rollback_afterwork
  
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

    def validation_prework
        puts "バリデーション前です"
    end
    
    def validation_afterwork
        puts "バリデーション後です"
    end
    
    def save_prework
        puts "保存前です"
    end
    
    def save_afterwork
        puts "保存後です"
        # raise "Exception After_Save Error"
    end
    
    def create_prework
        puts "登録前です"
    end
    
    def create_afterwork
        puts "登録後です"
    end
    
    def update_prework
        puts "更新前です"
    end
    
    def update_afterwork
        puts "更新後です"
    end
    
    def destroy_prework
        puts "削除前です"
    end
    
    def destroy_afterwork
        puts "削除後です"
        throw :abort
    end
    
    def commit_afterwork
        puts "コミット後です"
    end
    
    def rollback_afterwork
        puts "ロールバック後です"
    end
end
