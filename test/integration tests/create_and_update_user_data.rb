require 'test/unit'
require 'httparty'
require 'crisp_client'

class TestWebsiteConversation < Test::Unit::TestCase
	include CrispClient

	def test_authentication
		assert_not_nil ENV['CRISP_EMAIL'], 'You must set an e-mail as a $CRISP_EMAIL environment variable, ex: CRISP_EMAIL="my@email.com"'
		assert_not_nil ENV['CRISP_PASSWORD'], 'You must set a password as a $CRISP_PASSWORD environment variable, ex: CRISP_PASSWORD="Mypassword"'
		assert_not_nil ENV['CRISP_WEBSITE_NAME'], 'You must set a website name as a $CRISP_WEBSITE_NAME environment variable, ex: CRISP_WEBSITE_NAME="MySite"'
		
		@@cclient = CrispClient::Base.new email: ENV['CRISP_EMAIL'], password: ENV['CRISP_PASSWORD']
		@@cclient.authenticate	
		@@website_id = @@cclient.find_website_id_by_name website_name: ENV['CRISP_WEBSITE_NAME']
		assert_not_nil @@website_id
		assert_not_nil @@cclient
	end

	def test_create_a_conversation
		@@session_id = @@cclient.create_a_new_conversation( website_id: @@website_id )["session_id"]
		assert_not_nil @@session_id, 'Could not create a new conversation.'
	end
	
	def test_find_person_by_email
		response = @@cclient.list_people_profiles( website_id: @@website_id, search_filter: "test@email.com" )
		response = Hash[*response]
		@@people_id = response["people_id"]
		
		assert_not_nil @@people_id, "Current response value: #{@@people_id}"
	end

  def test_update_people_profile
  	assert_not_nil @@people_id, "You must provide a person ID."
  	
  	response = @@cclient.update_people_profile website_id: @@website_id, people_id: @@people_id, 
  								profile_data: { person: { phone: "9999-9999", nickname: "test nickname 2", 
  																					address: "rua teste 99t", website: "http://teste.com"},
  																segments: ["segmento 4", "segmento 3"], 
  																company: { name: "Empresa teste" },
  																geolocation: { city: "Cidade teste" } }
 
  	assert_not_nil response, "Current response value: #{response}, person: #{@@people_id}"
  end

	def test_update_conversation_metas
		assert_not_nil @@session_id, "You must provide a session ID. Current session_id value: #{@@session_id}"

		response = @@cclient.update_conversation_metas website_id: @@website_id, session_id: @@session_id, 
									meta: { nickname: "test nickname", email: "test@email.com", phone: "9999-9999", 
													address: "rua teste 99t", segments: ["segmento 1", "segmento 2"], 
									data: { teste_data: "data_teste_3", valorArbitrario: "teste arbitrário 3" } }

		assert_not_nil response, "Current response value: #{response}, session_id: #{@@session_id}"
	end
end