class Document

	attr_reader :id, :year, :title, :sections, :acronyms, :type

	def initialize (id, year, title, sections, acronyms, type)
		@id = id
		@year = year
		@title = title
		@sections = sections
		@acronyms = acronyms
		@type = type
	end

	public

		# BOOL METHODS
		def is_doc?
			return type == "doc"
		end

		def is_des?
			return type == "des"
		end

		def is_id?(id)
			return @id == id
		end

		def is_from?(year)
			return @year == year
		end

		def has_acr?
			return acronyms.empty?
		end

		# SHOW METHODS
		def to_s
			return	"#{id}"
		end

		def show_acr
			aux = ""
			acronyms.each {|a| aux = aux + "\t\t#{a.to_s}\n" }
			return "\t> #{title}\n" + aux + "\n\n"
		end

		def show_acr_num
			aux = ""
			acronyms.each {|a| aux = aux + "\t\t#{a.show}\n" }
			return "\t> #{title}\n" + aux + "\n\n"
		end

		def show_all_acr
			aux = ""
			acronyms.each {|a| aux = aux + "\t\t#{a.show}\n" }
			return aux
		end

		def show
			return title
		end

		# ACRONYMS METHODS
		def contains(acronym)
			acronyms.each do |a|
				if acronym == a.acr
					return true
				end
			end
			return false
		end

		def top
			n = Math.log(acronyms.length,2)
			return acronyms[0..n]
		end

		def afinity?(paper)

		end

	# PROTECTED METHODS
	protected

		def show_sections
			aux = ""
			sections.each{|e| aux = aux + "\t\t" + e.to_s + "\n"}
			return aux
		end

end