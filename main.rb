# frozen_string_literal: true

require 'colorize'
require 'rubocop'
require_relative 'lib/game'

# # creates a list of words from file, with character restraints
# def make_wordbank(file, min, max)
#   File.exist?(file) ? words = File.readlines(file) : raise("Terminating program: ***MISSING FILE***")
#   word_list = words.select {|word| (word.chomp.length >= min) && (word.chomp.length <= max)}
# end

# word_bank = make_wordbank("google-10000-english-no-swears.txt", 5, 12)
# #puts word_bank
game = Game.new
puts game.word
game.display
game.guess
# hangman = ["\sO", "\sO\n\s|", "\sO\n\\|", "\sO\n\\|/", "\sO\n\\|/\n\s|", "\sO\n\\|/\n\s|\n/", "\sO\n\\|/\n\s|\n/\s\\"]
