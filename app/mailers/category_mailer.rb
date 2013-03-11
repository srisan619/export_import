class CategoryMailer < ActionMailer::Base
  default :from => "srisan619@gmail.com"

  def category_info(category)
    @category = category
    #attachments["#{category.photo_file_name}"] = File.read("#{Rails.root}/public/system/categories/photos/000/000/#{category.id}/small/#{category.photo_file_name}")
    attachments["seenu.jpg"] = File.read("#{Rails.root}/public/images/seenu.jpg")
    mail(:to=>category.email, :subject=> "Category Informations")
  end

end
