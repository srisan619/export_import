class Product < ActiveRecord::Base
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

end
