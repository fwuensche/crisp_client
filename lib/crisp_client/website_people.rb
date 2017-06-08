module WebsitePeople
  def get_people_statistics(website_id)
    client_get("/website/#{website_id}/people/stats")["data"]
  end

  def list_people_profiles(website_id, page_number = 1)
    client_get("/website/#{website_id}/people/profiles/#{page_number}")["data"]
  end
end
