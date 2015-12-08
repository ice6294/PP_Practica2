class Main

	@@Menu =	"Hola a todos, esto es ... algo:\n" +
				"\t1) Tralala 1\n" +
				"\t2) Tralala 2\n" +
				"\t3) Tralala 3\n" +
				"\n  $: "

	loop do
		print @@Menu
		r = gets.chomp
		if r == "exit"
			break
		end
	end

end