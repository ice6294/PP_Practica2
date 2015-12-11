require './Document'
class Description < Document

	attr_reader :disease, :introduction

	def initialize (id, year, title, disease, introduction, sections, acronyms, type = "des")
		super(id, year, title, sections, acronyms, type)
		@disease = disease
		@introduction = introduction
	end

	def to_s
		return	"--------------------------------------------------------------------\n" +
				"\tTitle: #{disease.exp} (#{year})\n" +
				"\tIntroduction: #{introduction[0..180]} ...\n" +
				"\tSection number: #{sections.length}\n" +
				"\tSections:\n" + show_sections
	end

	def all
		return	"#{type.upcase} ----------------------------------------------------------------\n" +
				"\t> ID: #{id}\n" +
				"\t> Title: #{title} (#{year})\n" +
				"\t> Introduction: #{introduction[0..80]} ...\n" +
				"\t> Section number: #{sections.length}\n" +
				"\t> Sections:\n" + show_sections +
				"\t> Acronyms:\n" + show_all_acr +
				"\n--------------------------------------------------------------------\n\n"
	end

end