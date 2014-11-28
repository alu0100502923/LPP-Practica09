# coding: utf-8

require "lista"
#Clase para gestionar preguntas de examenes
class Exam
	attr_accessor :list
	#Inicializa la clase Exam tras recibir una pregunta.
	def initialize(p)
		@list = Lista.new(p)
	end
	#Método para mostrar los datos de Exam.
	def to_s
		"#{@list}"
	end
	#Método para insertar preguntas sobrecargando el operador <<
	def <<(p)
		@list << p
	end
	#Método para insertar varias preguntas
	def push_back(*questions)
		questions.each { |p| @list << p}
		questions
	end 
end
