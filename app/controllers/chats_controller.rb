require 'bot/learner'
class ChatsController < ApplicationController
  
  def create
    query = params[:chat][:query]
    response = Ruby_bot.get_reaction(query)
    response = "Sorry! can't understand you." if response.blank?
    @chat = {query: query,reply: response}
  end

  def learn
    pattern = params[:custom][:pattern].strip
    template = params[:custom][:template]
    teach_bot(pattern,template)
  end


  private
    def teach_bot pattern,template
      Bot::Learner.teach(pattern,template,Ruby_bot)
    end
end
