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
      say_array << "Resource ##{i+1}: #{item[:kind]} at #{item[:name]}"
    else
      say_array << "##{i+1}: #{item[:kind]} @ #{item[:name]}"
    end
  end
  session[:channel] == "VOICE" ? say_array.join(", <break />") : say_array.join(", ")
end

def construct_details_of_item(item,channel = session[:channel])
  details = []

  details << "This is detailed information about #{item[:name]} at #{item[:name]}: "
  details << item[:short_desc] unless item[:short_desc].nil?
  details << "Phone number: #{"<say-as interpret-as='vxml:phone'>" if session[:channel] == "VOICE"}#{item[:phones][0][:number]}#{"</say-as>" if session[:channel] == "VOICE"}" unless item[:phones].empty?
  # details << "Email address: #{item[:e_mail_add]}" unless item[:e_mail_add].nil?

  full_address = []
  unless item[:address].nil?
    full_address << item[:address][:street] unless item[:address][:street].nil?
    full_address << item[:address][:city] unless item[:address][:city].nil?
    full_address << item[:address][:state] unless item[:address][:state].nil?

    if channel == "VOICE"
      full_address << "<say-as interpret-as='vxml:digits'>#{item[:address][:zip]}</say-as>" unless item[:address][:zip].nil?
    else
      full_address << item[:address][:zip] unless item[:address][:zip].nil?
    end
    full_address_str = full_address.join(", ")
  end

  unless item[:urls].empty?
    tinyurl = shorten_url(URI.unescape(item[:urls][0]))
    if channel == "VOICE"
      details << "Official web page: #{readable_tinyurl(tinyurl)}"
    else
      details << "Official web page: #{tinyurl}"
    end
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
