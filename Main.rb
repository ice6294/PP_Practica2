class Main

	#INITIALIZE
	def initialize

	end

	# CONSTANTS
	MENU =	"\n What do you want to do?\n\n" +
			"\t1) Show titles of the articles (alphabetically ordered) published in one year.\n" +
			"\t2) Show magazines where all the articles in the collection were published.\n" +
			"\t3) Search acronym in the articles and show the titles of the ones that have it.\n" +
			"\t4) Show titles of the articles published in a given journal that contains a given acronym.\n" +
			"\t5) Show acronyms from the articles published in a given year.\n" +
			"\t6) Show acronyms with the numer of times that appears in an article from a given ID.\n" +
			"\t7) Show all IDs and titles of the articles without any acronyms.\n" +
			"\t8) Show all information from all articles.\n" +
			"\t9) Cluster articles related to the same ilness/topic.\n" +
			#"\t(all) -> Show one by one all the articles with the acronyms.\n"  +
			#"\t(top) -> Show most used acronyms of the articles.\n" +
			#"\t(mode)\n" +
			"\t(exit)\n\n"

	PROMPT = "  $: "

	BAR = "\n~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n"

	DIR = "/papersUTF8/*"

	# Main
	def main
		loop do
			print MENU
			print PROMPT
			sel = gets.chomp
			if sel == "exit"
				break
			elsif is_num?(sel)
				option(sel)
			else
				print "Unrecognized buffer \"#{sel}\".\n"
			end
			print BAR
		end
	end

	# Select option functions
	def option(sel)
		case sel.to_i
			when 1 then print "\#Op1: Not implemented yet\n"
			when 2 then print "\#Op2: Not implemented yet\n"
			when 3 then print "\#Op3: Not implemented yet\n"
			when 4 then print "\#Op4: Not implemented yet\n"
			when 5 then print "\#Op5: Not implemented yet\n"
			when 6 then print "\#Op6: Not implemented yet\n"
			when 7 then print "\#Op7: Not implemented yet\n"
			when 8 then print "\#Op8: Not implemented yet\n"
			when 9 then print "\#Op9: Not implemented yet\n"
			else print "Unrecognized buffer \"#{sel}\".\n"
		end

	end

	def is_num?(str)
		!!Integer(str) rescue false
	end

	# Opions
	def op1()
	end

end

o = Main.new
o.main