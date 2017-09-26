class Song < ActiveRecord::Base

  validates :title, presence: true
  validates :title, uniqueness: {scope: [:artist_name, :release_year]}
  validates :released, inclusion: { in: [true, false]}
  validates :release_year, presence: true, unless: Proc.new { |a| a.released == false}
  validates :genre, presence: true
  validate :in_future

  def in_future
    if release_year
      if Date.today.year < self.release_year
        self.errors[:release_year] << "This is in the future! Impossible!"
      else
        return
      end
    end
  end

end


# Optional if released is false
# Must not be blank if released is true
# Must be less than or equal to the current year


# if Date.today - 18.years < self.dob
#   self.errors[:dob] << "ur 2 yung ladee" #error message
# end
