# frozen_string_literal: true

# class
class Game
  attr_accessor :word, :spaces, :lives

  HOOK = "_\n\s|\n\s|"
  MAN = ["\sO", "\sO\n\s|", "\sO\n\\|", "\sO\n\\|/", "\sO\n\\|/\n\s|", "\sO\n\\|/\n\s|\n/",
         "\sO\n\\|/\n\s|\n/\s\\"].freeze

  def initialize
    self.word = make_wordbank('google-10000-english-no-swears.txt', 5, 12).sample.chomp
    self.spaces = Array.new(word.length, '_')
    self.lives = -1
  end

  def make_wordbank(file, min, max)
    File.exist?(file) ? words = File.readlines(file) : raise('Terminating program: ***MISSING FILE***')
    words.select { |word| (word.chomp.length >= min) && (word.chomp.length <= max) }
  end

  def blanks
    spaces.reduce('') do |word, space|
      word += "#{space} "
      word
    end
  end

  def hangman
    lives == -1 ? HOOK : "#{HOOK}\n#{MAN[lives].colorize(:red)}"
  end

  def display
    puts "#{blanks}\n\n#{hangman}\n\nLIFE: #{6 - lives}"
  end

  def guess
    puts "\n\nGUESS A LETTER"
    letter = gets.chomp
    letter.match?(/[a-zA-Z]/) && letter.length == 1 ? letter.downcase : guess
  end
end
