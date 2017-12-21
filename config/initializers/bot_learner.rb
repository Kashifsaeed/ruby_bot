require 'bot/learner'
learner = Bot::Learner.new
Ruby_bot = learner.generate_bot
learner.train(Ruby_bot)