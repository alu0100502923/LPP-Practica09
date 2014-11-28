# encoding: utf-8

class Question
	attr_accessor :text, :right, :distractors, :difficulty
	
	include Comparable
	# Instancia de una Pregunta, una respuesta correcta y respuestas incorrectas.
	def initialize(args)
		@text = args[:text]
		raise ArgumentError, "Esperada pregunta (:text)" unless args[:text]
		
		@right = args[:right]
		raise ArgumentError, "Esperada respuesta correcta (:right)" unless args[:right]
		
		@distractors = args[:distractors]
		raise ArgumentError, "Esperadas respuestas incorrectas (:distractors)" unless args[:distractors]
		
		@difficulty = (args.key?:difficulty)?args[:difficulty]:1
	end
	# Definición del Método to_s.
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
	# Sobrecarga del operador <=> (Comparar dificultad entre preguntas)
	def <=>(p)
		@difficulty <=> p.difficulty
	end
	# Sobrecarga del operador == (Comparar textualmente)
	def ==(p)
		@text.eql?p.text
	end
end
