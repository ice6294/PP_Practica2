class Acronym

	attr_accessor :acr, :exp, :num

	def initialize(acr, exp, num)
		@acr = acr
		@exp = exp
		@num = num
	end

	def to_s
		if exp != nil
			return "#{acr} -> #{exp}"
		else
			return "#{acr}"
		end
	end

	def show
		return "#{acr} -> #{exp} (#{num})"
	end

end