
# creates a list of words from file, with character restraints
def make_wordbank(file, min, max)
  File.exist?(file) ? words = File.readlines(file) : raise("Terminating program: ***MISSING FILE***")
  word_list = words.select {|word| (word.chomp.length >= min) && (word.chomp.length <= max)} 
end

word_bank = make_wordbank("google-10000-english-no-swears.txt", 5, 12)
puts word_bank