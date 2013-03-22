class CartsController < ApplicationController
  def show
    @cart = Product.all
  end

end
