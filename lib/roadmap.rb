module RoadmapModule
  def get_roadmap(*chain_id)
    self.get_me if @user == nil
    chain_id = @user['current_enrollment']['chain_id'] if ARGV.empty?
    response = self.class.get(api_endpoint("roadmaps/#{chain_id}"), headers: {"content_type" => 'application/json', "authorization" => @auth_token })
    puts response.code
    puts @roadmap = JSON.parse(response.body)
  end
  def get_checkpoint(checkpoint_id)
    response = self.class.get(api_endpoint("checkpoints/#{checkpoint_id}"), headers: {"content_type" => 'application/json', "authorization" => @auth_token })
    puts response.code
    puts checkpoint = JSON.parse(response.body)
  end
  def get_remaining_checkpoints(*chain_id)
    self.get_me if @user == nil
    chain_id = @user['current_enrollment']['chain_id'] if ARGV.empty?
    response = self.class.get(api_endpoint("enrollment_chains/#{chain_id}/checkpoints_remaining_in_section"), headers: {"content_type" => 'application/json', "authorization" => @auth_token })
    puts response.code
    puts checkpoint = JSON.parse(response.body)
  end
end
