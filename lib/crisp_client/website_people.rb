module WebsitePeople
  # https://docs.crisp.im/api/v1/#website-website-people-get
  def get_people_statistics(website_id:)
    client_get("/website/#{website_id}/people/stats")["data"]
  end

  # https://docs.crisp.im/api/v1/#website-website-people-get-2
  def list_people_profiles(website_id:, page_number: 1, sort_field: "active", sort_order: "descending", search_operator: "or", search_filter: "")
    #The way to use the "search_filter" parameter isn't documented in the CRISP docs
    #i've obtained this information by intercepting the HTTP request made when you use the dashboard to search for profiles
    #You can view this information by using the "network" section in your devtools of choice. 
    #The "list_people_profiles" is what's used when you search for something in the dashboard, thus, it makes several requests using your parameter.
    
    filter = [{"model":"people","criterion":"email","operator":"has","query":["#{search_filter}"]},
              {"model":"people","criterion":"segments","operator":"has","query":["#{search_filter}"]},
              {"model":"people","criterion":"company.name","operator":"has","query":["#{search_filter}"]},
              {"model":"people","criterion":"company.legal_name","operator":"has","query":["#{search_filter}"]},
              {"model":"people","criterion":"person.nickname","operator":"has","query":["#{search_filter}"]},
              {"model":"people","criterion":"person.address","operator":"has","query":["#{search_filter}"]},
              {"model":"people","criterion":"person.employment.name","operator":"has","query":["#{search_filter}"]},
              {"model":"people","criterion":"person.geolocation.city","operator":"has","query":["#{search_filter}"]},
              {"model":"people","criterion":"person.geolocation.country","operator":"has","query":["#{search_filter}"]}]
    
    filter = filter.to_json
    filter = URI.encode(filter.to_s)
    filter = filter.gsub(/\[/, "%5B").gsub(/\]/, "%5D")

    response = client_get("/website/#{website_id}/people/profiles/#{page_number}?search_filter=#{filter}&search_operator=#{search_operator}&sort_field=#{sort_field}&sort_order=#{sort_order}")
    if response["data"].empty?
      return nil 
    elsif response["error"] == false
      return response["data"]
    else
      raise response["reason"]
    end
  end

  # https://docs.crisp.im/api/v1/#website-website-people-post
  def add_new_people_profile(website_id:, nickname:, email:)
    response = self.class.post("/website/#{website_id}/people/profile",
      body: { email: email, person: { nickname: nickname } }.to_json,
      headers: { 'Content-Type' => 'application/json' }.merge(@auth))

    if response["error"] == false
      return response["data"]["people_id"]
    else
      raise response["reason"]
    end
  end

  # https://docs.crisp.im/api/v1/#website-website-people-delete
  def remove_people_profile(website_id:, people_id:)
    response = self.class.delete("/website/#{website_id}/people/profile/#{people_id}",
      headers: { 'Content-Type' => 'application/json' }.merge(@auth))
    return response["reason"]
  end

  # https://docs.crisp.chat/api/v1/#website-website-people-put-1
  def save_people_data(website_id:, people_id:, user_data:)
    response = self.class.put("/website/#{website_id}/people/data/#{people_id}",
      body: user_data.to_json,
      headers: { 'Content-Type' => 'application/json' }.merge(@auth))
    
    if response["data"].empty?
      return nil 
    elsif response["error"] == false
      return response["data"]
    else
      raise response["reason"]
    end
  end

  #https://docs.crisp.chat/api/v1/#website-website-people-patch
  def update_people_profile(website_id:, people_id:, profile_data:)
    response = self.class.patch("/website/#{website_id}/people/profile/#{people_id}",
      body: profile_data.to_json,
      headers: { 'Content-Type' => 'application/json' }.merge(@auth))
    
    unless response.nil? && response["error"] == true
      return response["data"]
    else
      raise response["reason"]
    end
  end
end

