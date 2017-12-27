class Api::V1::BaseApiController < ApplicationController
  #protect_from_forgery with: :null_session
  
  # skip token authenticity
  skip_before_action :verify_authenticity_token
end