require 'programr'
module Bot
  class Learner
    
    def initialize
      @aiml_files = Dir.glob("lib/aiml/*")
    end

    def generate_bot
      ProgramR::Facade.new
    end

    # learner.train Ruby_bot
    def train(bot)
      bot.learn(@aiml_files)
    end

    # learner = Bot::Learner.new
    # learner.append_answer("Experience","5 years")
    def append_answer(pattern,template)
      # add new category in custom answers
      custom_path = "#{Rails.root}/lib/aiml/custom_answers.aiml"
      new_category = <<-CATEGORY
    <category>
      <pattern>#{pattern}</pattern>
      <template>
        #{template}
      </template>
    </category>
  </aiml>
CATEGORY

      # remove last empty line
      file = File.open(custom_path)
      File.write(file, File.readlines(file).reject { |s| s.strip.empty? || s=="\n" }.join)
      file.close
      # read lines, and replace last line
      lines = File.readlines(custom_path)
      lines[-1] = new_category << $/
      File.open(custom_path, 'w') { |f| f.write(lines.join); f.close }
    end

    def self.teach pattern,template,bot
      bot_learner = Bot::Learner.new
      bot_learner.append_answer(pattern,template)
      bot_learner.train(bot)
    end
  end
end