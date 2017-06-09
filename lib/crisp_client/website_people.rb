module WebsitePeople
  # https://docs.crisp.im/api/v1/#website-website-people-get
  def get_people_statistics(website_id:)
    client_get("/website/#{website_id}/people/stats")["data"]
  end

  # https://docs.crisp.im/api/v1/#website-website-people-get-2
  def list_people_profiles(website_id:, page_number: 1, sort_field: "nickname", sort_order: "ascending")
    # TODO: accept params sort_field, sort_order, search_operator, search_filter
    client_get("/website/#{website_id}/people/profiles/#{page_number}?sort_order=#{sort_order}")["data"]
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
end
