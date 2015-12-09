class Document

	attr_reader :type, :journal, :id, :year, :title, :abstract, :sections, :acronyms

	# Rangos permisibilidad para la búsqueda de la forma expandida de los acrónimos
	R1 = 12 # standar -> 12
	R2 = 8 # standar -> 8

	def initialize(path, type)
		File.open(path,"r") do |f|
			@type = type
			# Lectura cabecera documento científico
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
			# Lectura cabecera descripciones enferemedades Wikipedia
			elsif type == "des"
				@id = f.readline.chomp
				@year = f.readline.chomp.to_i
				@title = f.readline.chomp
			else
				break
			end

			# Lectura de secciones
			@sections = Array.new
			body = f.read
			rest = body.split("--").reject{|e| (e.empty? || e == "\n") || e == "\r"}
			i = 0
			rest.each do |e|
				part = e.split("\n").reject{|e| (e.empty? || e == "\n") || e == "\r"}
				if part.empty?
					break
				end
				# read sec_title
				t = part.first
				# read sec_body
				b = part.drop(1).join
				require './Section'
				sec = Section.new(t,b)
				@sections.insert(i,sec)
				i += 1
			end
			# En caso de que haya sido descrición, asignamos resumen a introducción
			@abstract = @sections[0].body unless type == "doc"
			# Busqueda de acrónimos
			search(body)
		end
	end

	# PUBLIC METHODS
	def to_s
		aux = ""
		sections.each{|e| aux = aux + "\t\t" + e.to_s + "\n"}
		if type == "doc"
			#return	"\t(#{id}) #{journal}, #{year}.\n" + aux
			return	"--------------------------------------------------------------------\n" +
					"\tTitle: #{title} (#{year})\n" +
					"\tAbstract: #{abstract[0..180]} ...\n" +
					"\tSection number: #{sections.length}\n" +
					"\tSections:\n" + aux
		elsif type == "des"
			return	"--------------------------------------------------------------------\n" +
					"\tTitle: #{title} (#{year})\n" +
					"\tIntroduction: #{abstract[0..180]} ...\n" +
					"\tSection number: #{sections.length}\n" +
					"\tSections:\n" + aux
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

	# PRIVATE METHODS
	private

		# ACRONYMS SEARCH
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
				expand = body.scan(pattern)
				# Eliminamos duplicados y cogemos el primero
				expand.uniq!
				exp = ""
				exp = expand.first unless expand == []
				# Creamos acrónimo
				require './Acronym'
				acronym = Acronym.new(acr[0],exp[0],num[acr])
				@acronyms.insert(i,acronym)
				#print "\t#{acr[0]} -> #{exp[0]}\n"
				i += 1
			end
		end

		# Afected by R1 & R2
		def get_pat(acr)
			pattern = "[^a-zA-Z0-9]([" + acr[0] + acr[0].downcase + "][ a-zA-Z0-9]{0,#{R1}}"
			acr[1..-1].each_char do |a|
				if a == "-"
					pattern += "[" + "\\-" + "]?[ a-zA-Z0-9]{0,#{R1}}"
				else
					pattern += "[" + a + a.downcase + "][ a-zA-Z0-9]{0,#{R1}}"
				end
			end
			pattern = pattern + ")[ ][^a-zA-Z0-9]{0,#{R2}}\\(?"
			acr.each_char do |a|
				if a == "-"
					pattern += "\\-"
				else
					pattern += a
				end
			end
			pattern += "\\)"
			return pattern
		end

end