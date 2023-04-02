require 'json'

class KeyboardLoader
  def self.load_keyboard
    keyboard_file = File.join(File.dirname(__FILE__), 'views', 'keyboard.json')
    if File.exist?(keyboard_file)
      keyboard = JSON.parse(File.read(keyboard_file))
    else
      keyboard = []
    end
    keyboard
  end
end