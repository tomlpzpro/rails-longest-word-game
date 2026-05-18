require "json"
require "open-uri"

class GamesController < ApplicationController
  def new
    @letters = Array.new(10) { ("A".."Z").to_a.sample }
  end

  def score
    word = params[:word].upcase
    letters = params[:letters].split

    word_buildable = word.chars.all? { |letter| word.chars.count(letter) <= letters.count(letter) }

    url = "https://dictionary.lewagon.com/#{word}"
    response_serialized = URI.parse(url).read
    response = JSON.parse(response_serialized)

    word_english = response["found"]   # true ou false selon l'API

    if word_buildable == false
      @message = "Sorry but #{word} can't be built out of #{letters}"
    elsif word_english == false
      @message = "Sorry but #{word} doesn't seem to be a valid English word"
    else
      @message = "Congrats! #{word} is a valid English word"
    end
  end
end
