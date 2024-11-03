# frozen_string_literal: true

# class
class Game
  attr_accessor :word, :spaces, :lives, :wrong

  HOOK = "_\n\s|\n\s|"
  MAN = ["\sO", "\sO\n\s|", "\sO\n\\|", "\sO\n\\|/", "\sO\n\\|/\n\s|", "\sO\n\\|/\n\s|\n/",
         "\sO\n\\|/\n\s|\n/\s\\"].freeze

  def initialize
    self.word = make_word('google-10000-english-no-swears.txt', 5, 12)
    self.spaces = Array.new(word.length, '_')
    self.lives = 7
    self.wrong = []
  end

  # selects a valid word from the list of words
  def make_word(file, min, max)
    File.exist?(file) ? words = File.readlines(file) : raise('Terminating program: ***MISSING FILE***')
    words.select { |word| (word.chomp.length >= min) && (word.chomp.length <= max) }.sample.chomp
  end

  # enumerates the letters/blanks of the guesses
  def enum(letters)
    letters.reduce('') do |word, letter|
      word += "#{letter} "
      word
    end
  end

  # creates hangman picture
  def hangman
    lives == 7 ? 'BEGIN' : "#{HOOK}\n#{MAN[-1 * lives - 1].colorize(:red)}"
  end

  # displays game to user
  def display
    puts "#{enum(spaces)}\n\n#{enum(wrong).colorize(:red)}\n\n#{hangman}\n\nLIFE: #{lives}"
  end

  # ensures guesses are letters
  def guess
    print "\n\nGUESS A LETTER:\s"
    letter = gets.chomp
    letter.match?(/[a-zA-Z]/) && letter.length == 1 && !wrong.include?(letter) ? letter.downcase : guess
  end

  # checks letter and adds guess to appropriate word bank
  def check_letter(letter)
    if word.include?(letter)
      word.split('').each_with_index { |char, index| spaces[index] = char if letter == char }
    else
      self.lives -= 1
      wrong.push(letter)
    end
  end

  # checks for remaining lives or if the word is complete
  def base_case?
    if lives < 1
      puts "***GAME OVER***\n#{word.colorize(:green)}"
    elsif !spaces.include?('_')
      puts "***YOU WIN***\n#{word.colorize(:green)}"
    else
      return false
    end
    true
  end

  # the games logic for different methods
  def manage
    # base
    return if base_case?

    # recursive case
    display
    check_letter(guess)
    manage
  end
end
