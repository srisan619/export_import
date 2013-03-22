class Product < ActiveRecord::Base
  
belongs_to :category
belongs_to :city
has_many :carts

validates :name, :date, :price, :presence => true
attr_accessible :name, :date, :price
attr_accessor :brand_id
has_attached_file :photo

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
#     CSV.parse('pro.csv', :headers=> false) do |row|
#      product = Product.create!(:name=>row[0],:date=>row[1],:price=>row[2])
 #       product.save!

      spreadsheet = open_spreadsheet(file)
      header = spreadsheet.row(1)
      (2..spreadsheet.last_row).each do |i|
         row = Hash[[header, spreadsheet.row(i)].transpose]
       product = find_by_id(row["id"])
       if product.nil?
      Product.create! row.to_hash.slice(*accessible_attributes)
      end
   end
 end

  def self.open_spreadsheet(file)
  case File.extname(file.original_filename)
  when ".csv" then Roo::Csv.new(file.path, nil, :ignore)
  when ".xls" then Roo::Excel.new(file.path, nil, :ignore)
  when ".xlsx" then Roo::Excelx.new(file.path, nil, :ignore)
  else raise "Unknown file type: #{file.original_filename}"
  end
end


  def paypal_url(return_url)
    values = {
      :business => 'srisan619-facilitator@gmail.com',
      :cmd => '_cart',
      :upload => 1,
      :return => return_url,
      :invoice => id
    }


    [self].each_with_index do |item, index|
      values.merge!({
        "amount_#{index+1}" => item.price,
        "item_name_#{index+1}" => item.name,
        "item_number_#{index+1}" => item.id,
        "quantity_#{index+1}" => 1
      })
    end

#    values.merge!({
#        "price_#{index+1}" => self.price,
#        "name_#{index+1}" => self.name,
#        "item_number_#{index+1}" => self.id
#      })

    "https://www.sandbox.paypal.com/cgi-bin/webscr?" + values.to_query
  end

end
