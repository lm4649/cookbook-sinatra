class Recipe
  attr_reader :name, :description, :prep_time, :done, :difficulty

  def initialize(name, description, prep_time, done, difficulty)
    @name = name
    @description = description
    @prep_time = prep_time
    @done = done
    @difficulty = difficulty
  end

  def done!
    @done = true
  end
end
