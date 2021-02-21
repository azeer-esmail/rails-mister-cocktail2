class DosesController < ApplicationController
  before_action :set_cocktail, only: [:new, :create]

  def new
    @dose = Dose.new
  end

  def create
    params[:dose][:ingredient].each do |ingredient_id|
      dose = Dose.new(dose_params)
      dose.ingredient = Ingredient.find(ingredient_id)
      dose.cocktail = @cocktail
      dose.save
    end
    
    redirect_to cocktail_path(@cocktail)
  end

  def destroy
    dose = Dose.find(params[:id].to_i)
    dose.destroy
    
    redirect_to cocktail_path(dose.cocktail)
  end
  

  private
  def dose_params
    params.require(:dose).permit(:description)
  end

  def set_cocktail
    @cocktail = Cocktail.find(params[:cocktail_id].to_i)
  end
end
