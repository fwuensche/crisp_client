require 'test/unit'
require 'httparty'
require 'crisp_client'


class TestWebsiteConversation < Test::Unit::TestCase
	include CrispClient
	def test_authentication
		assert_not_nil ENV['CRISP_EMAIL'], 'You must set an e-mail as a $CRISP_EMAIL environment variable, ex: CRISP_EMAIL="my@email.com"'
		assert_not_nil ENV['CRISP_PASSWORD'], 'You must set a password as a $CRISP_PASSWORD environment variable, ex: CRISP_PASSWORD="Mypassword"'
		assert_not_nil ENV['CRISP_WEBSITE_NAME'], 'You must set a website name as a $CRISP_WEBSITE_NAME environment variable, ex: CRISP_WEBSITE_NAME="MySite"'
		
		@@cclient = CrispClient::Base.new(email: ENV['CRISP_EMAIL'], password: ENV['CRISP_PASSWORD'])
		@@cclient.authenticate	
		@@website_id = @@cclient.find_website_id_by_name(website_name: ENV['CRISP_WEBSITE_NAME'])

		assert_not_nil @@website_id
		assert_not_nil @@cclient
	end

	def test_create_a_conversation
		@@session_id = @@cclient.create_a_new_conversation(website_id: @@website_id)["session_id"]
		assert_not_nil @@session_id, 'Could not create a new conversation.'
	end
	
	def test_update_conversation_metas
		assert_not_nil @@session_id, "You must provide a session ID. Current session_id value: #{@@session_id}"
		response = @@cclient.update_conversation_metas website_id: @@website_id, session_id: @@session_id, meta: 
									{nickname: "11test", email: "11test@t11.com", segments: ["test11"], 
									data: {type: "test11", signup: "test11"}}
		assert_not_nil response, "Current response value: #{response}, session_id: #{@@session_id}"
	end

	def test_find_person_by_email
		response = @@cclient.list_people_profiles website_id: @@website_id,search_operator: "eq", search_filter: {model: "people", criterion: "email", operator: "eq", query: "lestat1700_2@hotmail.com"}
		assert_not_nil response, "Current response value: #{response}"
	end
end