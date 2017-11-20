require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = Array.new(9) { [*("A".."Z")].sample }
  end

  def score
    @userinput = params[:userinput]
    @current_game_letters = params[:current_game_letters]

    if @userinput.upcase.chars.all? { |char| @current_game_letters.count(char) >= @userinput.upcase.chars.count(char)}
      url = "https://wagon-dictionary.herokuapp.com/#{@userinput.downcase}"
      response = open(url).read
      answer_hash = JSON.parse(response)
        if answer_hash["found"] === true
          @result = "valid"
        else
          @result = "unvalid"
        end
    else
      @result = "unscope"
    end
  end
end
