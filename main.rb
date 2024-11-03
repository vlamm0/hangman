# frozen_string_literal: true

# dependencies

require 'colorize'
require 'rubocop'
require 'yaml'
require_relative 'lib/game'

# gets users preference on opening existing save file
def open_save?
  print "press Y if you want to open saved game \nN for new game:"
  selection = gets.chomp.downcase
  open_save? unless %w[y n].include?(selection)
  selection == 'y' ? YAML.safe_load(File.read('./save.yml'), permitted_classes: [Game]) : Game.new
end

# optionally loads save file or creates a new game if no save exists
def load_game(select)
  select ? open_save? : Game.new
end

# MAIN
game = load_game(File.exist?('save.yml'))
game.manage
