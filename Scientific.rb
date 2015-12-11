require './Document'
class Scientific < Document

	attr_reader :journal, :abstract

	def initialize (journal, id, year, title, abstract, sections, acronyms, type = "doc")
		super(id, year, title, sections, acronyms, type)
		@journal = journal
		@abstract = abstract
	end

	def to_s
		return	"--------------------------------------------------------------------\n" +
				"\tTitle: #{title} (#{year})\n" +
				"\tAbstract: #{abstract[0..180]} ...\n" +
				"\tSection number: #{sections.length}\n" +
				"\tSections:\n" + show_sections
	end

	def all
		return	"#{type.upcase} ----------------------------------------------------------------\n" +
				"\t> ID: #{id}\n" +
				"\t> Journal: #{journal}\n" +
				"\t> Title: #{title} (#{year})\n" +
				"\t> Abstract: #{abstract[0..80]} ...\n" +
				"\t> Section number: #{sections.length}\n" +
				"\t> Sections:\n" + show_sections +
				"\t> Acronyms:\n" + show_all_acr +
				"\n--------------------------------------------------------------------\n\n"
	end

end