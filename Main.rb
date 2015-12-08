class Main

	attr_accessor :papers

	#INITIALIZE
	def initialize
		# Read the documents
		@papers = Array.new
		files = Dir.glob(DIR_DOCS).select{|e|File.file? e}
		i = 0
		files.each do |file|
			require './Document'
			p = Document.new(file,"doc")
			@papers.insert(i,p)
			i += 1
		end

		# Read the descriptions
		files = Dir.glob(DIR_DESC).select{|e|File.file? e}
		files.each do |file|
			require './Document'
			p = Document.new(file,"des")
			@papers.insert(i,p)
			i += 1
		end
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
			"\t(docs)\n" +
			"\t(desc)\n" +
			"\t(acr)\n" +
			"\t(exit)\n\n"

	PROMPT = "  $: "

	BAR = "\n~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n"

	DIR_DOCS = "docsUTF8/*.xml"
	DIR_DESC = "docsUTF8/*.txt"

	# Main
	def main
		loop do
			print MENU
			print PROMPT
			sel = gets.chomp
			if sel == "exit"
				break
			elsif sel == "docs"
				show_docs
			elsif sel == "desc"
				show_desc
			elsif sel == "acr"
				show_acr
			elsif is_num? sel
				option(sel)
			else
				print "Unrecognized buffer \"#{sel}\".\n"
			end
			print " Press enter: "
			gets.chomp
			print BAR
		end
	end

	# Select option functions
	def option(sel)
		case sel.to_i
			when 1 then op1
			when 2 then op2
			when 3 then print " \#Op3: Not implemented yet\n"
			when 4 then print " \#Op4: Not implemented yet\n"
			when 5 then print " \#Op5: Not implemented yet\n"
			when 6 then print " \#Op6: Not implemented yet\n"
			when 7 then print " \#Op7: Not implemented yet\n"
			when 8 then print " \#Op8: Not implemented yet\n"
			when 9 then print " \#Op9: Not implemented yet\n"
			else print "Unrecognized buffer \"#{sel}\".\n"
		end
	end

	def is_num?(str)
		!!Integer(str) rescue false
	end

	def show_docs
		papers.each do |p|
			if p.is_doc?
				puts "#{p.to_s}"
			end
		end
	end

	def show_desc
		papers.each do |p|
			if p.is_des?
				puts "#{p.to_s}\n"
			end
		end
	end

	def show_acr
		papers.each do |p|
			puts "#{p.title}\n" + p.show_acr
		end
	end

	# Options
	def op1
		print BAR + " Year: "
		year = gets.chomp
		if is_num? year
			lista = Array.new
			i = 0
			papers.each do |p|
				if p.is_from? year.to_i
					puts p
				end
			end
		else
			print "Unrecognized buffer \"#{year}\".\n"
		end
	end

	def op2
		journals = Array.new
		i = 0
		papers.each do |p|
			journals.insert(i,p.journal) unless (p.is_des? || journals.include?(p.journal))
			i += 1
		end
		journals.each {|j| puts "\t#{j}"}
	end

end

o = Main.new
o.main