# Copyright © 2005-2010 Srishti Software Applications Pvt Ltd.
# This product includes software developed by Srishti Software Applications Pvt ltd.
# All rights reserved

class LabelFormBuilder < ActionView::Helpers::FormBuilder
  helpers = field_helpers + 
            %w(date_select datetime_select time_select) + 
            %w(collection_select select country_select time_zone_select) - 
            %w(hidden_field label fields_for submit)
  helpers.each do |name|
    define_method('sr_'+ name) do |field, *args|
      options = args.last.is_a?(Hash) ? args.pop : {}
      options[:label] = create_label(options[:label], field, options[:mandatory]) if options[:label]
#      options[:label] = options[:mandatory] ? options[:label] + "<span class='mandatorty_color'>*</span>" : options[:label]
      td_for_colon = options[:add_colon] ? @template.content_tag(:td, "<b>:</b>") : ""
      label = label(field, options[:label], :class => options[:label_clas]) + td_for_colon
      if options[:div_id]
        @template.content_tag(:td, label,:align=>'left',:cellspacing=>6,:colspan => options[:label_colspan]) + @template.content_tag(:td,@template.content_tag(:div , send(name,field,options),:colspan => options[:col_span],:rowspan => options[:row_span],:id=>options[:div_id]))  
      else 
        if options[:label]
          @template.content_tag(:td, label, :align=>'left', :colspan => options[:label_colspan], :width => options[:label_width], :align => options[:label_align]) + @template.content_tag(:td, send(name,field,options),:colspan => options[:col_span],:rowspan => options[:row_span])
        else
          @template.content_tag(:td, send(name,field,options),:colspan => options[:col_span])
        end
      end
    end
  end
  
    def create_label(label, field, mandatory=nil)
    if mandatory
      label = (label + "<span class='mandatorty_color'>*</span>").html_safe
    end
    label = SrTranslate.sr_t(label)
    
#    ####### code change start for Internationalization 
#    if Ambient.conf.get(:label_language_type) == :single
#      label = SrTransalate.sr_t(label_name) if Ambient.conf.get(:label_language_type) == :single
#    else
#      first_label = SrTransalate.sr_t(label)
#      second_label = SrTransalate.sr_t(label, {:locale => :en})
#      if first_label == second_label
#        label = first_label
#      else
#        label = first_label + "/" + second_label
#      end
#    end
#    ####### code change end for Internationalization
    
  end
  
  
#  def sr_date(field,options = {})
#    options[:label] = create_label(options[:label], field)
##    options[:label] = options[:mandatory] ? options[:label] + "<span class='mandatorty_color'>*</span>" : options[:label]
#    td_for_colon = options[:add_colon] ? @template.content_tag(:td, "<b>:</b>") : ""
#    label = label(field, options[:label], :class => options[:label_clas]) + td_for_colon
#    date =  text_field(field,options) + "<img src='/images/calendar.png' id='_#{field}_link' class='calendar' load_id='#{field}',alt='Calendar'/>" + "<div id='_#{field}_calendar' class='date_picker' style='display:none'></div>"
#    if options[:label]
#      @template.content_tag(:td, label,:align=>'left') + @template.content_tag(:td, date, :colspan => options[:col_span], :width => options[:width]) 
#    else
#      @template.content_tag(:td, date, :colspan => options[:col_span], :width => options[:width]) 
#    end
#  end

def sr_date(field,options = {})
    options[:label] = create_label(options[:label], field)

    td_for_colon = options[:add_colon] ? @template.content_tag(:td, ":") : ""
    label = label(field, options[:label], :class => options[:label_clas]) + td_for_colon
#     if options[:onclick]
# tag method is converting to @template.tag when we converted rails 2.2.2 to rails 3
       date =  text_field(field, options) + @template.tag(:img, {:src => "/images/calendar.png", :id => "_#{field}_link", :class => "calendar", :onclick => options[:onclick] , 

:load_id => "#{field}", :alt => "Calendar"}) +@template.content_tag(:div, nil, {:id => "_#{field}_calendar", :class => "date_picker", :style => "display:none"})

#     else
#      date =  text_field(field, options) + tag(:img, {:src => "/images/calendar.png", :id => "_#{field}_link", :class => "calendar", :load_id => "#{field}", :alt => "Calendar"}) +
#                  content_tag(:div, nil, {:id => "_#{field}_calendar", :class => "date_picker", :style => "display:none"})  
#    end
    
    if options[:label]
      @template.content_tag(:td, label,:align=>'left') + @template.content_tag(:td, date, :colspan => options[:col_span], :width => options[:width])
     else
      @template.content_tag(:td, date, :colspan => options[:col_span], :width => options[:width]) 
     end
  end
  
  
  def sr_detailed_date(field,options = {})
    options[:label] = create_label(options[:label], field)
#    options[:label] = options[:mandatory] ? options[:label] + "<span class='mandatorty_color'>*</span>" : options[:label]
    label = label(field, options[:label], :class => options[:label_clas]) + 
     date = "YY "+text_field(field.to_s,:class =>'txtfield_two_four_digits_year')+
     "MM " + text_field(field.to_s+"_months",:class =>'txtfield_two_digits_month')+ 
     "DD "+ text_field(field.to_s+"_days",:class =>'txtfield_two_digits_date')
    if options[:label]
      @template.content_tag(:td, label,:align=>'left') + @template.content_tag(:td, date, :colspan => options[:col_span], :width => options[:width]) 
    else
      @template.content_tag(:td, date, :colspan => options[:col_span], :width => options[:width]) 
    end
  end
  
  
    def sr_collection_select(field, collection, value_method, text_method, options = {}, html_options = {})
    options[:prompt] = SrTranslate.sr_t(options[:prompt]) if options[:prompt]
    options[:label] = create_label(options[:label], field, options[:mandatory])
    label = label(field, options[:label], :class => options[:label_clas])
    label = options[:mandatory] ? label : label
    if options[:div_id]
      if !options[:label].blank?
        @template.content_tag(:td, label,:align=>'left') + @template.content_tag(:td,@template.content_tag(:div , collection_select(field, collection, value_method, text_method, options, html_options),:id=>options[:div_id]),:colspan => options[:col_span])
      else
        @template.content_tag(:td, @template.content_tag(:div , collection_select(field, collection, value_method, text_method, options, html_options),:id=>options[:div_id]),:colspan => options[:col_span])
      end
    else
      if !options[:label].blank?
        @template.content_tag(:td, label,:align=>'left') + @template.content_tag(:td , collection_select(field, collection, value_method, text_method, options, html_options),:colspan => options[:col_span])  
      else
        @template.content_tag(:td , collection_select(field, collection, value_method, text_method, options, html_options),:colspan => options[:col_span])  
      end
    end
  end
#def sr_collection_select(field, collection, value_method, text_method, options = {}, html_options = {})
#    options[:prompt] = SrTranslate.sr_t(options[:prompt]) if options[:prompt]
#    options[:label] = create_label(options[:label], field, options[:mandatory])
#    label = label(field, options[:label], :class => options[:label_clas])
#    label = options[:mandatory] ? label + "<span class='mandatory_color'>*</span>".html_safe : label
#    if options[:div_id]
#      if !options[:label].blank?
#        @template.content_tag(:td, label,:align=>'left') + @template.content_tag(:td,@template.content_tag(:div , collection_select(field, collection, value_method, text_method, options, html_options),:id=>options[:div_id]),:colspan => options[:col_span])
#      else
#        @template.content_tag(:td, @template.content_tag(:div , collection_select(field, collection, value_method, text_method, options, html_options),:id=>options[:div_id]),:colspan => options[:col_span])
#      end
#    else
#      if !options[:label].blank?
#        @template.content_tag(:td, label,:align=>'left') + @template.content_tag(:td , collection_select(field, collection, value_method, text_method, options, html_options),:colspan => options[:col_span])  
#      else
#        @template.content_tag(:td , collection_select(field, collection, value_method, text_method, options, html_options),:colspan => options[:col_span])  
#      end
#    end
#  end
  
  def sr_radio_button(field, tag_value, options = {})
    @template.content_tag(:td, radio_button(field, options[:tag_vale_male], :checked=>false)+options[:control_label_1]+ radio_button(field, options[:tag_vale_female], options)+options[:control_label_2])
  end
  
  def sr_radio_button_with_label(field, tag_value, options = {})
    @template.content_tag(:td, radio_button(field, tag_value, options)+ @template.content_tag(:label, options[:label]),:colspan => options[:col_span])
  end
  
  def sr_select(field, choices, options = {}, html_options = {})
    options[:label] = create_label(options[:label], field) if options[:label]
#    options[:label] = options[:mandatory] ? options[:label] + "<span class='mandatorty_color'>*</span>" : options[:label]
    label = label(field, options[:label], :class => options[:label_clas])
    if options[:div_id]
      @template.content_tag(:td, label, :align=>'left') + @template.content_tag(:td ,@template.content_tag(:div , select(field, choices, options, html_options), :colspan => options[:col_span],:id=>options[:div_id]))
    else
      if options[:label]
        @template.content_tag(:td, label, :align=>'left') + @template.content_tag(:td , select(field, choices, options, html_options), :colspan => options[:col_span])
      else
         @template.content_tag(:td , select(field, choices, options, html_options), :colspan => options[:col_span])
      end
    end
  end
  
  def label(lab,options,*arg)
    @template.content_tag(:label,options,*arg)
  end
  
  def sr_get_lable(label,options={})
    label = options[:mandatory] ? label + "<span class='mandatorty_color'>*</span>" : label
    @template.content_tag(:td, @template.content_tag(:label, label), options)+ @template.content_tag(:td, ":")
  end
  
  def sr_label(label,options={})
    label = options[:mandatory] ? (label + "<span class='mandatorty_color'>*</span>").html_safe : label
    label = options[:bold] ? ("<b>" + label + "</b>").html_safe : label
    if options[:only_label]
      @template.content_tag(:label, label)
    else
      @template.content_tag(:td, @template.content_tag(:label, label), options)
    end
  end
  
  def sr_get_value(value,options={})
    @template.content_tag(:td, @template.content_tag(:label, value), options)
    
  end
  
  def sr_phone_number(field)
    @template.content_tag(:td, text_field(field.to_s+"_part_1",:class=>'tdfortextfield50',:value=>@part_1)+ text_field(field.to_s+"_part_2",:class=>'tdfortextfield50',:value=>@part_2, :maxlength=>8))
  end
  
  def sr_email(field,hash_1, hash_2)
    @template.content_tag(:td, text_field(field.to_s+"_local",:class=>'tdfortextfield50',:value=>@part_1)+ select(field.to_s+"_top_level_domain",hash_1,{:seleted=>@part_2},{:style=>"width:70px"})+select(field.to_s+"_domain", hash_2,{:seleted=>@part_3},:style=>"width:55px"))
  end
  
  def sr_mobile_number(field)
    @template.content_tag(:td, text_field(field.to_s+"_country_code",:class=>'tdfortextfield50',:value=>@part_1)+ text_field(field.to_s+"_service_provider_code",:class=>'tdfortextfield50',:value=>@part_2,:maxlength=>5)+ text_field(field.to_s+"_main",:class=>'tdfortextfield50',:value=>@part_3,:maxlength=>5))
  end
  
  def sr_button(field, options={})
    options[:type] = options[:type]? options[:type] : "submit"
    ("<td>"+"<input value='#{SrTranslate.sr_t(field)}' type='#{options[:type]}' id='#{options[:id]}' class='#{options[:class]}' name='#{options[:name]}' />" + "</td>").html_safe
  end

  
  def sr_hidden_field(field,options)
    @template.content_tag(:td, hidden_field(field,options))
  end
end
