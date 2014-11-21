# encoding: utf-8

require 'question'

class TrueFalse < Question
	def initialize(args)
		raise ArgumentError, "Esperada pregunta (:text)" unless args.key?(:text)
		raise ArgumentError, "Esperada respuesta correcta (:right)" unless args.key?(:right)
		args[:right] = ((args[:right])?"Cierto":"Falso")
		args[:distractors] = [((args[:right])?"Falso":"Cierto")]
		super args
	end
end
