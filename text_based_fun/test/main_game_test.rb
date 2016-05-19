require 'minitest/autorun'
require 'minitest/pride'
require './main_game'

class MainGameTest < Minitest::Test

  def test_player_is_greeted #prolly need to just do unit tests
    game = Game.new
    message = say("Whisper", "hello")
  end


end
