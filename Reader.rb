module Reader

	extend Utils

	# Rangos permisibilidad para la búsqueda de la forma expandida de los acrónimos
	R1 = 12 # standar -> 12
	R2 = 8 # standar -> 8

	def read(dir)
		papers = Array.new
		files = Dir.glob(dir).select{|e|File.file? e}
		i = 0
		files.each do |file|
			p = read_document(file)
			papers.insert(i,p)
			i += 1
		end
		return papers
	end

	# READ DOCUMENT
	def read_document(path)
		File.open(path,"r") do |f|

			arg1 = f.readline.chomp
			arg2 = f.readline.chomp
			arg3 = f.readline.chomp

			if is_num? arg3
				# Scientific DOC
				journal = arg1[1..-1]
				id = arg2
				year = arg3.to_i
				type = "doc"

				f.readline # (--)
				title = f.readline.chomp
				f.readline # (--)
				abstract = f.readline.chomp
				f.readline # (--)
			else
				# Wikipedia DES
				id = arg1
				year = arg2.to_i
				title = arg3
				type = "des"
			end
			# Leemos el resto
			body = f.read
			# Lectura de secciones
			sections = read_sections(body)
			# En caso de que haya sido descrición, asignamos resumen a introducción
			introduction = sections[0].body unless type == "doc"
			# Búsqueda de acrónimos
			acronyms = search(body)
			# Búsqueda del acrónimo correspondiente a la enfermdad
			disease = get_disease(title,acronyms) unless type == "doc"

			#Devolvemos el Documento
			if type == "doc"
				require './Scientific'
				return Scientific.new(journal, id, year, title, abstract, sections, acronyms, type)
			else
				require './Description'
				return Description.new(id, year, title, disease, introduction, sections, acronyms, type)
			end
		end
	end

	private

		# READ SECTIONS
		def read_sections(body)
			sections = Array.new
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
				sections.insert(i,sec)
				i += 1
			end
			return sections
		end

		# ACRONYMS SEARCH
		def search(body)
			# Buscamos acrónimos
			acronyms = Array.new
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
				acronyms.insert(i,acronym)
				#print "\t#{acr[0]} -> #{exp[0]}\n"
				i += 1
			end
			return acronyms.sort! { |a,b| (a.num <=> b.num)*-1 }
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

		def get_disease(title, acronyms)
			found = false
			acronyms.each do |a|
				if title == a.exp
					return a
				end
			end
			return Acronym.new(title,"",0)
		end

end