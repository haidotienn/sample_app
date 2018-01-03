class Micropost < ApplicationRecord
  belongs_to :user
  validates :user_id, presence: true
  validates :content, presence: true,
    length: {maximum: Settings.micropost.content_length}
  default_scope ->{order(created_at: :desc)}
  mount_uploader :picture, PictureUploader
  validate  :picture_size

  scope :load_followed_id, ->(id){where("user_id IN (SELECT followed_id
    FROM relationships WHERE follower_id = #{id})
    OR user_id = #{id}")}

  private

  def picture_size
    if picture.size > 5.megabytes
      errors.add :picture, t("micropost.picture_validate")
    end
  end
end
