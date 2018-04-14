module RoadmapModule
  def get_roadmap(chain_id)
    response = self.class.get(api_endpoint("roadmaps/#{chain_id}"), headers: {"content_type" => 'application/json', "authorization" => @auth_token })
    roadmap = JSON.parse(response.body)
  end
  def get_checkpoint(checkpoint_id)
    response = self.class.get(api_endpoint("checkpoints/#{checkpoint_id}"), headers: {"content_type" => 'application/json', "authorization" => @auth_token })
    checkpoint = JSON.parse(response.body)
  end
  def get_remaining_checkpoints(chain_id)
    response = self.class.get(api_endpoint("enrollment_chains/#{chain_id}/checkpoints_remaining_in_section"), headers: {"content_type" => 'application/json', "authorization" => @auth_token })
    checkpoint = JSON.parse(response.body)
  end
end
