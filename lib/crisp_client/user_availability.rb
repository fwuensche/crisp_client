module UserAvailability
  # https://docs.crisp.im/api/v1/#user-user-availability-get
  def get_user_availability
    client_get("/user/availability")["data"]["type"]
  end
end
