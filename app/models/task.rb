class Task < ApplicationRecord
  # before_validation :set_nameless_name
  has_one_attached :image

  validates :name, presence: true, length: { maximum: 30 }
  validate :validate_name_not_include_comma

  belongs_to :user

  scope :recent, -> { order(created_at: :desc)}

  # CSV属性
  def self.csv_attributes
    ["name", "decription", "created_at", "updated_at"]
  end

  # CSV生成
  def self.generate_csv
    CSV.generate(headers: true) do |csv|
      csv << csv_attributes
      all.each do |task|
        csv << csv_attributes.map{ |attr| task.send(attr) }
      end
    end
  end

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      task = new
      task.attributes = row.to_hash.slice(*csv_attributes)
      task.save!
    end
  end

  def self.ransackable_attributes(auth_object = nil)
    %w[name created_at]
  end

  def self.ransackable_associations(auth_object = nil)
    []
  end

  private
  def validate_name_not_include_comma
    errors.add(:name, "にコンマを含めることはできません") if name&.include?(",")
  end
end
