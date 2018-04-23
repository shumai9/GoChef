class SkillsetManager

  attr_reader :cuisine_ids, :user
  def initialize(cuisine_ids, user)
    @cuisine_ids = cuisine_ids
    @user = user
  end

  def clean_cuisines
    cuisine_ids.reject { |id| id == "" }
  end

  def checked_cuisines
    clean_cuisines.map { |id| Cuisine.find(id) }
  end

  def unchecked_cuisines
    Cuisine.all.reject { |cuisine| checked_cuisines.include?(cuisine) }
  end

  def create_skillsets_from_checked_cuisines
    checked_cuisines.each do |cuisine|
      Skillset.find_or_create_by(cuisine: cuisine, user: user)
    end
  end

  def destroy_skillsets_from_unchecked_cuisines
    unchecked_cuisines.each do |cuisine|
      skillset = Skillset.find_by(cuisine_id: cuisine.id, user_id: @user.id)
      if skillset
        skillset.destroy
      end
    end
  end

  def run
    create_skillsets_from_checked_cuisines
    destroy_skillsets_from_unchecked_cuisines
  end
end