class Api::V1::UsersController < ApplicationController
  before_action :authenticate_api_v1_user!
  before_action :set_users

  def index
    render_success(200, nil, { data: format_users(@users) } )
  end

  private

    def set_users
      @users = current_api_v1_user.admin? ? User.all : [current_api_v1_user]
    end
    
    def format_users(users)
      resp = users.map { |user| user.attributes.slice( 'first_name', 'last_name', 'email' ) }
    end
end
