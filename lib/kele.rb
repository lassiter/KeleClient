require './lib/roadmap'
require 'httparty'
require 'json'

class Kele
  include JSON
  include HTTParty
  include RoadmapModule
    attr_reader :user, :mentor_availablity, :roadmap, :checkpoint
    def initialize(email, password)
      response = self.class.post(api_endpoint("sessions"), body: { "email": email, "password": password })
      raise "Email or password was incorrect" if response.code === 401
      @auth_token = response["auth_token"]
    end
    def get_me
      response = self.class.get(api_endpoint("users/me"), headers: {"authorization" => @auth_token })
      user = JSON.parse(response.body)
    end
    def get_mentor_availability(mentor_id)
      response = self.class.get(api_endpoint("mentors/#{mentor_id}/student_availability"), headers: {"authorization" => @auth_token })
      mentor_availablity = JSON.parse(response.body)
    end
    def get_messages(page = nil)
      if page == nil
        response = self.class.get(api_endpoint("message_threads"), headers: { "authorization" => @auth_token})
      else
        response = self.class.get(api_endpoint("message_threads?page=#{page}"), headers: { "authorization" => @auth_token })
      end
      messages = JSON.parse(response.body)
    end
    def create_message(user_email, recipient_id, subject, token, stripped_text)
      response = self.class.post(api_endpoint("messages"), body: { "sender": user_email, "recipient_id": recipient_id, "token": token, "subject": subject, "stripped-text": stripped_text }, headers: {"authorization" => @auth_token })
    end
  private
    def api_endpoint(endpoint)
      "https://www.bloc.io/api/v1/#{endpoint}"
    end

end