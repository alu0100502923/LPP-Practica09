# encoding: utf-8
require 'examen'

class Interfaz
	attr_accessor :exam
	def initialize(question)
		@exam = Exam.new(question)
	end
	
	def test
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
