load './Utils.rb'
load './Reader.rb'

class Main

	include Utils, Reader

	attr_accessor :papers

	def initialize
		@papers = read(DIR)
	end

	OP = ['','op1','op2','op3','op4','op5','op6','op7','op8','op9', 'op10']


	# MAIN
	def main
		system 'clear'
		print BAR
		loop do
			print MENU
			print PROMPT
			sel = gets.chomp
			print BAR
			if sel == "exit"
				break
			elsif sel == "complete"
				complete
			elsif sel == "docs"
				show_docs
			elsif sel == "desc"
				show_desc
			elsif sel == "all"
				show_all
			elsif sel == "top"
				#show_acr
			elsif is_num? sel
				option(sel)
			else
				print "Unrecognized buffer \"#{sel}\".\n"
			end
			print " \nPress enter: "
			gets
			system 'clear'
			print BAR
		end
	end



	# SELECT OPCIONS
	def option(sel)
		if (sel.to_i < 1 || sel.to_i > 10)
			print "\#Error: option #{sel} doesn't exist.\n"
		else
			send(OP[sel.to_i])
		end
	end

	def complete
		for i in 0..papers.length-1
			print "..."
			papers[i].acronyms.each do |acr1|
				for j in 0..papers.length-1
					papers[j].acronyms.each do |acr2|
						if acr1.acr == acr2.acr.chomp
							if (acr1.exp == nil && acr2.exp != nil)
								acr1.exp = acr2.exp
							elsif (acr1.exp != nil && acr2.exp == nil)
								acr2.exp = acr1.exp
							end
						end
					end
				end
			end
		end
		puts
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

	def show_all
		i = 0
		while (i < papers.length) && (i >= 0)
			system 'clear'
			print "(#{i}) "
			print papers[i].all
			print "prev(p) / next(n) / (stop) / n  $ "
			sel = gets.chomp
			if (sel == "p")
				i -= 1
			elsif (sel == "n" || sel == "")
				i += 1
			elsif (sel == "stop")
				i = -1
			elsif (is_num? sel)
				i = sel.to_i
			else
				print "Unrecognized buffer \"#{sel}\".\n"
				print " \nPress enter: "
				gets
			end
		end
	end



	# OPTIONS
	def op1
		print " Year: "
		year = gets.chomp
		if is_num? year
			i = 0
			aux = papers.sort{|a,b| a.title <=> b.title }
			aux.each do |p|
				if p.is_from? year.to_i
					puts "\t> " + p.show
				end
			end
		else
			print "Unrecognized buffer \"#{year}\".\n"
			print " \nPress enter: "
			gets
		end
	end

	def op2
		journals = Array.new
		i = 0
		papers.each do |p|
			if (p.is_doc? && !journals.include?(p.journal))
				journals.insert(i,p.journal)
				i += 1
			end
		end
		journals.each {|j| puts "\t> #{j}"}
	end

	def op3
		print " Acroynm: "
		acronym = gets.chomp
		papers.each do |p|
			if p.contains(acronym)
				puts "\t> " + p.show
			end
		end
	end

	def op4
		print " Journal: "
		journal = gets.chomp
		print " Acroynm: "
		acronym = gets.chomp
		papers.each do |p|
			if (p.is_doc? && p.journal == journal && p.contains(acronym))
				puts "\t> " + p.show
			end
		end
	end

	def op5
		print " Year: "
		year = gets.chomp
		papers.each do |p|
			if p.is_from? year.to_i
				puts p.show_acr
			end
		end
	end

	def op6
		print " ID: "
		id = gets.chomp
		papers.each do |p|
			if p.is_id? id
				puts p.show_acr_num
			end
		end
	end

	def op7
		papers.each do |p|
			if p.has_acr?
				puts "\t> #{p.title} (#{p.id})"
			end
		end
	end

	def op8
		print " Acroynm: "
		acronym = gets.chomp
		papers.each do |p|
			if (p.contains(acronym))
				puts p
			end
		end
	end

	def op9
		
	end

end



o = Main.new
o.main