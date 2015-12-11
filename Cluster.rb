class Cluster

	attr_accessor :acronym, :docs, :num

	def initialize()		
		@acronym = ""
		@docs = Array.new
		@num = 0
	end

	def add_doc(doc)
		docs.insert(docs.length,doc)
		@num += 1
	end

	def set_acronym
		@acronym = docs[0].acronyms[0].acr unless (num == 0 || docs[0].acronyms.empty?)
	end

	def has_acronym?
		return acronym == nil
	end

	def empty?
		return num == 0
	end

	def num_doc
		n = 0
		docs.each do |d|
			n += 1 unless d.is_des?
		end
		return n
	end

	def num_des
		n = 0
		docs.each do |d|
			n += 1 unless d.is_doc?
		end
		return n
	end

	def all_same_year
		if num == 0
			return false
		else
			year = docs[0].year
			same = true
			docs.each do |d|
				same &= (d.year == year)
			end
			return same
		end
	end

	def alone?
		return num == 1
	end

	def to_s
		aux = ""
		docs.each do |p|
			aux += "\t> #{p.title}\n"
		end
		return aux
	end

end