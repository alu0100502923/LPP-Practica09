# encoding: utf-8
require 'examen'
#Clase para gestionar la interfaz.
class Interfaz
	attr_accessor :exam
	#Inicializa a partir de una pregunta.
	def initialize(question)
		@exam = Exam.new(question)
	end
	#Método que te indica las preguntas correctas(1) y incorrectas(0).
	def test(answer)
		result = Array.new(@exam.list.count, 0)
		i = 0
		@exam.list.each do |p|
			result[i] = (p.right.to_s.eql?answer[i].to_s)?1:0
			i += 1
		end
		result
	end
	#Método para mostrar la interfaz al usuario.
	def testinteractivo
		result = Array.new(@exam.list.count, 0)
		i = 0
		aciertos = 0
		@exam.list.each do |p|
			actQuestion = p.to_s
			puts (i + 1).to_s + "-) " + actQuestion
			STDOUT.flush
			opc = actQuestion.match(%r{#{gets.chomp}\)\s+(.*)})[1]
			result[i] = (p.right.to_s.eql?opc)?1:0
			aciertos += 1 if (result[i] == 1)
			puts "> Respuesta #{((result[i] == 1)?"acierto":"fallo") + " (" + aciertos.to_s + "/" + result.size.to_s + ")"}\n\n"
			i += 1
		end
		result
	end
end
