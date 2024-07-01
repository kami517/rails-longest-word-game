class GamesController < ApplicationController
  def new
    @letters = Array.new(10) { ('A'..'Z').to_a.sample }
  end

  def score
    @word = params[:word]
    @letters = params[:letters].split('')
    @included = included?(@word, @letters)
    @valid = valid_word?(@word)
    @result = result_message(@word, @included, @valid)
  end

  private

  def included?(word, letters)
    word.chars.all? { |letter| word.count(letter) <= letters.count(letter) }
  end

  def valid_word?(word)
    response = open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    json['found']
  end

  def result_message(word, included, valid)
    if included && valid
      "Congratulations! #{word.upcase} is a valid English word!"
    elsif included
      "Sorry, but #{word.upcase} does not seem to be a valid English word..."
    else
      "Sorry, but #{word.upcase} can't be built out of the given letters."
    end
  end
end
