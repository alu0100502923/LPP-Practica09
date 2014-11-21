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
		acertadas = 0
		@exam.list.each do |p|
			pActual = p.to_s
			puts (i + 1).to_s + "-) " + pActual
			STDOUT.flush
			opc = pActual.match(%r{#{gets.chomp}\)\s+(.*)})[1]
			result[i] = (p.right.to_s.eql?opc)?1:0
			acertadas += 1 if (result[i] == 1)
			puts "> Respuesta #{((result[i] == 1)?"correcta":"incorrecta") + " (" + acertadas.to_s + "/" + result.size.to_s + ")"}\n\n"
			i += 1
		end
		result
	end
end
