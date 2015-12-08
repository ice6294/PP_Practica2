class Document

	attr_reader :type, :journal, :id, :year, :title, :sections, :acronyms

	def initialize(path, type)
		File.open(path,"r") do |f|
			@type = type
			if type == "doc"
				@journal = ""
				@journal = f.readline.chomp
				@id = f.readline.chomp
				@year = f.readline.chomp.to_i
				f.readline
				@title = f.readline.chomp
				f.readline
				@abstract = f.readline.chomp
				f.readline
			elsif type == "des"
				@id = f.readline.chomp
				@year = f.readline.chomp.to_i
				@title = f.readline.chomp
			else
				break
			end

			@sections = Array.new
			body = f.read
			rest = body.split("--").reject{|e| (e.empty? || e == "\n") || e == "\r"}
			i = 0
			rest.each do |e|
				part = e.split("\n").reject{|e| (e.empty? || e == "\n") || e == "\r"}
				if part.empty?
					break
				end
				# read title
				t = part.first
				# read body
				b = part.drop(1).join
				require './Section'
				s = Section.new(t,b)
				@sections.insert(i,s)
				i += 1
			end
			#puts "#{@id} - #{@title}\n"
			search(body)
			#gets.chomp
		end
	end

	# Public methods
	def to_s
		aux = ""
		sections.each{|e| aux = aux + "\t\t" + e.to_s + "\n"}
		if type == "doc"
			return	"\t(#{id}) #{journal}, #{year}.\n" + aux
		elsif type == "des"
			return "\t(#{id}) #{title}, #{year}.\n" + aux
		else
			return "nothing\n"
		end
	end

	def show_acr
		aux = ""
		acronyms.each {|a| aux = aux + "\t#{a.to_s}\n"}
		return aux
	end

	def is_doc?
		return type == "doc"
	end

	def is_des?
		return type == "des"
	end

	def is_from?(year2)
		return year == year2
	end

	private

		def search(body)
			# Buscamos acrónimos
			@acronyms = Array.new
			m = /[^A-Z0-9]([A-Z]{2}[A-Z0-9\-]{0,3}[A-Z0-9]{1})[^A-Z0-9]/
			results = body.scan(m)
			# Contamos duplicados
			num = Hash.new(0)
			results.each do |acr|
				num[acr] += 1
			end
			# Eliminamos duplicados
			results.uniq!
			# Por cada acrónimo ...
			i = 0
			results.each do |acr|
				# Buscamos patrón forma expandida
				str = get_pat(acr[0])
				pattern = Regexp.new str
				# Escaneamos texto
				exp = body.scan(pattern)
				# Eliminamos duplicados
				exp.uniq!
				# Creamos acrónimo
				require './Acronym'
				acronym = Acronym.new(acr[0],exp[0],num[acr])
				@acronyms.insert(i,acronym)
				#print "\t#{acr[0]} -> #{exp[0]}\n"
				i += 1
			end
		end

		def get_pat(acr)
			pattern = "[^a-zA-Z0-9]([" + acr[0] + acr[0].downcase + "][ a-zA-Z0-9]{0,12}"
			acr[1..-1].each_char do |a|
				if a == "-"
					pattern = pattern + "[" + "\\-" + "]?[ a-zA-Z0-9]{0,12}"
				else
					pattern = pattern + "[" + a + a.downcase + "][ a-zA-Z0-9]{0,12}"
				end
			end
			pattern = pattern + ")[ ][^a-zA-Z0-9]{0,8}\\(?"
			acr.each_char do |a|
				if a == "-"
					pattern = pattern + "\\-"
				else
					pattern = pattern + a
				end
			end
			pattern = pattern + "\\)"
			#puts pattern
			return pattern
		end

end