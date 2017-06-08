module WebsitePeople
  def get_people_statistics(website_id)
    client_get("/website/#{website_id}/people/stats")["data"]
  end
end
