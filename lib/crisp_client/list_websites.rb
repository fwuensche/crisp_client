module ListWebsites
  # https://docs.crisp.im/api/v1/#user-user-account-websites-get
  def list_websites
    client_get("/user/account/websites")["data"]
  end

  # custom method
  def find_website_id_by_name(website_name:)
    websites = list_websites.select{ |website| (website["name"] if website) == website_name }
    websites.any? ? websites.first["id"] : nil
  end
end
