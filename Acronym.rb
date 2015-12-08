class Acronym

	attr_reader :acr, :exp, :num

	def initialize(acr, exp, num)
		@acr = acr
		@exp = exp
		@num = num
	end

	def to_s
		return "#{acr} -> #{exp} (#{num})"
	end

end