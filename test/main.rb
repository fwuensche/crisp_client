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

	require_relative "./website_conversation"
end