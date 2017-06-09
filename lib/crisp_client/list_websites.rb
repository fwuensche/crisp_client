module ListWebsites
  # https://docs.crisp.im/api/v1/#user-user-account-websites-get
  def list_websites
    client_get("/user/account/websites")["data"]
  end

  # custom method
  def find_website_id_by_name(website_name:)
    list_websites.select{ |website| website["name"] == website_name }.first["id"]
  end
end
