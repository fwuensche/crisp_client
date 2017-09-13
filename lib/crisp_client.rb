require "crisp_client/version"
require "crisp_client/user_availability"
require "crisp_client/list_websites"
require "crisp_client/website_people"
require "crisp_client/website_conversation.rb"
require "httparty"
require "uri"

module CrispClient
  class Base
    include HTTParty
    include UserAvailability
    include ListWebsites
    include WebsitePeople
    include WebsiteConversation

    base_uri "https://api.crisp.im/v1"

    def initialize(options)
      if options[:stored_key]
        @auth = { "Authorization" => "Basic #{options[:stored_key]}" }
      else
        @email = options[:email]
        @password = options[:password]
      end
    end

    def authenticate
      res = self.class.post("/user/session/login",
        body: { email: @email, password: @password }.to_json,
        headers: { 'Content-Type' => 'application/json' })

      identifier  = res.parsed_response["data"]["identifier"]
      key         = res.parsed_response["data"]["key"]
      base64      = Base64.strict_encode64 [identifier, key].join(":")
      @auth = { "Authorization" => "Basic #{base64}" }
      return base64
    end

    private
    def client_get(path)
      self.class.get(path, headers: @auth).parsed_response
    end
  end
end
