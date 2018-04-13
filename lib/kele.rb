require 'httparty'
require 'json'

class Kele
  include JSON
  include HTTParty
    def initialize(email, password)
      response = self.class.post(api_endpoint("sessions"), body: { "email": email, "password": password })
      raise "Email or password was incorrect" if response.code === 401
      @auth_token = response["auth_token"]
      puts response.code
    end
    def get_me
      response = self.class.get(api_endpoint("users/me"), headers: { "authorization" => @auth_token })
      puts response.code
      puts @user = JSON.parse(response.body)
    end
  private
    def api_endpoint(endpoint)
      "https://www.bloc.io/api/v1/#{endpoint}"
    end

end