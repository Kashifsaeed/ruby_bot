require 'bot/learner'
class Api::V1::ChatsController < Api::V1::BaseApiController
  
  

  ###########################################
  ## url: /api/v1/chats
  ## method: POST
  ## returns chat hash
  ## @params: params[:chat][:query] = "Hi"
  ############################################
  def create
    query = params[:chat][:query]
    response = Ruby_bot.get_reaction(query)
    response = "Sorry! can't understand you." if response.blank?
    chat = {error: false,query: query,reply: response}
    render json: chat, status: :ok
  end


  ###########################################
  ## url: /api/v1/chats/learn
  ## method: POST
  ## returns json hash
  ## @params: params[:chat][:pattern] = "There?"
  ## @params: params[:chat][:template] = "Yes"
  ############################################
  def learn
    begin
      pattern = params[:chat][:pattern].strip
      template = params[:chat][:template]
      teach_bot(pattern,template)
      response = {error: false,message: "Bot is trained."}
      render json: response,status: :ok
    rescue Exception => e
      response = {error: true,message: e.message}
      render json: response,status: :unprocessable_entity    
    end
  end


  private
    def teach_bot pattern,template
      Bot::Learner.teach(pattern,template,Ruby_bot)
    end
end