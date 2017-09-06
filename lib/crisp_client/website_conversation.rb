module WebsiteConversation
	# https://docs.crisp.chat/api/v1/#website-website-conversation-post
	def create_a_new_conversation
		client_get("/website/#{website_id}/conversation")["data"]
<<<<<<< HEAD
	end
end
=======
	end
>>>>>>> 63ebf9e81eabcd0515f3899a1c4a543def2b228b
