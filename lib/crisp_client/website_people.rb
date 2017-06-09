module WebsitePeople
  # https://docs.crisp.im/api/v1/#website-website-people-get
  def get_people_statistics(website_id)
    client_get("/website/#{website_id}/people/stats")["data"]
  end

  # https://docs.crisp.im/api/v1/#website-website-people-get-2
  def list_people_profiles(website_id, page_number = 1)
    # TODO: accept params sort_field, sort_order, search_operator, search_filter
    client_get("/website/#{website_id}/people/profiles/#{page_number}")["data"]
  end

  # https://docs.crisp.im/api/v1/#website-website-people-post
  def add_new_people_profile(website_id, name, email)
    res = self.class.post("/website/#{website_id}/people/profile",
      body: { email: email, person: { nickname: name } }.to_json,
      headers: { 'Content-Type' => 'application/json' }.merge(@auth))

    # debugger
    if res["error"] == true
      p res
    else
      p "Person successfully created."
    end
  end
end
