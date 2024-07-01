require "application_system_test_case"

class GamesTest < ApplicationSystemTestCase
  test "Going to /new gives us a new random grid to play with" do
    visit new_url
    assert_selector "h1", text: "Longest Word Game"
    assert_selector "li", count: 10
  end

  test "Filling the form with a random word and submitting it" do
    visit new_url
    fill_in "word", with: "randomword"
    click_on "Submit"
    assert_text "can't be built out of the given letters"
  end

  test "Filling the form with a one-letter consonant word" do
    visit new_url
    fill_in "word", with: "z"
    click_on "Submit"
    assert_text "does not seem to be a valid English word"
  end

  test "Filling the form with a valid English word" do
    visit new_url
    fill_in "word", with: "time"
    click_on "Submit"
    assert_text "Congratulations!"
  end
end
