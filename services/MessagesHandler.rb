class MessagesHandler
  attr_reader :bot, :message

  def initialize(bot, message)
    @bot = bot
    @message = message
  end

  def handle_message
    case @message.text
    when '/start'
      send_custom_keyboard
    when '1'
      send_welcome
    when '2'
      send_goodbye
    when '3'
      ask_phone_number
    else
      send_custom_keyboard
    end
    bad_words(@message)
  end

  private

  def send_welcome
    bot.api.send_message(chat_id: @message.chat.id, text: "Hi, #{@message.chat.first_name}!")
  end

  def send_goodbye
    bot.api.send_message(chat_id: @message.chat.id, text: "Bye, #{@message.chat.first_name}!")
  end

  def ask_phone_number
    bot.api.send_message(chat_id: @message.chat.id, text: 'Type your phone number:')
  end

  def send_custom_keyboard
    keyboard = KeyboardLoader.load_keyboard
    buttons = keyboard.map do |button_row|
      button_row.map { |button_text| Telegram::Bot::Types::KeyboardButton.new(text: button_text) }
    end

    markup = Telegram::Bot::Types::ReplyKeyboardMarkup.new(keyboard: buttons, one_time_keyboard: false)
    bot.api.send_message(chat_id: @message.chat.id, text: "Please select a command:", reply_markup: markup)
  end

  def bad_words(message)
    russian_words = ['русня', 'росія', 'россия', 'москаль', 'кацап', 'вагнер', 'рф', 'рускій']
    bad_words = ['блять', 'сука', 'хуй']
    russian_words.each do |word|
      if message.text.include?(word)
        bot.api.send_message(chat_id: message.chat.id, text: "Русні пизда!")
        return
      end
    end
    bad_words.each do |word|
      if message.text.include?(word)
        bot.api.send_message(chat_id: message.chat.id, text: "Не матюкайся!")
        return
      end
    end
  end
end
