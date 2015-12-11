module Utils

	# CONSTANTS
	MENU =	"\n What do you want to do?\n\n" +
			"\t1) Show titles of the articles (alphabetically ordered) published in one year.\n" +
			"\t2) Show magazines where all the articles in the collection were published.\n" +
			"\t3) Search acronym in the articles and show the titles of the ones that have it.\n" +
			"\t4) Show titles of the articles published in a given journal that contains a given acronym.\n" +
			"\t5) Show acronyms from the articles published in a given year.\n" +
			"\t6) Show acronyms with the numer of times that appears in an article from a given ID.\n" +
			"\t7) Show all IDs and titles of the articles without any acronyms.\n" +
			"\t8) Show all information from all articles.\n" +
			"\t9) Cluster articles related to the same ilness/topic.\n\n" +
			"\t(complete) -> Complete between each document the missing expansion forms of acronyms.\n" +
			"\t(docs) -> Show all the Scientific Articles.\n" +
			"\t(desc) -> Show all the Wikipedia Descriptions.\n" +
			"\t(all) -> Show one by one all the articles with the acronyms.\n"  +
			#"\t(top) -> Show most used acronyms of the articles.\n" +
			"\t(exit)\n\n"

	PROMPT = "  $: "

	BAR = "\n~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n\n"

	DIR = "docsUTF8/*"

	# METHODS
	def is_num?(str)
		!!Integer(str) rescue false
	end

end