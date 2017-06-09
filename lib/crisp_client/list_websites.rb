module ListWebsites
  def list_websites
    client_get("/user/account/websites")["data"]
  end

  # def list_websites_ids
  #   list_websites.map{ |website| website["id"] }
  # end
  #
  # def find_website_by_name name
  #   list_websites.select{ |website| website["name"] == name }.first
  # end

  def find_website_id_by_name(website_name:)
    list_websites.select{ |website| website["name"] == website_name }.first["id"]
  end
end
