module WebsiteConversation
  # https://docs.crisp.chat/api/v1/#website-website-conversation-post
	def create_a_new_conversation(website_id:)
    response = self.class.post("/website/#{website_id}/conversation",
      headers: { 'Content-Type' => 'application/json' }.merge(@auth))

    if response["error"] == false
      return response["data"]
    else
      raise response["reason"]
    end
	end

	# https://docs.crisp.chat/api/v1/#website-website-conversation-patch-4
  def update_conversation_metas(website_id:, session_id:, meta:)
    response = self.class.patch("/website/#{website_id}/conversation/#{session_id}/meta",
      body: meta.to_json,
      headers: { 'Content-Type' => 'application/json' }.merge(@auth))
    
    unless response.nil? && response["error"] == true
      return response["data"]
    else
      raise response["reason"]
    end
  end
end
