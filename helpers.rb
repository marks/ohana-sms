def say_str(string_to_say, rate = settings.tropo_tts["rate"])
  if session[:channel] == "VOICE"
    "<speak><prosody rate='#{rate}'>#{string_to_say}</prosody></speak>"
  else
    string_to_say = string_to_say.gsub("Press","Text").gsub("press","text")
    string_to_say
  end
end

def construct_list_of_items
  say_array = []
  session[:data].each_with_index do |item,i|
    if session[:channel] == "VOICE"
      say_array << "Resource ##{i+1}: #{item[:tab_name]} at #{item[:name]}"
    else
      say_array << "##{i+1}: #{item[:tab_name]} @ #{item[:name]}"
    end
  end
  session[:channel] == "VOICE" ? say_array.join(", <break />") : say_array.join(", ")
end

def construct_details_of_item(item,channel = session[:channel])
  details = []

  details << "This is detailed information about #{item[:tab_name]} at #{item[:tab_name]}: "
  details << "Phone number for information: #{"<say-as interpret-as='vxml:phone'>" if session[:channel] == "VOICE"}#{item[:info_phone]}#{"</say-as>" if session[:channel] == "VOICE"}" unless item[:info_phone].nil?
  details << "TTY Phone number: #{"<say-as interpret-as='vxml:phone'>" if session[:channel] == "VOICE"}#{item[:tty_phone]}#{"</say-as>" if session[:channel] == "VOICE"}" unless item[:tty_phone].nil?
  # details << "Email address: #{item[:e_mail_add]}" unless item[:e_mail_add].nil?

  full_address = []
  full_address << item[:address1] unless item[:address1].nil?
  full_address << item[:address2] unless item[:address2].nil?
  full_address << item[:city] unless item[:city].nil?
  full_address << item[:state_code] unless item[:state_code].nil?

  if channel == "VOICE"
    full_address << "<say-as interpret-as='vxml:digits'>#{item[:zip_code]}</say-as>" unless item[:zip_code].nil?
  else
    full_address << item[:zip_code] unless item[:zip_code].nil?
  end
  full_address_str = full_address.join(", ")

  if item[:url]
    tinyurl = shorten_url(URI.unescape(item[:url]))
    if channel == "VOICE"
      details << "Official web page: #{readable_tinyurl(tinyurl)}"
    else
      details << "Official web page: #{tinyurl}"
    end
  end

  google_maps_url = shorten_url("http://maps.google.com/maps?f=q&source=s_q&hl=en&geocode=&q="+URI.escape(full_address_str))
  if channel == "VOICE"
    details << "This resource is located at: #{full_address.join(" ,, ")}"
    details << "Google map available at #{readable_tinyurl(google_maps_url)}"
  else
    details << "Address: #{full_address_str}"
    details << "Google map available at #{google_maps_url}"
  end

  channel == "VOICE" ? details.join(" <break/><break/> ") : details.join(" | ")
end

def shorten_url(long_url)
  short_url = open("http://tinyurl.com/api-create.php?url=#{long_url}").read.gsub(/https?:\/\//, "")
end

def readable_tinyurl(url)
  unique_url = url.split("/")[1].split(//).join(",")+","
  readable_url = "tiny u r l dot com slash #{unique_url}"
  "#{readable_url} , again, that is , #{readable_url}"
end
