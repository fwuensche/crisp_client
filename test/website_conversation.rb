def test_create_a_conversation
	conversation_id = @@cclient.create_a_new_conversation(website_id: @@website_id)
	assert_not_nil conversation_id, 'Could not create a new conversation.'
	puts conversation_id
end