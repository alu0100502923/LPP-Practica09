# coding: utf-8

require "lista"

class Exam
	attr_accessor :list
	
	def initialize(p)
		@list = Lista.new(p)
	end
	
	def to_s
		"#{@list}"
	end
	
	def <<(p)
		@list << p
	end
	
	def push_back(*questions)
		questions.each { |p| @list << p}
		questions
	end 
end
