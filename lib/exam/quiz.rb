# encoding: utf-8

require "exam"
#Clase encargada de gestionar un DSL
class Quiz
	attr_accessor :exam, :count, :cabecera
	
	#Metodo de instancia de la clase Quiz
	def initialize(cabecera,&block)
		@cabecera = cabecera
		@exam = Exam.new(Question.new(:text => "Vacio", :right => "Vacio", distractors => ["Vacio"]))
		@exam.list.pop
		@count = 0
		instance_eval &block
	end
	
	#Retorna :right
	def right
		:right
	end
	
	#Retorna :wrong y el contador
	def wrong
		@count += 1
		[:wrong, @count]
	end
	
	#Añade una nueva pregunta al examen actual
	def pregunta(*args)
		distract = Array.new
		args[1].key.each { |x| distract << args[1][x] if x.class.equal? Array }
		exam << Question.new(:text => args[0], :right => args[1][:right], :distractors => distract)
		exam
	end
	
	#Metodo to_s
	def to_s
		"\s\s#{@cabecera}\n#{'#' * (@cabecera.size + 5)}\n\n#{@exam}"
	end
end