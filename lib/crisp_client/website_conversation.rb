module WebsiteConversation
	# https://docs.crisp.chat/api/v1/#website-website-conversation-post
	def create_a_new_conversation
		client_get("/website/#{website_id}/conversation")["data"]
	end