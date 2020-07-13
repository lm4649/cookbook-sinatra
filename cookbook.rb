require 'csv'
require_relative 'recipe'
# store all of our recipes
class Cookbook
  def initialize(csv_file_path)
    @csv_file_path = csv_file_path
    @recipes = [] # storing all of our instances
    load_csv
  end

  def all
    @recipes
  end

  def add(recipe)
    @recipes << recipe
    save_csv
  end

  def remove_at(index)
    @recipes.delete_at(index)
    save_csv
  end

  def update(recipe_index, recipe)
    @recipes[recipe_index] = recipe
    save_csv
  end

  private

  def load_csv
    CSV.foreach(@csv_file_path) do |row|
      # row = ["pizza", "round", "5 min", done]
      boolean = true?(row[3])
      @recipes << Recipe.new(row[0], row[1], row[2], boolean, row[4])
    end
  end

  def save_csv
    CSV.open(@csv_file_path, 'wb') do |csv|
      @recipes.each do |recipe| # instance
        csv << [recipe.name, recipe.description, recipe.prep_time, recipe.done, recipe.difficulty]
      end
    end
  end

  def true?(word)
    word.downcase == 'true'
  end
end
