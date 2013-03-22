class Cart < ActiveRecord::Base
  

  def total_price
    # convert to array so it doesn't try to do sum on database directly
    Product.sum(&:price)
  end

  


end
