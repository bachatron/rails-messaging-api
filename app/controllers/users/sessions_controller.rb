class Users::SessionsController < Devise::SessionsController
  respond_to :json

  def destroy
    token = request.headers["Authorization"]&.split(" ")&.last
    if token
      begin
        jwt_payload = Warden::JWTAuth::TokenDecoder.new.call(token)
        jti = jwt_payload["jti"]
        exp = Time.at(jwt_payload["exp"])
        JwtDenylist.create!(jti: jti, exp: exp)
      rescue => e
        Rails.logger.error "JWT denylist error: #{e.message}"
      end
    end
    render json: { message: "Logged out successfully" }, status: :ok
  end

  private

  def respond_with(resource, _opts = {})
    render json: { user: resource }, status: :ok
  end

  def respond_to_on_destroy(resource_or_scope = nil)
    render json: { message: "Logged out successfully" }, status: :ok
  end
end
