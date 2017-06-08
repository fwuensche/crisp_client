module UserAvailability
  def get_user_availability
    client_get("/user/availability")["data"]["type"]
  end
end
