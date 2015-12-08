class Section

	attr_reader :title, :body

	def initialize(title, body)
		@title = title
		@body = body
	end

	def to_s
		return "#{title}"
	end

end