require 'telegram/bot'
require_relative 'config/config'
require_relative 'services/KeyboardLoader'
require_relative 'services/MessagesHandler'
require 'json'

Telegram::Bot::Client.run(TOKEN) do |bot|
  bot.listen do |message|
    MessagesHandler.new(bot, message).handle_message
  end
end
