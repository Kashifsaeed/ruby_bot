require 'programr'

brains = Dir.glob("lib/aiml/*")

Ruby_bot = ProgramR::Facade.new
Ruby_bot.learn(brains)