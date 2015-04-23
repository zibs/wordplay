class Textblock < ActiveRecord::Base
	validates :content, presence: true

	SENTENCE_ENDING_PUNCTUATION_MARKS = ["?", "!", "."]

	def content=(content)
		write_attribute(:content, content.strip)
	end

	def garblize
		content.split("").shuffle.join
	end

	def count_words
		content.split.length
	end

	def count_letters
		content.gsub(" ", "").size
	end

	def palindrome?
		content = content.reverse
	end

	def most_frequently_used_words
		word_count = {}
		word_set = []
		content.split(/\W/).each do |word|
			word_count[word] ||= 0
			word_count[word] += 1
		end
		most_common_word = word_count.reject { |word, seen| word.size <  3}.sort_by { |word, seen| -seen }
		most_common_word[0..5].each do |(x, y)| 
			word_set<<"#{x}: #{y}"  
		end

		word_set[0..5].join("<br>").html_safe

	end



	def longest_word		
		content.split(/\W/).sort_by(&:length).last
	end

	def longest_sentence
		longest_sentence = ""
		beginning_sentence_index = 0
		current_index = -1

		content.each_char do |character|
			current_index += 1
			if SENTENCE_ENDING_PUNCTUATION_MARKS.include?(character)
				#puts "at character: #{character}"
				next_two_characters = content[current_index + 1, 2]
				#puts "next two characters: #{next_two_characters}"
				# puts "satisfied: #{next_two_characters[0] == " " && !('a'..'z').cover?(next_two_characters[1])}"
				next unless /\s/.match(next_two_characters[0]) && !('a'..'z').cover?(next_two_characters[1])

				sentence_length = (current_index - beginning_sentence_index) + 1
				
				if sentence_length > longest_sentence.length
					longest_sentence = content[beginning_sentence_index..current_index]
					#puts "beginning sentence index: #{beginning_sentence_index}"
					#puts "curernt index: #{current_index}"
					#puts "longest sentence: #{longest_sentence}"
				end
				beginning_sentence_index = current_index + 1
			end
		end
		longest_sentence.strip
	end

	def most_frequently_used_letters
		letter_count = {}
		letter_set = []

		content.downcase.split("").each do |letter|
			letter_count[letter] ||= 0
			letter_count[letter] += 1
		end

		five_frequent_letters = letter_count.reject { |letter, seen| letter == " "}.sort_by{ |letter, seen| -seen }
		five_frequent_letters[0..5].each do | (x, y) |
				letter_set<<"#{x}: #{y}"  
		end

		letter_set[0..5].join("<br>").html_safe


	end



	def number_of_sentences
		sentences = 0
		current_index = -1
		beginning_sentence_index = 0

		content.each_char do |character| 
			current_index += 1
			if SENTENCE_ENDING_PUNCTUATION_MARKS.include?(character) 
				next_two_characters = content[current_index + 1..current_index + 2]
				next unless /\s/.match(next_two_characters[0]) && !/[a-z]/.match(next_two_characters[1])

				beginning_sentence_index = current_index + 1
				sentences += 1
			end
		end
		if SENTENCE_ENDING_PUNCTUATION_MARKS.include?(content.last)
			sentences = sentences +1
		end
		sentences
	end

end
