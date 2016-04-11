require 'minitest/autorun'
require 'minitest/pride'
require './main_game'
require './print_class'


class PrinterTest < Minitest::Test

  def test_player_is_insulted_at_start_of_game
    game = Game.new
    printer = Printer.new
    message = "You wake up in a daze. You look around. You are in the big workspace. No on is around. No sound is heard, except for a faint whisper--"
    assert_equal message, printer.greet_new_player
  end


end
