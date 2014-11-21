# encoding: utf-8

class Question
	attr_accessor :text, :right, :distractors, :difficulty
	
	include Comparable
	
	def initialize(args)
		@text = args[:text]
		raise ArgumentError, "Esperada pregunta (:text)" unless args[:text]
		
		@right = args[:right]
		raise ArgumentError, "Esperada respuesta correcta (:right)" unless args[:right]
		
		@distractors = args[:distractors]
		raise ArgumentError, "Esperadas respuestas incorrectas (:distractors)" unless args[:distractors]
		
		@difficulty = (args.key?:difficulty)?args[:difficulty]:1
	end
	
	def to_s
		opciones = @distractors + [@right]
		opciones = opciones.shuffle
		s = "#{@text}\n"
		letras = ('a'..'z').to_a[0..(opciones.size - 1)]
		i = 0
		opciones.each do |o|
			s += "#{letras[i]}) #{o}\n"
			i += 1
		end
		s
	end
	
	def <=>(p)
		@difficulty <=> p.difficulty
	end
	
	def ==(p)
		@text.eql?p.text
	end
end
