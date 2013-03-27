class SrTranslate
  
  def self.sr_t(label, separator=" / ")
    tlabel = I18n.t(label)
    tlabel = label if tlabel.include?("translation missing")
    if Ambient.conf.get(:label_language_type) == :dual
      second_label = I18n.t(label, {:locale => :en})
      second_label = label if second_label.include?("translation missing")
      tlabel = tlabel == second_label ? tlabel : tlabel + separator + second_label
    end
    tlabel
  end
  
end