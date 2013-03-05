class Product < ActiveRecord::Base
  #validates :name, :date, :price, :presence => true

#  def self.to_csv(options={})
#    CSV.generate(options) do |csv|
#        csv << column_names
#        all.each do |product|
#            csv << product.attributes.value_at(*column_names)
#        end
#    end
#  end

  def self.import(file)    
#      CSV.foreach(file.path, :headers => true) do |row|
#          Product.create! row.to_hash
        CSV.parse(file, :headers=> false) do |row|      
      product = Product.create!(:name=>row[0],:date=>row[1],:price=>row[2])
#        product.save
      end
  end

end
